# TU Wien Diplomarbeit template

A LaTeX template for a TU Wien master's thesis (Diplomarbeit). The title page
and the required front matter follow the TU Wien (NumPDEs group) template; the
usage workflow follows the FIT BUT template: you fill in one configuration block
and write the body in a single file.

## Files

| File              | Purpose                                                        |
| ----------------- | -------------------------------------------------------------- |
| `thesis.tex`      | **The only config file.** All thesis details go in here.       |
| `thesis.cls`      | Document class (layout + title page). Normally unchanged.      |
| `content.tex`     | The body of the thesis (your chapters).                        |
| `appendix.tex`    | Appendices (optional; disabled by default).                    |
| `bibliography.bib`| Your references (BibLaTeX / biber).                            |
| `macros.sty`      | Handy math macros; add your own here.                          |
| `figures/`        | Images, including `TULogo.pdf`.                                |

## How to use

1. Open `thesis.tex` and fill in the `\projectinfo{...}` block: title, author,
   Matrikelnummer, address, institute, supervisor, place, date, the German
   **Kurzfassung**, the English **Abstract**, an optional **Danksagung**
   (leave `acknowledgement` empty to skip that page), and the German
   **Eidesstattliche Erklärung** (adapt the AI-tools sentence to reality).
2. Write your thesis in `content.tex`.
3. Add references to `bibliography.bib`.
4. Appendices are **optional and off by default**. To use them, uncomment the
   `\appendix` and `\input{appendix}` lines in `thesis.tex` and edit
   `appendix.tex`.

The front matter is produced by a single command, `\makefrontmatter`, in the
order required by TU Wien: title page → Kurzfassung → Abstract → Danksagung
(optional) → Eidesstattliche Erklärung.

## Repository and Overleaf import

This folder is a git repository (build artifacts are ignored via `.gitignore`).
Two ways to get it into Overleaf:

* **Zip upload:** in Overleaf choose *New Project → Upload Project* and select
  the zip of this folder (files must sit at the zip root, not inside a
  subfolder). Build the zip from the repo root with `git archive`, which
  includes exactly the tracked files (no `.git`, no build artifacts):

  ```sh
  git archive --format=zip -o ../TU_Wien_thesis_template.zip HEAD
  ```

  Without git, in PowerShell (excludes the `.git` folder):

  ```powershell
  Get-ChildItem -Force | Where-Object Name -ne '.git' |
    Compress-Archive -DestinationPath ..\TU_Wien_thesis_template.zip -Force
  ```

* **Git:** push this repo to GitHub/GitLab and use Overleaf's Git integration,
  or pull/push directly with Overleaf's own git remote.

After import, set **Compiler = pdfLaTeX** and **Main document = `thesis.tex`**.

## Building

Uses `pdflatex` + `biber`:

```
pdflatex thesis
biber thesis
pdflatex thesis
pdflatex thesis
```

On Overleaf, set the compiler to **pdfLaTeX** and the main document to
`thesis.tex` (biber is detected automatically). Tested with TeX Live 2025.

## Language

The body is English by default. Change the language in `thesis.tex` via
`\selectlanguage{english}` / `\selectlanguage{ngerman}`. The Kurzfassung, the
Eidesstattliche Erklärung and the word *DIPLOMARBEIT* on the title page are
always German, as required.

## Print / export settings

These are the options in the `\documentclass[...]{thesis}` line at the top of
`thesis.tex`. Edit that bracketed list to switch behaviour:

| What you want                                | What to do                                    |
| -------------------------------------------- | --------------------------------------------- |
| On-screen reading / PDF submission (default) | leave `oneside`                               |
| Double-sided print (left/right binding shift)| replace `oneside` with `twoside`              |
| Black hyperlinks for printing                | add `print`, e.g. `[...,oneside,print]`       |
| Final bound printout                         | use both, e.g. `[...,twoside,print]`          |

The binding shift on `twoside` leaves room for the binding (`BCOR=8mm`, set in
`thesis.cls`).
