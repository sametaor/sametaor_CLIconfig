#!/usr/bin/env bash
# fzf-tab.sh — Bash emulation of Aloxaf's fzf-tab plugin

# Load user options if present
PLUGIN_OPTS="${HOME}/.config/bash/plugin-opts/fzf-tab.opts.sh"
if [ -f "$PLUGIN_OPTS" ]; then
  # shellcheck source=/dev/null
  source "$PLUGIN_OPTS"
fi

# Use defaults if unset
: "${FZFTAB_CD_PREVIEW_CMD:=eza -1 --color=always -- {} }"
: "${FZFTAB_USE_FZF_DEFAULT_OPTS:=no}"
: "${FZFTAB_SWITCH_GROUP_LEFT:=<}"
: "${FZFTAB_SWITCH_GROUP_RIGHT:=>}"
: "${FZFTAB_FZF_COMMAND:=fzf}"

# tmux popup wrapper for fzf (fallback to normal)
ftb-tmux-popup() {
  if [ -n "${TMUX:-}" ] && command -v tmux >/dev/null 2>&1; then
    tmux display-popup -E "$*"
  else
    eval "$*"
  fi
}

# Base fzf runner honoring options
fzftab_run() {
  local cmd="$FZFTAB_FZF_COMMAND"
  shift || return 1
  local args=("$@")

  if [[ $FZFTAB_USE_FZF_DEFAULT_OPTS == yes ]]; then
    "$cmd" "${args[@]}"
  else
    # Minimal sane default with paging keys as switching groups
    "$cmd" "${args[@]}" --bind="${FZFTAB_SWITCH_GROUP_LEFT}:page-up,${FZFTAB_SWITCH_GROUP_RIGHT}:page-down" --height=40% --reverse
  fi
}

# cd completion with fzf and preview using eza
_fzftab_cd_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local base="${cur/#\~/$HOME}"
  [ -z "$base" ] && base="."

  local candidates
  if [ -d "$base" ]; then
    candidates=$(find "$base" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort -V)
  else
    local dir
    dir=$(dirname -- "$base")
    candidates=$(find "$dir" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort -V)
  fi

  if [ -z "$candidates" ] || ! command -v fzf >/dev/null 2>&1; then
    COMPREPLY=()
    return 0
  fi

  local selection
  selection=$(printf '%s\n' $candidates | \
    FZF_PREVIEW_COMMAND="$FZFTAB_CD_PREVIEW_CMD" \
    fzftab_run --preview "$FZF_PREVIEW_COMMAND" --preview-window=right:60%:wrap --prompt='cd > ' --select-1 --exit-0)

  if [ -n "$selection" ]; then
    COMPREPLY=("$selection")
  else
    COMPREPLY=()
  fi
}

# Attach completion to cd command
complete -o filenames -F _fzftab_cd_complete cd