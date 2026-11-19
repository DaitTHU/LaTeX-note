#!/usr/bin/env python3
"""Build selected notes with XeLaTeX, including external figure labels."""  # noqa: EXE001

import argparse
import hashlib
import json
import os
import re
import shutil
import subprocess
import sys
from pathlib import Path
from tempfile import TemporaryDirectory
from zipfile import ZIP_DEFLATED, BadZipFile, ZipFile

ROOT = Path(__file__).resolve().parents[1]
NOTES = {
    "Calc": "Calculus",
    "LA": "Linear Algebra",
    "PS": "Probability and Statistics",
    "MMP": "Method of Mathematics and Physics",
    "NA": "Numerical Analysis",
    "CM": "Classical Mechanics",
    "QM": "Quantum Mechanics",
    "SM": "Statistical Mechanics",
    "ED": "Electrodynamics",
    "NRD": "Nuclear Radiation and Detection",
    "CA": "Complex Analysis",  # This collection has only a standalone figure.
}


def input_hashes(paths):
    hashes = {}
    for name in paths:
        path = ROOT / name
        if Path(name).is_absolute() or ".." in Path(name).parts or not path.resolve().is_relative_to(ROOT):
            raise ValueError(f"Invalid cached input: {name}")
        hashes[name] = hashlib.sha256(path.read_bytes()).hexdigest()
    return hashes


def recorded_inputs(source):
    inputs, outputs = set(), set()
    for line in source.with_suffix(".fls").read_text(encoding="utf-8").splitlines():
        mode, _, filename = line.partition(" ")
        if mode not in {"INPUT", "OUTPUT"}:
            continue
        recorded = source.parent / filename
        path = recorded.resolve()
        if path.is_relative_to(ROOT):
            if Path(os.path.abspath(recorded)) != path:
                raise ValueError(f"Symlink in recorded input: {filename}")
            (inputs if mode == "INPUT" else outputs).add(path)
        elif not Path(filename).is_absolute():
            raise ValueError(f"Input outside checkout: {filename}")
    if source not in inputs:
        raise ValueError(f"Recorder did not report {source}")
    if source.with_suffix(".idx") in outputs:
        outputs.add(source.with_suffix(".ind"))
    dependencies = (inputs - outputs) | {Path(__file__).resolve()}
    return input_hashes(sorted(str(p.relative_to(ROOT)) for p in dependencies))


def restore(source, entry, outputs):
    try:
        with ZipFile(entry) as archive:
            manifest = json.loads(archive.read("manifest.json"))
            hashes = manifest["inputs"]
            required = {str(source.relative_to(ROOT)), str(Path(__file__).resolve().relative_to(ROOT))}
            if not isinstance(hashes, dict) or not required.issubset(hashes):
                return False
            if input_hashes(hashes) != hashes:
                return False
            with TemporaryDirectory(dir=source.parent) as temporary:
                for output in outputs:
                    data = archive.read(output.name)
                    if hashlib.sha256(data).hexdigest() != manifest["outputs"][output.name]:
                        return False
                    (Path(temporary) / output.name).write_bytes(data)
                for output in outputs:
                    (Path(temporary) / output.name).replace(output)
        return True
    except (OSError, BadZipFile, ValueError, KeyError, TypeError, RuntimeError):
        return False


def save(source, entry, outputs):
    try:
        inputs = recorded_inputs(source)
        entry.parent.mkdir(parents=True, exist_ok=True)
        with TemporaryDirectory(dir=entry.parent) as temporary:
            staged = Path(temporary) / "entry.zip"
            with ZipFile(staged, "w") as archive:
                digests = {}
                for output in outputs:
                    data = output.read_bytes()
                    digests[output.name] = hashlib.sha256(data).hexdigest()
                    archive.writestr(output.name, data)
                archive.writestr("manifest.json", json.dumps({"inputs": inputs, "outputs": digests}))
            staged.replace(entry)
    except (OSError, ValueError) as error:
        print(f"Skipping cache for {source.name}: {error}", file=sys.stderr)


