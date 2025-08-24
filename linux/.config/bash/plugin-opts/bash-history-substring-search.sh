#!/usr/bin/env bash
# bash-history-substring-search.opts.sh — Configuration options

# Bind arrow keys in Emacs and Vi command mode to the search functions
# (Note: This is approximate due to Bash readline limits)

bind '"'"$terminfo[kcuu1]"'"' history_substring_search_up
bind '"'"$terminfo[kcud1]"'"' history_substring_search_down

# Optional vi command mode keybindings (vicmd)
bind -m vi-command 'k' history_substring_search_up
bind -m vi-command 'j' history_substring_search_down

# Ensure unique search results: 1 to remove duplicates, 0 for no deduplication
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1