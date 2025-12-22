#!/bin/bash

set -e

echo "Retrieving current project version..."
VERSION=$(uv run cz version --project)
echo "Current version: ${VERSION}"

echo "Generate full changelog"
uv run cz changelog

# This command is mandatory to have gh-pages branch updated.
echo "List documentation versions..."
uv run mike list

echo "Deploying ${VERSION} as 'latest' version using mike..."
uv run mike deploy --branch gh-pages --push "${VERSION}" latest --update-aliases --alias-type=copy
echo "Ensure default version is set to 'latest'..."
uv run mike set-default --branch gh-pages --push latest
echo 'OK'