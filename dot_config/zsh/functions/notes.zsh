# Appends timestamped one-liner to ~/notes/journal.txt
note() {
  echo "$(date '+%Y-%m-%d %H:%M') — $*" >> ~/notes/journal.txt
}

# Alias for speed
alias n='note'
