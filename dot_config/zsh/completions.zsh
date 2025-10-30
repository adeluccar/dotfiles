################################################################################
#                                                                              #
#                                 COMPLETIONS                                  #
#                                                                              #
################################################################################

# ensure system/Homebrew zsh functions are in path
# fixes “function definition file not found” errors in Cursor
fpath=(/usr/local/share/zsh/site-functions /usr/local/share/zsh/functions /usr/share/zsh/site-functions /usr/share/zsh/*/functions $fpath)

# Add Docker CLI completions if they exist
if [[ -d "$HOME/.docker/completions" ]]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi

autoload -U compinit
compinit
