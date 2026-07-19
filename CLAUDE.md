# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

Anti-spam Telegram bot for https://t.me/Gentoogram. Python 3.14, `python-telegram-bot` (webhooks),
Dynaconf config, Sentry. The package lives in `gentoogram/`, and runs as a Docker Compose stack
under `docker/`.

## Dev workflow

- `make setup`: `uv sync --all-groups` and install prek git hooks.
- `make lint`: `uv run prek run --all-files` (ruff, hadolint, etc., configured in `prek.toml`).
- `make run`: `docker compose -f docker/compose.yaml up --build`.
- `make clean`: tear down containers/volumes and remove caches.

## Releases

- Git tags are bare version numbers (`0.10.1`), never a `v` prefix.
- Version bumps update every file that declares the version and regenerate
  every lockfile that goes with it, across all package managers in the repo.
- The bump is always its own isolated commit + tag containing only those
  files, made after the commits being released, and never mixed with
  other changes.

## Python conventions

- `from module import Name`, not `import module` + `module.Name` at call
  sites, including type annotations. Import needed submodules directly with
  an alias rather than keeping the top-level package import.
- No single-character variable names anywhere, including loop and
  comprehension variables. Name caught exceptions `exc`, never `e`.
- f-strings for all interpolation, including logging calls, never %-style.
- Don't manually sort or group imports: ruff handles it. Ignore IDE
  import-sort warnings.
- Don't flag or "fix" unusual-looking syntax that already exists (e.g.
  `except A, B:`). If it runs, it's valid here.
- New source files carry the project's license header, matching the exact
  format used by existing files in the repo (SPDX or otherwise). In shell
  scripts, separate the header block from the shebang and the following code
  with a blank line on each side.
- Install dependencies with `uv sync`, update them with
  `uv sync --upgrade --all-groups`.
