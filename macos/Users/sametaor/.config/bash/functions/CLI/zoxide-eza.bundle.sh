# zoxide-eza.bundle.sh — ephemeral ls after zoxide jump for Bash

# Wrapper function for z, integrating ephemeral listing
z() {
  # 0. If no argument, cd to HOME
  if (( $# == 0 )); then
    builtin cd -- "$HOME"
    _z_after_zoxide_cd
    return
  fi

  # 1. If absolute or relative path, cd directly
  case "$1" in
    /*|.~*|.*) builtin cd -- "$1" && _z_after_zoxide_cd; return ;;
  esac

  # 2. Use zoxide to find directory, else fallback to literal cd
  local dest
  if dest=$(command zoxide query -- "$@"); then
    builtin cd -- "$dest"
  else
    builtin cd -- "$1" 2>/dev/null || return
  fi

  _z_after_zoxide_cd
}

# Install a single PROMPT_COMMAND hook after z() cd success
_z_after_zoxide_cd() {
  # Remove the ephemeral hook if present to avoid repeats
  PROMPT_COMMAND=$(echo "$PROMPT_COMMAND" | sed -e 's/_zoxide_ephemeral_list;//g' -e 's/;;/;/g' -e 's/^;//' -e 's/;$//')
  # Add ephemeral ls hook once
  PROMPT_COMMAND="_zoxide_ephemeral_list;${PROMPT_COMMAND:+$PROMPT_COMMAND}"
}

# The ephemeral listing itself
_zoxide_ephemeral_list() {
  # Self remove from PROMPT_COMMAND
  PROMPT_COMMAND=$(echo "$PROMPT_COMMAND" | sed -e 's/_zoxide_ephemeral_list;//g' -e 's/;;/;/g' -e 's/^;//' -e 's/;$//')

  # Alternate screen and cursor hide
  tput smcup
  tput civis

  if command -v eza >/dev/null 2>&1; then
    eza -a -l --icons=always --color=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o -G
  else
    ls -CF --color=auto
  fi

  # Prompt and wait for key or timeout (10 seconds)
  printf '\nPress any key to continue… '
  read -r -s -n 1 -t 10 || true

  # Restore cursor and screen
  tput cnorm
  tput rmcup
}