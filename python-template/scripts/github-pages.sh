#!/bin/bash

set -e

echo "Retrieving current project version..."
VERSION=$(uv run cz version --project)
echo "Current version: ${VERSION}"

echo "Generate full changelog"
uv run cz changelog

current_branch="$(git rev-parse --abbrev-ref HEAD)"

# Create orphan branch "gh-pages"
git checkout --orphan gh-pages
git reset --hard
git clean -fdx

# Push branch to remote
git push -u origin gh-pages

# Return to original branch
git switch "${current_branch}"

# This command is mandatory to have gh-pages branch updated.
echo "List documentation versions..."
uv run mike list

echo "Deploying ${VERSION} as 'latest' version using mike..."
uv run mike deploy --branch docs --deploy-prefix public --push "${VERSION}" latest --update-aliases --alias-type=copy
echo "Ensure default version is set to 'latest'..."
uv run mike set-default --branch docs --deploy-prefix public --push latest
echo 'OK'