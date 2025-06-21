youtoo() {
    noglob yt-dlp -c -o "%(title)s.%(ext)s" "$@"
}

bam() {
  ffmpeg -i "$1" -vf scale=650:-1 -r 10 -f image2pipe -vcodec ppm - |\
    convert -delay 5 -layers Optimize -loop 0 - "${1%.*}.gif"
}

brewit() {
  local upgrade_casks=false
  local dry_run=false

  # Parse arguments
  for arg in "$@"; do
    case $arg in
      --casks)
        upgrade_casks=true
        ;;
      --dry-run)
        dry_run=true
        ;;
    esac
  done

  brew update

  if $dry_run; then
    echo "The following packages would be upgraded:"
    brew outdated
  else
    brew outdated
    brew upgrade
  fi

  # Handle cask upgrades if --casks argument is provided
  if $upgrade_casks; then
    if command -v brew cu > /dev/null; then
      if $dry_run; then
        echo "The following casks would be upgraded:"
        brew outdated --cask | grep -E '^[^=]' || echo "No casks to upgrade."
      else
        brew cu --all --yes
      fi
    else
      echo "brew cu is not installed. Skipping cask upgrades."
    fi
  fi

  if ! $dry_run; then
    brew cleanup
    brew doctor
  fi

  echo "Brewit completed successfully."
}

copy-repo() {
  git ls-files --cached --others --exclude-standard | while IFS= read -r file; do
    case "$file" in
      *.png|*.jpg|*.jpeg|*.gif|*.bmp|*.tiff|*.ico|*.webp|*.mp4|*.mp3|*.ogg|*.wav|*.pdf|*.svg)
        echo "\n===== $file =====\n[...truncated for brevity: image or binary file...]\n"
        continue
        ;;
    esac
    [ -f "$file" ] || continue
    echo "\n===== $file =====\n"
    if [[ "$file" == *.html ]]; then
      sed -E 's|<path[^>]*>|[... svg path omitted ...]|g' "$file"
    elif [[ "$file" == *.md || "$file" == *.txt ]]; then
      head -n 20 "$file"
      total=$(wc -l < "$file")
      [ "$total" -gt 20 ] && echo "[... content truncated: $((total - 20)) lines omitted ...]"
    else
      cat "$file"
    fi
  done
}

speedup() {
  local speed_ratio=1.15  # Default speed ratio
  local input_file
  local output_file="output.mp4"

  # Check for the '-r' flag to set a custom speed ratio
  while getopts 'r:' flag; do
    case "${flag}" in
      r) speed_ratio="${OPTARG}" ;;
      *) echo "Usage: speedup [-r speed_ratio] input_file" >&2
         return 1 ;;
    esac
  done
  shift $((OPTIND -1))

  # Check if an input file was provided
  if [ $# -eq 0 ]; then
    echo "No input file specified."
    return 1
  else
    input_file="$1"
  fi

  # Run ffmpeg with the specified or default speed ratio
  ffmpeg -i "${input_file}" -vf "setpts=(PTS-STARTPTS)/${speed_ratio}" -crf 18 -af "atempo=${speed_ratio}" "${output_file}"
}
