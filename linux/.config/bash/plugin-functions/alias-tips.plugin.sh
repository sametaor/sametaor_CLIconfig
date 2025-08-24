#!/usr/bin/env bash
# alias-tips.plugin.sh — Advanced alias tips plugin for Bash with global alias awareness

# Load user config options file if it exists (adjust path as needed)
if [ -f "${HOME}/.config/bash/plugin-opts/alias-tips.sh" ]; then
  # shellcheck source=/dev/null
  source "${HOME}/.config/bash/plugin-opts/alias-tips.sh"
fi

# User-configurable environment variables:
# BASH_ALIAS_TIPS_TEXT: prefix text for alias tip output
# BASH_ALIAS_TIPS_EXCLUDES: space-separated aliases to exclude from tips
# BASH_ALIAS_TIPS_FORCE: If set to 1, abort command if alias exists
# BASH_ALIAS_TIPS_REVEAL: If set to 1, always show alias expansions

: "${BASH_ALIAS_TIPS_TEXT:=Alias tip: }"
: "${BASH_ALIAS_TIPS_EXCLUDES:=_ ll vi vim}"
: "${BASH_ALIAS_TIPS_FORCE:=0}"
: "${BASH_ALIAS_TIPS_REVEAL:=0}"

# Internal vars
__bat_last_command=""
read -r -a __bat_excludes <<< "$BASH_ALIAS_TIPS_EXCLUDES"

__bat_is_excluded() {
  local alias_name=$1
  for excl in "${__bat_excludes[@]}"; do
    [[ $alias_name == "$excl" ]] && return 0
  done
  return 1
}

__bat_print_tip() {
  local alias_name=$1
  printf "%s%s\n" "$BASH_ALIAS_TIPS_TEXT" "$alias_name"
}

__bat_reveal_alias() {
  local alias_name=$1
  alias "$alias_name" 2>/dev/null
}

# Check if a command is an expansion of any alias we have
__bat_match_alias() {
  local cmdline=$1

  # Iterate over all aliases
  alias | while IFS= read -r line; do
    local name=${line%%=*}
    name=${name#alias }
    local expansion=${line#*=}
    expansion=${expansion#\'}
    expansion=${expansion%\'}

    __bat_is_excluded "$name" && continue

    if [[ $cmdline == $expansion* ]]; then
      echo "$name"
      break
    fi
  done
}

# Main function hooked into PROMPT_COMMAND
__bat_prompt_command() {
  # Extract last executed command line ignoring history numbers and spaces
  local histline cmdline cmd
  histline=$(history 1)
  cmdline=${histline#*[0-9] }
  cmd=${cmdline%% *}

  # Skip empty or duplicate
  [[ -z "$cmd" || "$cmd" == "$__bat_last_command" ]] && return
  __bat_last_command=$cmd

  # Check if command is an alias itself
  if alias "$cmd" &>/dev/null; then
    [[ $BASH_ALIAS_TIPS_REVEAL -eq 1 ]] && __bat_reveal_alias "$cmd"
    return
  fi

  # Check for alias whose expansion matches this typed command
  local aliased
  aliased=$(__bat_match_alias "$cmdline")
  if [[ -n $aliased ]]; then
    __bat_print_tip "$aliased"

    if [[ $BASH_ALIAS_TIPS_FORCE -eq 1 ]]; then
      echo "Aborting execution. Please use your alias: $aliased" >&2
      # Attempts to abort command execution by resetting last command
      # Note: This won't cancel command already running, but stops prompt update
      __bat_last_command=""
      return 1
    fi
  fi
}

# Hook the main function into PROMPT_COMMAND if not already hooked
if [[ "$PROMPT_COMMAND" != *"__bat_prompt_command"* ]]; then
  if [[ -z "$PROMPT_COMMAND" ]]; then
    PROMPT_COMMAND=__bat_prompt_command
  else
    PROMPT_COMMAND="$PROMPT_COMMAND;__bat_prompt_command"
  fi
fi