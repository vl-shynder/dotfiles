# Herdr + Ghostty configuration

This repository contains the local configuration for Herdr, Ghostty, and the Herdr reviewr plugin.

## Layout

- `herdr/config.toml`: Herdr UI, theme, terminal behavior, keybindings, and Codex-friendly session restore.
- `herdr/plugins/reviewr/config.toml`: reviewr layout and Tokyo Night theme.
- `ghosty/config.ghostty`: Ghostty theme, font, spacing, and terminal behavior.
- `bootstrap.sh`: backs up existing live config, links these files into place, installs reviewr, and installs the Codex integration.

## Keybindings

The Herdr prefix remains `Ctrl+B`:

- `Ctrl+B`, then `F`: toggle reviewr in the current workspace.
- `Ctrl+B`, then `Shift+F`: explicitly open a new reviewr pane.

## Apply locally

From this directory, run:

```sh
./bootstrap.sh
```

Restart Ghostty after the script completes. Herdr can reload its config with `herdr server reload-config`.

If reviewr installation reports `plugin_user_dir_create_failed`, the user-local `~/.local/state` directory may be owned by `root`. On macOS, run this once in a normal local terminal, then rerun the bootstrap script:

```sh
sudo chown "$USER":staff "$HOME/.local/state"
./bootstrap.sh
```

The bootstrap script does not alter the existing child directories under `~/.local/state`.

## Publishing

The bootstrap script does not handle GitHub credentials. To publish this as a public repository:

1. Run `gh auth login -h github.com` and complete the browser/device flow.
2. From this directory, run `git init`, stage the files below, and review `git diff --cached`.
3. Run `git commit -m "Add Herdr and Ghostty configuration"`.
4. Run `gh repo create herdr-ghostty-config --public --source=. --remote=origin --push`.

Stage only the configuration files. This directory contains unrelated existing files, so use:

```sh
git add .gitignore README.md bootstrap.sh herdr ghosty
```

Do not commit tokens, private keys, or plugin runtime state. The `.gitignore` excludes common local artifacts.
