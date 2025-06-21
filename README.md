## Dotfiles

These are my personal dotfiles. I tweak and rebuild them often. Nothing here is static or sacred, and much of it evolves week to week as I experiment with new tools, plugins, or workflows. You're welcome to fork them, modify them, strip out what you don’t need, or treat them as a starting point for your own setup.

The goal is to quickly bootstrap a solid developer environment on macOS with minimal friction. This setup gives you Zsh, Neovim, tmux, Git, and a handful of scripts configured to play well together. It leans heavily on [`chezmoi`](https://www.chezmoi.io) to manage configuration, templating, secrets, and system differences across machines. Once you understand how it works, it becomes trivial to spin up a clean system in minutes, with your full environment ready to go.

## Installation Steps

This guide walks you through bootstrapping a fresh macOS machine using [`chezmoi`](https://www.chezmoi.io) and **your fork** of this dotfiles repo.

### 1. Fork this repository

Go to [github.com/adeluccar/dotfiles](https://github.com/adeluccar/dotfiles), click **Fork**, and create a personal copy under your GitHub username.

### 2. Set up your SSH key (if you haven't already)

```sh
ssh-keygen -t ed25519 -C "you@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
```

Then go to [GitHub > Settings > SSH and GPG keys](https://github.com/settings/keys), click **New SSH key**, paste your key, and save.

This allows you to use SSH with GitHub and avoids repeated prompts.

### 3. Create your `chezmoi` config

Before running `chezmoi`, set up your personal config. Since Neovim isn’t installed yet, just use `nano` (or another basic editor):

```sh
mkdir -p ~/.config/chezmoi
nano ~/.config/chezmoi/chezmoi.toml
```

Paste this in and customize:

```toml
[data]
git_name = "Your Name"
git_email = "you@example.com"
```

### 4. Initialize `chezmoi`

Install and apply your dotfiles in one shot using the official script. Replace `$GITHUB_USERNAME` with your GitHub username:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:$GITHUB_USERNAME/dotfiles.git
```

This installs `chezmoi` to `~/.local/bin`. After setup, you can replace it with the Homebrew version for easier updates.

During setup, `chezmoi` will and install and configure:

- Ghostty terminal
- Zsh shell environment and plugins
- Git with aliases and sensible defaults
- Neovim with lazy-loaded plugin manager
- Tmux with TPM and plugin support
- Useful scripts in `~/.local/bin/`

You can reapply changes manually anytime by running the same command.

### 6. First run setup

1. Open Ghostty

2. Start Neovim to install plugins:

   ```sh
   nvim .
   ```

   Once plugins are done installing:

   * Press `:q` to close the plugin window
   * Then press `:q` again to close Neovim

3. Start `tmux`:

   ```sh
   tmux
   ```

   Press `<Control-space>`, then `I` (capital i) to install plugins.
   When finished, press `<Control-space>`, then `:` and type:

   ```tmux
   :kill-server
   ```

   That restarts tmux cleanly.

### 7. Optional: install extra tools

If you want additional utilities (non-critical extras), run:

```sh
~/.local/bin/install_extras.sh
```

This installs things like media tools, GUI utilities, etc. Not required for your shell/dev environment to work.

## Disclaimer

These dotfiles and scripts are provided as-is, with no warranties or guarantees of any kind. By using them, you agree that I’m not liable for any damage, data loss, misconfiguration, or unexpected behavior that might result. You are fully responsible for reviewing and understanding any code you run on your machine. Use at your own risk. No support is promised, and no legal claims will be accepted.

**Use at your own risk. Always review scripts and configuration files before running them on your system.**
