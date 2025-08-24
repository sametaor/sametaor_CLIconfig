#!/usr/bin/env bash
# bash-history-substring-search.opts.sh — Configuration options
# Bash-compatible vi-mode keybindings for history search
# These replace the problematic history_substring_search functions
bind -m vi-command 'k': history-search-backward
bind -m vi-command 'j': history-search-forward
# Ensure unique search results: 1 to remove duplicates, 0 for no deduplication
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
