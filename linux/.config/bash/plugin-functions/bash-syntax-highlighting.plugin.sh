#!/usr/bin/env bash
# bash-fast-syntax-highlighting.sh — minimalistic syntax highlighting in Bash prompt

# Color codes (customize or extend as desired)
readonly __bfsh_red="\e[31m"
readonly __bfsh_green="\e[32m"
readonly __bfsh_yellow="\e[33m"
readonly __bfsh_blue="\e[34m"
readonly __bfsh_cyan="\e[36m"
readonly __bfsh_reset="\e[0m"
readonly __bfsh_bold="\e[1m"

# Keywords to highlight (simple example)
readonly __bfsh_keywords="if then else fi for while do done case esac function return"

# Function to escape regex special characters in word list
__bfsh_escape_regex() {
  sed 's/[][\/.^$*]/\\&/g'
}

# Colorize keywords in prompt using PS1 (prompt string)
__bfsh_prompt_command() {
  local input="${READLINE_LINE}"
  # Replace keywords with colored keywords
  local keywords_pattern
  keywords_pattern=$(echo "$__bfsh_keywords" | tr ' ' '\n' | __bfsh_escape_regex | paste -sd'|' -)

  # Use sed for keyword coloring
  local colored_line
  colored_line=$(echo "$input" | sed -E "s/\b($keywords_pattern)\b/${__bfsh_blue}&${__bfsh_reset}/g")

  # Overwrite prompt line (this is limited & approximate)
  # WARNING: This only affects PS1 prompt display, not inline editing syntax highlighting
  # For real-time inline, consider using external tools like "rlwrap" with syntax highlighters

  # Optional: update PS1 dynamically or use PROMPT_COMMAND for coloring

  # This example sets PS1 with the last command colored — demonstration only
  PS1="${__bfsh_cyan}\w${__bfsh_reset} $colored_line"
}

# Hook PROMPT_COMMAND to update PS1
PROMPT_COMMAND="__bfsh_prompt_command${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

# Note: This is a minimal demonstration and does not fully replicate fast-syntax-highlighting capabilities.