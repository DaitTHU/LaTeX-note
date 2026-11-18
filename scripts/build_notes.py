#!/usr/bin/env python3
"""Build selected notes with XeLaTeX, including external figure labels."""  # noqa: EXE001

import argparse
import re
import shutil
import subprocess
import sys
from pathlib import Path
from tempfile import TemporaryDirectory
from zipfile import ZIP_DEFLATED, ZipFile

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


def build(source: Path):
    print(f"Building {source.relative_to(ROOT)}", flush=True)
    result = subprocess.run(
        ["latexmk", "-xelatex", "-interaction=nonstopmode", "-halt-on-error",
         "-file-line-error", source.name],
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


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("notes", nargs="*", metavar="NOTE",
                        help="course code(s): " + ", ".join(NOTES) + "; default: all")
    parser.add_argument("--archive", type=Path, metavar="ZIP",
                        help="package the selected course PDFs in a ZIP file")
    args = parser.parse_args()
    if args.archive and args.archive.suffix.lower() != ".zip":
        parser.error("--archive requires a .zip filename")
    for name in args.notes:
        if name not in NOTES:
            parser.error(f"unknown course {name!r}; choose from {', '.join(NOTES)}")
    if not shutil.which("latexmk") or not shutil.which("xelatex"):
        parser.error("latexmk and xelatex are required (TeX Live or MacTeX)")
    course_pdfs = []
    for name in dict.fromkeys(args.notes or NOTES):
        directory = ROOT / NOTES[name]
        atlas = directory / "figures/tikz.tex"
        if name == "CA":
            build(atlas)
            continue
        if atlas.is_file():
            build(atlas)
        source = directory / f"{name}.tex"
        build(source)
        course_pdfs.append(source.with_suffix(".pdf"))
        if name == "QM":
            build(directory / "ref/QM.tex")
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
