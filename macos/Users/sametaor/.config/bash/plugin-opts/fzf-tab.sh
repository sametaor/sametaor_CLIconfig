#!/usr/bin/env bash
# fzf-tab.opts.sh — Options for Bash fzf-tab plugin emulation

# Preview command for directory completion (uses eza with your flags)
FZFTAB_CD_PREVIEW_CMD='eza -a -l --icons=always --colour=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o -G -- {}'

# Use FZF_DEFAULT_OPTS or a minimal preset (yes/no)
FZFTAB_USE_FZF_DEFAULT_OPTS=yes

# Keys for switching groups inside fzf (page up/down alternative)
FZFTAB_SWITCH_GROUP_LEFT='<'
FZFTAB_SWITCH_GROUP_RIGHT='>'

# Command to run fzf inside tmux popup or fallback
FZFTAB_FZF_COMMAND='ftb-tmux-popup'