# python_uv_template

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

#### 4. Setup and first push

```bash
git init --initial-branch=main
make install
git add .
git commit -m "feat: first commit"
git remote add origin <remote_repository_URL>
git push --set-upstream origin main
```

## Project update
1. Move inside your project and make sure that there are no local changes (in case you have local changes, commit or stash them).

2. Update your project to the latest Git tag of the template with the following command:
   ```bash
   uvx copier update --defaults
   ```
3. Resolve any conflicts and commit the changes.
