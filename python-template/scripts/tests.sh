#!/usr/bin/env bash

set -ex

uv run pytest -v

find . | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf
