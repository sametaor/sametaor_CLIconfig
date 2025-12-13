#!/usr/bin/env bash
# bash-autosuggestions.opts.sh — Options for bash autosuggestions plugin

# Suggestion highlight style (ANSI color codes)
# We use ANSI escape sequences here; adjust as needed.
# Example below corresponds roughly to fg=#666666,italic
BASH_AUTOSUGGEST_HIGHLIGHT_STYLE=$'\e[38;5;240m\e[3m'  # gray and italic

# Maximum line length to show suggestions for; disable for long lines (>80 disables)
# set to 0 or unset to not limit
BASH_AUTOSUGGEST_BUFFER_MAX_SIZE=80

# Extra key bindings (bind right-arrow and end to accept suggestion)
# These bindings are installed by the plugin script but exposed here for clarity
BASH_AUTOSUGGEST_ACCEPT_KEY_BINDINGS=(
  '"\e[C": __bash_as_accept'   # right arrow
  '"\e[4~": __bash_as_accept'  # End key
)