#!/usr/bin/env bash
set -euo pipefail

current_branch="$(git rev-parse --abbrev-ref HEAD)"

# Create orphan branch "gh-pages"
git checkout --orphan gh-pages
git reset --hard
git clean -fdx

uv venv
uv pip install pre-commit
uv run pre-commit install || true

# Create a dummy README.md to ensure there's something to commit
echo "# Documentation" > README.md
git add README.md

PRE_COMMIT_ALLOW_NO_CONFIG=1 git commit -m "feat: Initial commit on docs branch" --no-verify --all

# Push branch to remote
git push -u origin gh-pages 

# Return to original branch
git switch "${current_branch}"