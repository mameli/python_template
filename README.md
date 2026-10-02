# Python Data Project Template (`python_uv_template`)

A Copier template for bootstrapping modern Python data projects with a reproducible, production-ready workflow: `uv`, `ruff`, `ty`, tests, docs, releases, optional Docker, and a Marimo playground.

If you want the full rationale and trade-offs behind this stack, read the companion article: [A Modern Python Stack for Data Projects](https://www.mameli.dev/blog/modern-data-python-stack/).

> [!TIP]
> **Using a coding agent?** Give it this repository URL and a prompt like the one below. The [For AI agents](#for-ai-agents) section has everything it needs to scaffold the project without interactive prompts.
>
> ```text
> Create a new Python project named "<project name>" from the template at
> https://github.com/mameli/python_template. Follow the "For AI agents"
> section of its README.
> ```

## Why this template
- Start fast with a clean `src/` layout and starter modules.
- Keep quality automated with linting, formatting, typing, and tests (`make check`).
- Use reproducible environments and lockfiles for reliable builds.
- Publish docs and releases with built-in helper scripts and Make targets.
- Ship an `AGENTS.md` in every generated project so coding agents know the layout and commands from the start.

## Technology stack
- [Copier](https://copier.readthedocs.io/) for project scaffolding and updateable generation.
- [uv](https://docs.astral.sh/uv/) for dependency management, virtual environments, lockfiles, and packaging via `uv_build`.
- [ruff](https://docs.astral.sh/ruff/) for linting and formatting.
- [ty](https://docs.astral.sh/ty/) for type checking.
- `pre-commit` to run hooks before commits.
- `pytest` and `pytest-cov` for tests and coverage.
- [Marimo](https://marimo.io/) for reactive, reproducible notebooks stored as Python files.
- [Polars](https://docs.pola.rs/) for fast DataFrame work.
- [DuckDB](https://duckdb.org/) for in-process analytical SQL queries.
- [Seaborn](https://seaborn.pydata.org/) for quick statistical visualization.
- [MkDocs](https://www.mkdocs.org/) for documentation, themed with Material and extended via mkdocstrings for API docs, mkdocs-gen-files for generated pages, mkdocs-literate-nav for Markdown-driven navigation, mkdocs-section-index for clickable section indexes, mkdocs-autorefs for cross-page references, pymdown-extensions for richer Markdown, and mike for versioned docs publishing.
- [Docker](https://www.docker.com/) for containerized builds.
- [Commitizen](https://commitizen-tools.github.io/commitizen/) for Conventional Commits, versioning, and changelog automation.
- `AGENTS.md.jinja` to generate a project-specific `AGENTS.md` during scaffolding and keep coding-agent instructions consistent across projects.

## Requirements
- Python `>=3.12,<3.15` (uv can install it for you).
- [`uv`](https://docs.astral.sh/uv/getting-started/installation/), latest version recommended (`uv self update`).
- `git` and `make`.

## Quick start
### 1. Create the project folder

```bash
mkdir -p <project_name>
cd <project_name>
```

### 2. Install [`uv`](https://github.com/astral-sh/uv)

Installation instructions are [here](https://docs.astral.sh/uv/getting-started/installation/).
It's recommended to install the latest version from [github releases](https://github.com/astral-sh/uv/releases).

If you have already installed `uv`, please ensure you're using the latest version by running `uv self update`.

### 3. Create the project using [copier](https://github.com/copier-org/copier):

Launch the following command and answer carefully to the prompts:

```bash
uvx copier copy https://github.com/mameli/python_template.git .
```

> [!IMPORTANT]
> Copier always generates a `.copier-answers.yml` file. Commit the file with the other files and **never** change it manually.

### 4. Setup and first push

> [!IMPORTANT]
> `git init` must run before `make install` — `make install` installs pre-commit hooks, which require a Git repository.

```bash
git init --initial-branch=main
make install
make check
git add .
git commit -m "feat: first commit"
git remote add origin <remote_repository_URL>
git push --set-upstream origin main
```

## For AI agents

This section is written for coding agents (Claude Code, Codex, Cursor, etc.) asked to create a project from this template. Follow the steps in order and do not run Copier interactively.

### Template variables

| Variable | Required | Default | Notes |
| --- | --- | --- | --- |
| `package_name` | yes | — | Human-readable name, e.g. `My Data Project`. Becomes the slug `my-data-project` and the import package `my_data_project`. |
| `github_username` | yes | — | GitHub user or organization that will own the repo. Used in docs and remote URLs. |
| `project_description` | no | `A python project` | One-line description written to `pyproject.toml` and the README. |

If the user did not give you `package_name` or `github_username`, ask before generating. Do not invent them.

### Steps

1. **Check prerequisites.** `uv --version`, `git --version`, `make --version`. If `uv` is missing, ask the user before installing it.
2. **Create and enter an empty target directory** (skip if the user is already in one):
   ```bash
   mkdir -p <project-slug> && cd <project-slug>
   ```
3. **Generate the project non-interactively:**
   ```bash
   uvx copier copy --defaults \
     --data package_name="<Package Name>" \
     --data github_username="<github-user>" \
     --data project_description="<One-line description>" \
     https://github.com/mameli/python_template.git .
   ```
   `--defaults` stops Copier from prompting; every required variable must be passed with `--data`.
4. **Initialize Git before installing.** Pre-commit hooks need a repository:
   ```bash
   git init --initial-branch=main
   ```
5. **Install and verify:**
   ```bash
   make install   # uv sync + pre-commit install
   make check     # ruff lint, ty type-check, pytest
   ```
   `make check` must pass on a fresh project. If it fails, report the output instead of editing generated files to silence it.
6. **First commit:**
   ```bash
   git add .
   git commit -m "feat: first commit"
   ```
7. **Remote and push only if the user asks.** Creating a GitHub repo or pushing is outward-facing:
   ```bash
   git remote add origin https://github.com/<github-user>/<project-slug>.git
   git push --set-upstream origin main
   ```

### Rules
- Never edit `.copier-answers.yml` by hand; commit it. Copier needs it for future updates.
- After generation, read the project's own `AGENTS.md` for layout, commands, and coding conventions.
- Use `uv add <pkg>` / `uv add --dev <pkg>` for dependencies, never `pip install`.
- Run `make format` then `make check` before every commit.
- Commits follow [Conventional Commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`, `chore:`, ...).

### What gets generated

```text
<project-slug>/
├── AGENTS.md              # instructions for coding agents in the generated project
├── Makefile               # install, format, lint, type-check, tests, check, build, docs, docker-build
├── pyproject.toml         # deps, ruff, ty, pytest, commitizen config
├── src/<package_slug>/    # package code (main.py, example.py)
├── tests/                 # pytest suite
├── playground/            # Marimo notebooks
├── docs/ + mkdocs.yml     # MkDocs Material site
├── scripts/               # helpers called by the Makefile (incl. docker/)
└── .copier-answers.yml    # template answers, needed for `copier update`
```

### Updating an existing project
From the project root, with a clean working tree:

```bash
uvx copier update --defaults
make check
```

Resolve any conflict markers Copier leaves, then commit with `chore: update template`.

## Update an existing project
1. Move inside your project and make sure that there are no local changes (in case you have local changes, commit or stash them).

2. Update your project to the latest Git tag of the template with the following command:
   ```bash
   uvx copier update --defaults
   ```
3. Resolve any conflicts and commit the changes.
