## Installation

This setup assumes a bare, freshly installed macOS machine.

- Ghostty terminal
- Neovim
- Tmux
- Git

### 1. Install chezmoi

Use the official installer script:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)"
````

This installs `chezmoi` and puts it in your path.

### 2. Initialize chezmoi

Clone this dotfiles repo:

```sh
chezmoi init git@github.com:yourusername/dotfiles.git
```

Or, if using HTTPS:

```sh
chezmoi init https://github.com/yourusername/dotfiles.git
```

**Before applying**, edit your local config:

```sh
chezmoi edit-config
```

Fill in your personal details (name, email, etc.) and any machine-specific data:

```toml
[data]
git_name = "Your Name"
git_email = "you@example.com"
```

This ensures your templates like `.gitconfig.tmpl` render correctly.

### 3. Apply your dotfiles

```sh
chezmoi apply
```

This sets up everything in place: Zsh config, Neovim, Git, scripts, etc.

### 4. Install any necessary packages

Some utilities are installed via a separate script (if configured):

```sh
~/.local/bin/bootstrap.sh
```

This installs Homebrew (if needed), CLI tools, and GUI apps.

### 5. (Optional) Configure SSH keys

```sh
ssh-keygen -t ed25519 -C "you@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
pbcopy < ~/.ssh/id_ed25519.pub
# Paste into GitHub
```

Now you’re home.

```
nvim ~/.config/nvim/init.lua
tmux
zsh
```

