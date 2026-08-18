#!/usr/bin/env bash
# bash-256color.sh — Enhance Bash terminal environment with 256 color support

# Enable debug info if environment variable is set
_z256_dbg() {
  if [[ -n "${ZSH_256COLOR_DEBUG:-}" ]]; then
    echo "Z256 DEBUG: $*" >&2
  fi
}

# Detects whether current terminal supports 256 colors
_z256_check_support() {
  local term="${TERM:-}"

  # Common 256 color term patterns
  local patterns=(
    "256color"                # xterm-256color, screen-256color, tmux-256color
    "rxvt-unicode-256color"
    "linux"                  # linux console reports 256 color sometimes
    "screen"                 # use fallback for screen if it supports 256 colors
  )

  for p in "${patterns[@]}"; do
    if [[ "$term" == *"$p"* ]]; then
      _z256_dbg "Detected 256color support via TERM='$term' matching pattern '$p'"
      return 0
    fi
  done

  # Extra fallback: Check terminfo directly using tput for 256 colors
  if [[ $(tput colors 2>/dev/null) -ge 256 ]]; then
    _z256_dbg "Detected 256color support via tput colors $(tput colors)"
    return 0
  fi

  _z256_dbg "No 256color detected for TERM='$term'"
  return 1
}

# Sets environment variables for 256color
_z256_enable() {
  # Avoid overriding user-set TERM and COLORTERM unless advised
  if [[ $TERM != *"256color"* ]]; then
    export TERM='xterm-256color'
    _z256_dbg "TERM not set to 256color variant, setting TERM=xterm-256color"
  fi

  # Set COLORTERM to truecolor if empty, enabling enhanced colors
  if [[ -z "${COLORTERM:-}" ]]; then
    export COLORTERM='truecolor'
    _z256_dbg "COLORTERM unset, setting COLORTERM=truecolor"
  fi

  # Force the use of 256 color palette in shell prompts/colors
  export TERM_COLORS=256

  _z256_dbg "256color environment enabled"
}

# Main plugin logic to activate 256-color support if possible
_z256_init() {
  _z256_dbg "Initializing bash-256color plugin..."

  if _z256_check_support; then
    _z256_enable
  else
    _z256_dbg "256color support not detected, skipping environment changes"
  fi
}

# Run on source
_z256_init