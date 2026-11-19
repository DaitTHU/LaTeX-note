"""Restore and save course figures around the CI MATLAB step."""

import argparse
import hashlib
import json
import os
import shutil
import subprocess
from collections.abc import Callable, Collection
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def checksum(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def add_tree(update: Callable[[bytes], None], directory: Path) -> None:
    for path in sorted(directory.rglob("*")):
        if path.is_file():
            update(path.relative_to(ROOT).as_posix().encode() + b"\0")
            update(bytes.fromhex(checksum(path)))


def figure_name(name: str) -> bool:
    return (Path(name).name == name and name != "tikz.pdf"
            and Path(name).suffix in (".pdf", ".png"))


def require_generated(directory: Path, names: Collection[str]) -> None:
    """Never restore over source files or follow a link out of the figure directory."""
    if not names or not all(figure_name(name) for name in names):
        raise ValueError("expected plain PDF or PNG figure filenames")
    paths = [directory / name for name in names]
    if directory.resolve() != directory or any(p.is_symlink() for p in paths):
        raise ValueError(f"unexpected symlink in {directory}")
    relative = {p.relative_to(ROOT).as_posix() for p in paths}
    result = subprocess.run(["git", "check-ignore", "-z", "--stdin"], cwd=ROOT,
                            input=b"\0".join(os.fsencode(p) for p in relative) + b"\0",
                            stdout=subprocess.PIPE, check=False)
    if result.returncode not in (0, 1):
        result.check_returncode()
    ignored = set(os.fsdecode(result.stdout).split("\0"))
    if relative - ignored:
        raise ValueError(f"expected only untracked, gitignored figures: {relative - ignored}")


def snapshot(directory: Path) -> dict[str, list[int]]:
    """Identify outputs written by this build, even in a previously built checkout."""
    stats = {}
    for path in directory.iterdir():
        if figure_name(path.name) and path.is_file():
            s = path.stat()
            stats[path.name] = [s.st_ino, s.st_size, s.st_mtime_ns, s.st_ctime_ns]
    return stats


def restore_course(slot: Path, directory: Path, fingerprint: str) -> bool:
    try:
        manifest = json.loads((slot / "manifest.json").read_text(encoding="utf-8"))
        if manifest["source"] != fingerprint:
            return False
        files = manifest["outputs"]
        require_generated(directory, files)
        for name, expected in files.items():
            path = slot / name
            if path.is_symlink() or not path.stat().st_size or checksum(path) != expected:
                return False
    except (OSError, ValueError, KeyError, TypeError, AttributeError):
        return False
    for name in files:
        shutil.copyfile(slot / name, directory / name)
    return True


def restore(cache: Path, state: Path) -> None:
    common = hashlib.sha256(Path(__file__).read_bytes())
    add_tree(common.update, ROOT / "figures/matlab")
    pending = {}
    for sources in sorted(ROOT.glob("*/figures/matlab")):
        directory = sources.parent
        course = directory.parent.name
        digest = common.copy()
        add_tree(digest.update, sources)
        fingerprint = digest.hexdigest()
        if restore_course(cache / course, directory, fingerprint):
            print(f"Restored MATLAB figures: {course}")
        else:
            print(f"Rendering MATLAB figures: {course}")
            pending[course] = {"source": fingerprint, "before": snapshot(directory)}
    state.write_text(json.dumps(pending), encoding="utf-8")
    if output := os.environ.get("GITHUB_OUTPUT"):
        with open(output, "a", encoding="utf-8") as file:
            print("courses=" + "|".join(pending), file=file)


def save(cache: Path, state: Path) -> None:
    pending = json.loads(state.read_text(encoding="utf-8"))
    for course, record in pending.items():
        directory = ROOT / course / "figures"
        outputs = [name for name, stamp in snapshot(directory).items()
                   if record["before"].get(name) != stamp]
        require_generated(directory, outputs)
        slot = cache / course
        manifest = slot / "manifest.json"
        if slot.is_symlink() or manifest.is_symlink():
            raise ValueError(f"unexpected symlink in {slot}")
        slot.mkdir(parents=True, exist_ok=True)
        files = {}
        for name in sorted(outputs):
            if not (directory / name).stat().st_size:
                raise ValueError(f"empty figure: {directory / name}")
            target = slot / name
            if target.is_symlink():
                target.unlink()
            shutil.copyfile(directory / name, target)
            files[name] = checksum(target)
        manifest.write_text(
            json.dumps({"source": record["source"], "outputs": files}), encoding="utf-8")
        for old in slot.iterdir():
            if figure_name(old.name) and old.name not in files and (old.is_file() or old.is_symlink()):
                old.unlink()
        print(f"Cached {len(files)} MATLAB figures: {course}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("operation", choices=("restore", "save"))
    parser.add_argument("cache", type=Path)
    args = parser.parse_args()
    cache = args.cache.resolve()
    if cache.is_relative_to(ROOT) or cache in ROOT.parents:
        parser.error("use a dedicated CI cache directory outside the checkout")
    cache.parent.mkdir(parents=True, exist_ok=True)
    # This run's snapshot is separate from the persistent Actions cache.
    state = cache.with_name(cache.name + ".pending.json")
    if args.operation == "restore":
        restore(cache, state)
    else:
        save(cache, state)


if __name__ == "__main__":
    main()
