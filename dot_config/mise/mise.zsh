################################################################################
#                                                                              #
#                                 MISE SETUP                                   #
#                                                                              #
#    mise (https://mise.jdx.dev) is a tool/runtime version manager.            #
#    This file activates mise for zsh.                                         #
#                                                                              #
################################################################################

if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi
