#!/usr/bin/env bash
set -euo pipefail

current_branch="$(git rev-parse --abbrev-ref HEAD)"

# Create orphan branch "docs"
git checkout --orphan docs
git reset --hard
git clean -fdx

# Create GitHub Actions workflows directory
mkdir -p .github/workflows

# Write CI workflow
cat > .github/workflows/ci.yml <<'EOF'
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Install uv
        uses: astral-sh/setup-uv@v7
    - name: Set up Python
      run: uv python install
    - name: Install dependencies
      run: uv sync
    - name: Run tests
      run: uv run pytest
    - name: Run linting
      run: uv run ruff check
    - name: Run type checking
      run: uv run mypy src tests
EOF

# Write release workflow
cat > .github/workflows/release.yml <<'EOF'
name: Release

on:
  push:
    tags:
      - 'v*'

permissions:
  contents: write

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - name: Install uv
        uses: astral-sh/setup-uv@v7
    - name: Set up Python
      run: uv python install
    - name: Install dependencies
      run: uv sync
    - name: Create GitHub release
      run: |
        VERSION=${GITHUB_REF#refs/tags/v}
        uv run cz changelog $VERSION --dry-run > changelog.md
        gh release create $GITHUB_REF_NAME --title "Release $GITHUB_REF_NAME" --notes-file changelog.md
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
EOF

# Write docs deployment workflow
cat > .github/workflows/docs.yml <<'EOF'
name: Deploy Docs

on:
  push:
    branches: [ docs ]

permissions:
  contents: write

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
      with:
        fetch-depth: 0
    - name: Install uv
        uses: astral-sh/setup-uv@v7
    - name: Set up Python
      run: uv python install
    - name: Install dependencies
      run: uv sync
    - name: Configure Git
      run: |
        git config user.name github-actions
        git config user.email github-actions@github.com
    - name: Deploy docs
      run: |
        uv run mike deploy --push --update-aliases latest
        uv run mike set-default --push latest
EOF

uv venv
uv pip install pre-commit
uv run pre-commit install || true

git add .github/workflows/
PRE_COMMIT_ALLOW_NO_CONFIG=1 git commit -m "feat: Initial commit on docs branch with GitHub Actions workflows" --no-verify

# Push branch to remote
git push -u origin docs

# Return to original branch
git switch "${current_branch}"