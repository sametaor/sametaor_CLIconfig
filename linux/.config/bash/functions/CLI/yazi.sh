# yazi.sh — Bash function to open ranger with zoxide jump support

y() {
  if [ -n "$1" ]; then
    if [ -d "$1" ]; then
      yazi "$1"
    else
      local target_dir
      target_dir=$(zoxide query "$1")
      if [ -n "$target_dir" ]; then
        yazi "$target_dir"
      else
        echo "zoxide: No match found for '$1'" >&2
        return 1
      fi
    fi
  else
    yazi
  fi
  return $?
}
