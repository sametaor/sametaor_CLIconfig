# dotnet.sh — Bash completion for .NET CLI

# Add .dotnet/tools to PATH so global tools are found
export PATH="$PATH:$HOME/.dotnet/tools"

_dotnet_bash_complete() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  IFS=$'\n'  # handle newlines in completions
  local candidates

  # Capture possible completions via dotnet complete
  read -d '' -ra candidates < <(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)

  # Generate programmable completion reply list
  read -d '' -ra COMPREPLY < <(compgen -W "${candidates[*]:-}" -- "$cur")
}

# Register the completion function with Bash's complete builtin
complete -o default -F _dotnet_bash_complete dotnet