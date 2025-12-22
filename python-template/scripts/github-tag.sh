#!/usr/bin/env bash

set -e

uv run cz bump

VERSION="$(uv run cz version --project)"
TAG="v${VERSION}"

CHANGELOG="$(uv run cz changelog "${VERSION}" --dry-run 2>&1 || echo "Release ${TAG}")"

echo "Creating tag ${TAG}..."
git tag -a "${TAG}" -m "Release ${TAG}" -m "${CHANGELOG}"

echo "Pushing ${TAG} to origin..."
git push origin "${TAG}"

echo "Tag ${TAG} created and pushed successfully."