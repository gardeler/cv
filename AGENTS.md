# Agent Instructions

## Project Overview

This repository is based on Awesome CV and is used to build a private German CV.

- Public template and layout files live in the repository root.
- Personal CV data lives under `private/`.
- `private/` is intentionally ignored by Git and must stay private.
- The main private document is `private/cv.tex`.
- Private section content is split across `private/cv/*.tex`.
- The generated private PDF is `private/cv.pdf`.

## Important Files

- `awesome-cv.cls`: base Awesome CV class with local project edits.
- `awesome-cv-custom.sty`: project-specific style overrides.
- `Makefile`: build commands for examples and the private CV.
- `.vscode/tasks.json`: VS Code build task for the private CV.
- `private/cv.tex`: private CV entrypoint.
- `private/me.jpg`: profile photo used by the private CV.

## Build

Use this command from the repository root:

```sh
make private-cv
```

This builds:

```text
private/cv.pdf
```

The Makefile sets the required TeX environment:

- `TEXINPUTS=.:..//:` so files in the repository root are found from `private/`.
- `TEXMFVAR=/private/tmp/codex-texmf-var` so LuaLaTeX has a writable font cache.
- `TEX_ENGINE=/usr/local/texlive/2026/bin/universal-darwin/lualatex` by default.

To force a rebuild:

```sh
make -B private-cv
```

In VS Code, use the build task:

```text
Terminal > Run Build Task
```

or `Cmd+Shift+B`. The task is named `Build private CV PDF`.

## Privacy Rules

- Do not commit or move files from `private/`.
- Do not print personal contact details in summaries unless the user asks.
- Treat files in `private/` as local working data only.
- Build artifacts such as `private/cv.aux` and `private/cv.log` can be regenerated.

## Layout Rules

- Prefer style changes in `awesome-cv-custom.sty`.
- Only edit `awesome-cv.cls` when the class itself must change.
- Keep the private CV compact enough to remain at 2 pages unless the user explicitly accepts more pages.
- After layout or content changes, run `make private-cv`.
- The current small header `Overfull \hbox` warning is known and has been tolerated.

## Current Style Notes

- The accent color is defined as `sourcepurple` in `awesome-cv-custom.sty`.
- Current accent color: `#250070`.
- Body, bullet, and skill text use Lato at `10pt` with `13pt` line height.
- Date ranges use `9pt`.
- Bullet lists use a custom `cvitems` environment with a controlled right margin.
- Custom job entries use `\jobentry` and `\jobentryheading`.
- Education entries use `\educationentry`.

## Content Conventions

- The CV language is German, with English job titles where intentional.
- Use German compound hyphenation where appropriate:
  - `Backend-Feature- und Unit-Tests`
  - `Frontend-E2E-Tests`
  - `Payment-Provider`
  - `PHP-Programmierer`
  - `Frontend-Entwickler`
  - `Flash- & Web-Entwickler`
  - `Flash- & Web-Designer`
- Prefer `Vektor-DBs` and `Pinecone`.

## Git Safety

- The working tree may contain unstashed user changes.
- Do not revert user changes unless explicitly requested.
- Keep edits scoped to the user request.
- Use `git status --short` before summarizing changed tracked files.
