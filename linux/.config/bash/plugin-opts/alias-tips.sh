#!/usr/bin/env bash
# bash-alias-tips.opts.sh — configuration variables for bash-alias-tips plugin

# Customize the alias tip text (including your icon)
BASH_ALIAS_TIPS_TEXT="󰛩 Alias tip: "

# Optionally exclude some aliases from tips (space-separated)
BASH_ALIAS_TIPS_EXCLUDES="_ ll vi vim"

# Whether to force usage of aliases (abort non-aliased commands)
BASH_ALIAS_TIPS_FORCE=0

# Whether to always reveal alias expansions
BASH_ALIAS_TIPS_REVEAL=0