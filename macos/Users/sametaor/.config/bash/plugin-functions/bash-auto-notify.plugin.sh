#!/usr/bin/env bash
# bash-auto-notify.sh — Auto notification for long-running commands in Bash

# Load options if set
if [ -f "${HOME}/.config/bash/plugin-opts/auto-notify.opts.sh" ]; then
  source "${HOME}/.config/bash/plugin-opts/auto-notify.opts.sh"
fi

# Configuration via environment variables (set before sourcing)
: "${AUTO_NOTIFY_THRESHOLD:=120}"            # seconds; notify if command exceeds this
: "${AUTO_NOTIFY_TITLE:='Command finished'}"  # notification title template
: "${AUTO_NOTIFY_BODY:='Command \"%command\" finished in %elapsed seconds with exit code %exit_code'}"
: "${AUTO_NOTIFY_EXPIRE_TIME:=8000}"       # ms, notification expiry (Linux notify-send)
: "${AUTO_NOTIFY_ENABLE_SSH:=0}"            # 0 no forward, 1 forward to SSH client
: "${AUTO_NOTIFY_ENABLE_TRANSIENT:=1}"      # 1 transient notification (no history), 0 persistent
: "${AUTO_NOTIFY_CANCEL_ON_SIGINT:=0}"      # 1 cancel notification on SIGINT, 0 no
AUTO_NOTIFY_IGNORE=("watch" "man" "less" "more" "ssh" "top" "ps" "grep" "cat" "tail" "head" "awk" "sed" "sort" "cut" "uniq" "tr" "wc" "du" "df" "ls" "tree" "clear" "vim" "vi" "nano" "emacs" "nvim" "code" "vscodium" "gedit" "leafpad" "kate" "mousepad" "micro" "apt" "dnf5" "dnf" "yum" "zypper" "pacman" "yay" "snap" "flatpak" "brew" "ssh" "mosh" "sftp" "tmux" "screen" "find" "locate" "which" "whereis" "uname" "hostname" "whoami" "lsb_release" "fastfetch" "inxi" "lscpu" "free" "dmesq" "git" "gh" "cd" "pushd" "popd" "dirs" "echo" "printf" "exit" "reboot" "shutdown" "poweroff" "alias" "unalias" "export" "unset" "set" "history" "tee") # commands to ignore
AUTO_NOTIFY_WHITELIST=("yay" "make" "cmake" "jinja" "ninja" "clang" "gcc")                     # Set non-empty to whitelist instead of ignore

# Internal vars to store command info
__aan_start_time=0
__aan_command=""
__aan_exit_code=0
__aan_ignore=0

# Helper: Detect WSL
__aan_is_wsl() {
    grep -qi microsoft /proc/version 2>/dev/null
}

# Send notification helper (Linux using notify-send)
__aan_send_notification() {
  local title="$1"
  local body="$2"

  if command -v notify-send >/dev/null 2>&1; then
    local urgency="normal"
    local hint=""
    if [[ $AUTO_NOTIFY_ENABLE_TRANSIENT -eq 1 ]]; then
      hint="transient:1"
    else
      hint="transient:0"
    fi

    notify-send --expire-time="$AUTO_NOTIFY_EXPIRE_TIME" --urgency="$urgency" --hint="$hint" "$title" "$body"
  elif __aan_is_wsl && command -v wsl-notify-send.exe >/dev/null 2>&1; then
    body="${body//\\n/$'\n'}"
    # On WSL, use wsl-notify-send.exe
    wsl-notify-send.exe "$title: $body"
  elif [[ "$(uname)" == "Darwin" ]]; then
    # macOS notification using AppleScript
    osascript -e "display notification \"$body\" with title \"$title\""
  elif [[ "$(uname)" == "Linux" ]]; then
    # Linux notification using notify-send
    notify-send --expire-time="$AUTO_NOTIFY_EXPIRE_TIME" --urgency="normal" "$title" "$body"
  else
    # Fallback: just echo
    echo "Notification: $title - $body" > /dev/null
  fi
}

# Check if command is ignored (returns 0 if ignored)
__aan_check_ignore() {
  local cmd="$1"

  # If whitelist defined, only notify if in whitelist
  if [ "${#AUTO_NOTIFY_WHITELIST[@]}" -ne 0 ]; then
    for wcmd in "${AUTO_NOTIFY_WHITELIST[@]}"; do
      [[ "$cmd" == "$wcmd" ]] && return 1
    done
    return 0
  fi

  # Else check ignore list
  for icmd in "${AUTO_NOTIFY_IGNORE[@]}"; do
    [[ "$cmd" == "$icmd" ]] && return 0
  done

  return 1
}

__aan_preexec() {
  # Only run this if the shell is at top-level prompt
  [[ "$BASH_SUBSHELL" != "0" ]] && return
  # Get command name
  local cmd=$(awk '{print $1}' <<< "$BASH_COMMAND")
  for ignore in "${AUTO_NOTIFY_IGNORE[@]}"; do
    [[ "$cmd" == "$ignore" ]] && __aan_ignore=1 && return
  done
  __aan_start_time=$(date +%s)
  __aan_command="$BASH_COMMAND"
  __aan_ignore=0
}

__aan_precmd() {
  [[ $__aan_ignore -eq 1 ]] && __aan_ignore=0 && return
  local now=$(date +%s)
  local elapsed=$((now - __aan_start_time))
  [[ $elapsed -lt $AUTO_NOTIFY_THRESHOLD ]] && return
  # (send notification here)
}

# Trap SIGINT to possibly cancel notification
__aan_sigint_trap() {
  if [[ $AUTO_NOTIFY_CANCEL_ON_SIGINT -eq 1 ]]; then
    __aan_ignore=1
  fi
}

# Setup traps and prompt command hooks
__aan_setup() {
  trap '__aan_preexec' DEBUG
  trap '__aan_sigint_trap' SIGINT

  # Append our pre-command function to PROMPT_COMMAND
  if [[ "$PROMPT_COMMAND" != *"__aan_precmd"* ]]; then
    if [ -z "$PROMPT_COMMAND" ]; then
      PROMPT_COMMAND='__aan_precmd'
    else
      PROMPT_COMMAND="__aan_precmd; $PROMPT_COMMAND"
    fi
  fi
}

__aan_setup
