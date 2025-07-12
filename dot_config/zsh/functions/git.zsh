git-clone-bare-for-worktrees() {
  set -e

  if [[ -z $1 ]]; then
    echo "Usage: git-clone-bare-for-worktrees <git-url> [directory-name]" >&2
    return 1
  fi

  local url=$1
  local basename=${url##*/}
  local name=${2:-${basename%.*}}

  if [[ -e $name ]]; then
    echo "Directory '$name' already exists. Refusing to overwrite." >&2
    return 1
  fi

  mkdir "$name"
  cd "$name"

  git clone --bare "$url" .bare
  echo "gitdir: ./.bare" > .git

  git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
  git fetch origin
}

git-worktree-add() {
  set -e

  if [[ -z $1 ]]; then
    echo "Usage: git-worktree-add <branch-name>" >&2
    return 1
  fi

  local branch="$1"

  git worktree add -b "$branch" "$branch"
  cd "$branch"
}

