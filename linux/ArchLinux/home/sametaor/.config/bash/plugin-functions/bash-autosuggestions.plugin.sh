#!/usr/bin/env bash
# bash-autosuggestions.sh — Basic autosuggestions inspired by zsh-autosuggestions

OPTIONS_FILE="${HOME}/.config/bash/plugin-opts/bash-autosuggestions.opts.sh"
if [ -f "$OPTIONS_FILE" ]; then
  # shellcheck source=/dev/null
  source "$OPTIONS_FILE"
fi

# Configuration: Customize highlight style (ANSI escape codes)
: "${BASH_AUTOSUGGEST_HIGHLIGHT_STYLE:=\e[38;5;244m}"   # Gray-ish color
: "${BASH_AUTOSUGGEST_SHOW_HIGHLIGHT:=1}"              # 1 to enable visual suggestion highlight
: "${BASH_AUTOSUGGEST_BUFFER_MAX_SIZE:=0}"
: "${BASH_AUTOSUGGEST_ACCEPT_KEY_BINDINGS:=()}"

# Internal variables for autosuggest
__bash_as_suggestion=""
__bash_as_original_line=""

# Function to find best history match starting with current input
__bash_as_get_suggestion() {
  local current_input="$1"
  if [ -z "$current_input" ]; then
    __bash_as_suggestion=""
    return
  fi
  # Search history (excluding current command) for matching history entry
  local suggestion
  suggestion=$(history | grep -E "^[ ]*[0-9]+ +$current_input" | head -n1 | sed -r "s/^[ ]*[0-9]+ +//")
  
  if [[ -n "$suggestion" && "$suggestion" != "$current_input" ]]; then
    __bash_as_suggestion="${suggestion#$current_input}"
  else
    __bash_as_suggestion=""
  fi
}

# Display autosuggestion after cursor using Readline variables
__bash_as_display_suggestion() {
  # If no suggestion or highlighting disabled, do nothing
  if [[ -z "$__bash_as_suggestion" || $BASH_AUTOSUGGEST_SHOW_HIGHLIGHT -ne 1 ]]; then
    return
  fi
  # Save original line and cursor position
  __bash_as_original_line="$READLINE_LINE"
  local cursor_pos=$READLINE_POINT

  # Display suggestion in a lighter color (ANSI)
  # Set the buffer to original + suggestion colored, cursor remains at original pos
  READLINE_LINE="${__bash_as_original_line}${BASH_AUTOSUGGEST_HIGHLIGHT_STYLE}${__bash_as_suggestion}\e[0m"
  READLINE_POINT=$cursor_pos
}

# Clear autosuggestion display (reset to original line)
__bash_as_clear_suggestion() {
  if [[ -n "$__bash_as_original_line" ]]; then
    READLINE_LINE="$__bash_as_original_line"
    READLINE_POINT=${#__bash_as_original_line}
    __bash_as_suggestion=""
  fi
}

# Main hook: Called on readline line change via bind -x widget
__bash_as_hook() {
  local cur_buf
  cur_buf="$READLINE_LINE"

  # Ignore if command complete or empty input
  if [[ -z "$cur_buf" ]]; then
    __bash_as_suggestion=""
    return
  fi

  __bash_as_get_suggestion "$cur_buf"
  __bash_as_display_suggestion
}

# Widget to accept the autosuggestion completely (bound to right-arrow or end)
__bash_as_accept() {
  if [[ -n "$__bash_as_suggestion" ]]; then
    READLINE_LINE="${READLINE_LINE%%$BASH_AUTOSUGGEST_HIGHLIGHT_STYLE*}$__bash_as_suggestion"
    READLINE_POINT=${#READLINE_LINE}
    __bash_as_suggestion=""
  else
    # If no suggestion, move cursor forward normally
    READLINE_POINT=$((READLINE_POINT + 1))
  fi
}

# Setup keybindings
bash_autosuggest_bind() {
  # Create a unique readline widget for the hook function
  bind -x '"\C-e": __bash_as_hook'    # Ctrl+e triggers re-suggestion on demand
  bind -x '"\e[C": __bash_as_accept'  # Right arrow accepts suggestion
  bind '"\e[4~": "\e[C"'               # End key -> right arrow for acceptance
  # Optionally add more keybindings per preference
}

# Initialize so that the hook runs before showing prompt
# Note: this is a minimal approximation to Zsh's precmd + preexec
PROMPT_COMMAND="__bash_as_hook;${PROMPT_COMMAND}"

bash_autosuggest_bind