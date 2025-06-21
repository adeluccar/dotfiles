################################################################################
#                                                                              #
#                                 COMPLETIONS                                  #
#                                                                              #
################################################################################


# Add Docker CLI completions if they exist
if [[ -d "$HOME/.docker/completions" ]]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi

autoload -U compinit
compinit
