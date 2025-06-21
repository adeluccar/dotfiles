#!/bin/sh

set -e

echo "[bootstrap] Starting setup..."

ARCH=$(uname -m)
OS=$(uname -s)

if [ "$OS" != "Darwin" ]; then
  echo "[bootstrap] Unsupported OS: $OS"
  exit 1
fi

if [ "$ARCH" != "x86_64" ] && [ "$ARCH" != "arm64" ]; then
  echo "[bootstrap] Unsupported architecture: $ARCH"
  exit 1
fi

echo "[bootstrap] OS: $OS, Arch: $ARCH"

# Ensure ~/.local/bin exists and is in PATH
mkdir -p "$HOME/.local/bin"
case ":$PATH:" in
  *":$HOME/.local/bin:"*) ;; # already in path
  *) echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc" ;;
esac

# Install Homebrew if needed
if ! command -v brew >/dev/null 2>&1; then
  echo "[bootstrap] Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install CLI tools
echo "[bootstrap] Installing CLI packages..."
brew update
brew install \
  git git-extras nvim tmux ripgrep fd mise openssl gh \
  zsh zsh-syntax-highlighting \
  dos2unix exiftool ffmpeg imagemagick pandoc \
  postgresql sqlite

# Install GUI apps (casks)
echo "[bootstrap] Installing GUI apps..."
brew install --cask \
  brave-browser 1password anki namechanger permute \
  db-browser-for-sqlite camo-studio krisp zoom telegram \
  the-unarchiver transmission

# Set up TPM for tmux
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
  echo "[bootstrap] Installing TPM (Tmux Plugin Manager)..."
  git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
else
  echo "[bootstrap] TPM already installed."
fi

# Install chezmoi
if ! command -v chezmoi >/dev/null 2>&1; then
  echo "[bootstrap] Installing chezmoi..."
  brew install chezmoi
fi

# Apply dotfiles
echo "[bootstrap] Applying dotfiles..."
chezmoi init --apply

echo "[bootstrap] Done. You should restart your shell."

