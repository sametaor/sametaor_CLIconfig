# updir: Move up N directories efficiently, using zoxide if available
updir() {
  local n=${1:-1}
  if (( n < 1 || n > 99 )); then
    echo "Usage: updir <1-99>"
    return 1
  fi
  local target=""
  # Try to use zoxide if available and not interfering
  if command -v zoxide &>/dev/null; then
    # Get the Nth parent directory using zoxide query
    target=$(zoxide query "../"$(printf '/..%.0s' $(seq 2 $n))) 2>/dev/null
    if [[ -d "$target" ]]; then
      cd "$target"
      return
    fi
  fi
  # Fallback: use builtin cd
  target=$(printf '../%.0s' $(seq 1 $n))
  cd "$target"
}

# Create z1 to z99 aliases
for i in {1..99}; do
  alias z$i="updir $i"
done
