################################################################################
#                                                                              #
#                                   ALIASES                                    #
#                                                                              #
################################################################################

alias b="bundle"
alias be="b exec"
alias bi="b install --path vendor"
alias bil="bi --local"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"
alias brews="brew list"
alias bu="b update"
alias d="dirs -v | head -10"
alias gcb="git-clone-bare-for-worktrees"
alias gwa="git-worktree-add"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias j="jobs -l"
alias l="ls -la" # list all files in human readable format
alias ls="ls -G" # enable colorized output
alias po="popd"
alias pu="pushd"
alias reload="sh ~/.dotfiles/bin/make-my-symlinks && source ~/.zshrc && echo '.zshrc sourced'"
alias wget="wget -c" # continue downloads

# show and hide hidden files in Mac OS X
alias show_hidden="defaults write com.apple.Finder AppleShowAllFiles YES && killall Finder"
alias hide_hidden="defaults write com.apple.Finder AppleShowAllFiles NO && killall Finder"
