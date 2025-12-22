#!/usr/bin/env bash
set -euo pipefail

current_branch="$(git rev-parse --abbrev-ref HEAD)"

# Create orphan branch "gh-pages"
git checkout --orphan gh-pages
git reset --hard
git clean -fdx

# Push branch to remote
git push -u origin gh-pages

# Return to original branch
git switch "${current_branch}"