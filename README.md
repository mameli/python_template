# Python Data Project Template (`python_uv_template`)

A Copier template for bootstrapping modern Python data projects with a reproducible, production-ready workflow: `uv`, `ruff`, `ty`, tests, docs, releases, optional Docker, and a Marimo playground.

If you want the full rationale and trade-offs behind this stack, read the companion article: [A Modern Python Stack for Data Projects](https://www.mameli.dev/blog/modern-data-python-stack/).

## Why this template
- Start fast with a clean `src/` layout and starter modules.
- Keep quality automated with linting, formatting, typing, and tests (`make check`).
- Use reproducible environments and lockfiles for reliable builds.
- Publish docs and releases with built-in helper scripts and Make targets.

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

```bash
git init --initial-branch=main
make install
make check
git add .
git commit -m "feat: first commit"
git remote add origin <remote_repository_URL>
git push --set-upstream origin main
```

## Update an existing project
1. Move inside your project and make sure that there are no local changes (in case you have local changes, commit or stash them).

2. Update your project to the latest Git tag of the template with the following command:
   ```bash
   uvx copier update --defaults
   ```
3. Resolve any conflicts and commit the changes.
