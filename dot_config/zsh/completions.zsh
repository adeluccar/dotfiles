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

autoload -Uz compinit

# Check if the current user is an admin
if id -Gn | grep -qw admin; then
  # User IS an admin → run compinit normally
  compinit
else
  # User is a standard (non-admin) account → ignore insecure directories
  compinit -i
fi
