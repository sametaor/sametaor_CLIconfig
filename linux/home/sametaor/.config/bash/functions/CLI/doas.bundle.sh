# doas.bundle.sh — Bash toggle wrapper for "doas" command prefix

_doas_command_line() {
  # Read the current command line buffer
  local line
  # Use Readline's builtin to get line content (Bash 4+)
  line=$(bind -x '"\C-e": echo')   # Dummy to initialize
  # Safe fallback: use READLINE_LINE variable if available (in bind -x)
  line=$READLINE_LINE
  
  if [[ $line == doas\ * ]]; then
    # Remove 'doas ' prefix from beginning of the line
    READLINE_LINE=${line#doas }
  else
    # Prepend 'doas ' to the current line
    READLINE_LINE="doas $line"
  fi
  
  # Set the cursor position to the start of the line or end of 'doas '
  READLINE_POINT=${#READLINE_LINE}
}

# Bind to a key in Readline (example: Escape Escape)
bind -x '"\e\e": _doas_command_line'