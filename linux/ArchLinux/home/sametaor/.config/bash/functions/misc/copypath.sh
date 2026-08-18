copypath() {
  # If no argument passed, use current directory
  local file="${1:-.}"

  # If argument is not an absolute path, prepend $PWD
  if [[ "$file" != /* ]]; then
    file="$PWD/$file"
  fi

  # Copy the absolute path without resolving symlinks
  # Use printf to avoid issues with print (Zsh-specific)
  printf '%s' "$file" | clipcopy || return 1

  # Print confirmation in bold ANSI text
  # \e[1m = bold, \e[0m = reset
  printf '\e[1m%s\e[0m copied to clipboard.\n' "$file"
}