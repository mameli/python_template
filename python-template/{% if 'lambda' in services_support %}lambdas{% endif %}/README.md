In this folder, there should be one Lambda function for each directory. 
All Lambda functions belong to the uv workspace implicitly created with the `tool.uv.workspace` table in root *pyproject.toml* file.
Please note that:
- `uv lock` operates on the entire uv workspace at once;
- `uv run` and `uv sync` operate on the workspace root by default, though both accept a `--package` argument, allowing you to run a command in a particular workspace member from any workspace directory.
