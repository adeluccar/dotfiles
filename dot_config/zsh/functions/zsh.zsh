zz() {
  sh ~/.dotfiles/bin/make-my-symlinks && \
    source ~/.zshrc && \
    echo "Symlinks updated and zshrc sourced."
}
