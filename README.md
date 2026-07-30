# General template

A simple and extensible project template for development, based on [dev containers](https://containers.dev/). Development happens entirely inside a container, keeping the environment reproducible and preventing tooling from leaking into the host system.

## Features
- **Containerized**: all development happens inside a container with a rootless user. Its Containerfile is available and editable to quickly add tools or libraries.
- **Compatible**: works with Docker or Podman, on Linux (SE Linux compatible), MacOS or Windows. Works with any devcontainer compatible tool (VS Code, [`cli`](https://github.com/devcontainers/cli), [devpod](https://devpod.sh/)).
- **Template updates**: generated projects can be updated to track new releases of this template.
- **Secrets convention**: build-time and run-time secrets live in git-untracked files, kept separate from their committed templates.
- **Personal setup**: an optional, git-untracked, per-user script to configure a personal development environment on top of the shared container.
- **Conventional commits & semantic versioning**: commits follow [Conventional Commits](https://www.conventionalcommits.org/), releases follow [SemVer](https://semver.org/), and git-cliff drafts the changelog.
- **Just recipes**: day to day tasks (create a release, update the template, etc) are organized as [`just`](https://just.systems/) recipe modules.
- **Pre-commit checks**: common issues (trailing whitespace, merge conflicts, private keys, large files, etc) are caught before they are committed.

## Usage

### Copier variables
| Variable | Description | Default |
|---|---|---|
| `project_name` | Project name without special chars | None |

1. Install `copier` and `git`.

[`copier`](https://copier.readthedocs.io/en/latest/) is a CLI app for rendering project templates. I recommend installing it via `pipx`, although any tool should work.

```bash
pipx install copier
pipx inject copier copier-template-extensions
```

2. Create a project from the template. Run:

```bash
copier copy --trust git+https://github.com/rootless-templates/general <PROJECT_NAME>
```

Optionally, add `--vcs-ref=HEAD` to the `copier copy` command to use the latest commit from the repo, instead of the latest release (default).

3. Launch the dev container

Launch VS Code or run `just devcontainers::up` from your terminal.

### Container management
VS Code handles most container related tasks: building, mounting essential configurations, executing commands, etc. Outside, a `devcontainers.just` module contains most useful recipes for managing the dev container from the CLI.

### Per user setup
Some users have their own favorite configurations and tools. For this, the initial container setup executes the `.devcontainer/setup.sh` script if it exists. This script is not versioned so that each user may edit it freely.

## Development
Development of the template itself.

### Versioning and changelog
This project follows [Semantic Versioning](https://semver.org/) and uses [Conventional Commits](https://www.conventionalcommits.org/) (`feat:`, `fix:`, `chore:`, etc.). Human readable release notes are maintained in [`CHANGELOG.md`](./CHANGELOG.md).

New releases are drafted using `git-cliff` via `just release::` recipes.

### Repository layout

```
├── copier.yaml           # Template config
├── cliff.toml            # git-cliff config for CHANGELOG generation
├── justfile              # List of recipes
├── README.md             # This file
├── AGENTS.md             # Instructions for coding agents
├── LICENSE               # License
├── .recipes/             # Just recipe modules used to develop this template itself
│   ├── devcontainers.just
│   └── release.just
├── template/             # Template source
│   ├── .devcontainer/    # Dev container definition (Containerfile, devcontainer.json.jinja)
│   ├── .recipes/         # Just recipe modules copied into generated projects
│   │   ├── devcontainers.just
│   │   ├── release.just.jinja
│   │   └── template.just
│   └── ...
```
