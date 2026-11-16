#!/usr/bin/env python3
"""Build selected notes with XeLaTeX, including external figure labels."""

import argparse
from pathlib import Path
import re
import shutil
import subprocess
import sys


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
}


def build(source):
    print(f"Building {source.relative_to(ROOT)}", flush=True)
    result = subprocess.run(
        ["latexmk", "-xelatex", "-interaction=nonstopmode", "-halt-on-error",
         "-file-line-error", source.name],
        cwd=source.parent, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
        text=True, errors="replace",
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


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("notes", nargs="*", metavar="NOTE",
                        help="course code(s): " + ", ".join(NOTES) + "; default: all")
    args = parser.parse_args()
    for name in args.notes:
        if name not in NOTES:
            parser.error(f"unknown course {name!r}; choose from {', '.join(NOTES)}")
    if not shutil.which("latexmk") or not shutil.which("xelatex"):
        parser.error("latexmk and xelatex are required (TeX Live or MacTeX)")
    for name in dict.fromkeys(args.notes or NOTES):
        directory = ROOT / NOTES[name]
        # These two notes select PDF pages using xr-hyper's external labels.
        if name in {"ED", "NA"}:
            build(directory / "figures/tikz/layouts.tex")
        build(directory / f"{name}.tex")
        print(f"OK: {directory / (name + '.pdf')}", flush=True)


if __name__ == "__main__":
    try:
        main()
    except RuntimeError as error:
        sys.exit(str(error))
