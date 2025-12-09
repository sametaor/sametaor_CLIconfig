#!/usr/bin/env bash
# bash-history-substring-search.sh — substring history search inspired by Zsh plugin

# State variables
__bhss_matches=()
__bhss_index=-1
__bhss_search_active=0
__bhss_last_buffer=""

# Search history for entries containing the substring
__bhss_search_history() {
  local query="$1"
  local uniq=${2:-0}
  local -a results=()
  local prev=""
  while IFS= read -r line; do
    if [[ "$line" == *"$query"* ]] && [[ "$line" != "$query" ]]; then
      if (( uniq == 1 )); then
        [[ "$line" == "$prev" ]] && continue
        prev="$line"
      fi
      results+=("$line")
    fi
  done < <(history | tac | sed 's/^[ ]*[0-9]*[ ]*//')
  echo "${results[@]}"
}

# Update command line and cursor position
__bhss_update_line() {
  local line="$1"
  READLINE_LINE="$line"
  READLINE_POINT=${#line}
}

# Cycle backward (previous) match
history_substring_search_up() {
  local cur=${READLINE_LINE:0:READLINE_POINT}

  if [[ "$cur" != "$__bhss_last_buffer" ]]; then
    __bhss_matches=()
    __bhss_index=-1
    __bhss_search_active=0
  fi

  if [[ -z "$cur" ]]; then
    __bhss_search_active=0
    return 0
  fi

  if [[ $__bhss_search_active -eq 0 ]]; then
    read -ra __bhss_matches <<< "$(__bhss_search_history "$cur" ${HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE:-0})"
    __bhss_index=-1
  fi

  if ((${#__bhss_matches[@]} == 0)); then
    bind '"\C-p": history-search-backward'
    return 0
  fi

  __bhss_index=$(( (__bhss_index + 1) % ${#__bhss_matches[@]} ))
  __bhss_search_active=1
  __bhss_last_buffer="$cur"
  __bhss_update_line "${__bhss_matches[$__bhss_index]}"
}

# Cycle forward (next) match
history_substring_search_down() {
  if [[ $__bhss_search_active -eq 0 ]]; then
    bind '"\C-n": history-search-forward'
    return 0
  fi

  if ((${#__bhss_matches[@]} == 0)); then
    bind '"\C-n": history-search-forward'
    return 0
  fi

  if [[ $__bhss_index -le 0 ]]; then
    __bhss_index=$((${#__bhss_matches[@]} - 1))
  else
    __bhss_index=$((__bhss_index - 1))
  fi

  __bhss_update_line "${__bhss_matches[$__bhss_index]}"
}

# Install default bindings for Emacs mode (optional)
bash_history_substring_search_bind() {
  # Up and down arrows to substring search
  bind -x '"\C-p": history_substring_search_up'
  bind -x '"\C-n": history_substring_search_down'

  # Also bind arrow keys
  bind '"\e[A": "\C-p"'
  bind '"\e[B": "\C-n"'

  # User can extend bindings as needed
}

bash_history_substring_search_bind