def build(source: Path, cache_dir=None):
    entry = None
    outputs = [source.with_suffix(".pdf")]
    if source.name == "tikz.tex":
        outputs.append(source.with_suffix(".aux"))
    if cache_dir is not None:
        candidate = cache_dir / source.relative_to(ROOT).with_suffix(".zip")
        if candidate.resolve().is_relative_to(cache_dir) and source.parent.resolve().is_relative_to(ROOT):
            entry = candidate
        if entry and restore(source, entry, outputs):
            print(f"Reused {source.relative_to(ROOT)}", flush=True)
            return
    print(f"Building {source.relative_to(ROOT)}", flush=True)
    command = ["latexmk", "-xelatex", "-interaction=nonstopmode", "-halt-on-error", "-file-line-error"]
    if cache_dir:
        command.append("-g")
    result = subprocess.run(
        [*command, source.name],
        cwd=source.parent, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
        text=True, errors="replace", check=False
    )
    transcript = source.with_suffix(".build.log")
    transcript.write_text(result.stdout, encoding="utf-8")
    if result.returncode:
        print("\n".join(result.stdout.splitlines()[-45:]), file=sys.stderr)
        raise RuntimeError(f"Compilation failed; see {transcript}")
    log = source.with_suffix(".log").read_text(encoding="utf-8", errors="replace")
    problems = re.findall(
        r"^.*(?:undefined references|undefined citations|multiply-defined labels|"
        r"Missing character:).*$", log, re.MULTILINE,
    )
    if problems:
        raise RuntimeError(f"{source}:\n" + "\n".join(problems))
    print(f"OK: {source.with_suffix('.pdf')}", flush=True)
    if entry:
        save(source, entry, outputs)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("notes", nargs="*", metavar="NOTE",
                        help="course code(s): " + ", ".join(NOTES) + "; default: all")
    parser.add_argument("--archive", type=Path, metavar="ZIP",
                        help="package the selected course PDFs in a ZIP file")
    parser.add_argument("--cache-dir", type=Path, metavar="DIR",
                        help="reuse outputs in a cache scoped to the toolchain and source file list")
    args = parser.parse_args()
    if args.archive and args.archive.suffix.lower() != ".zip":
        parser.error("--archive requires a .zip filename")
    for name in args.notes:
        if name not in NOTES:
            parser.error(f"unknown course {name!r}; choose from {', '.join(NOTES)}")
    if not shutil.which("latexmk") or not shutil.which("xelatex"):
        parser.error("latexmk and xelatex are required (TeX Live or MacTeX)")
    course_pdfs = []
    cache_dir = args.cache_dir.resolve() if args.cache_dir else None
    for name in dict.fromkeys(args.notes or NOTES):
        directory = ROOT / NOTES[name]
        atlas = directory / "figures/tikz.tex"
        if name == "CA":
            build(atlas, cache_dir)
            continue
        if atlas.is_file():
            build(atlas, cache_dir)
        source = directory / f"{name}.tex"
        build(source, cache_dir)
        course_pdfs.append(source.with_suffix(".pdf"))
        if name == "QM":
            build(directory / "ref/QM.tex", cache_dir)
    if args.archive:
        if not course_pdfs:
            parser.error("the selected collection has no course PDF to archive")
        with TemporaryDirectory(dir=args.archive.parent) as temporary:
            package = Path(temporary) / "course-notes.zip"
            with ZipFile(package, "w", ZIP_DEFLATED) as archive:
                for pdf in course_pdfs:
                    archive.write(pdf, pdf.relative_to(ROOT))
            package.replace(args.archive)
        print(f"Packaged {len(course_pdfs)} course PDFs in {args.archive}", flush=True)


if __name__ == "__main__":
    try:
        main()
    except RuntimeError as error:
        sys.exit(str(error))
