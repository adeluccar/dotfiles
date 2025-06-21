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

brew update

# Install CLI tools
echo "[bootstrap] Installing CLI packages..."
brew install gh exiftool ffmpeg imagemagick pandoc \
  postgresql sqlite

# Install GUI apps (casks)
echo "[bootstrap] Installing GUI apps..."
brew install --cask \
  brave-browser 1password anki namechanger permute \
  db-browser-for-sqlite camo-studio krisp zoom telegram \
  the-unarchiver transmission

echo "Extras installed. Restart your shell."

