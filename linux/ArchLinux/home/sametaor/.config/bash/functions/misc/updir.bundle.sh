# Bash function to move up N directories
updir() {
  local n=${1:-1}
  if (( n < 1 || n > 99 )); then
    echo "Usage: updir <1-99>" >&2
    return 1
  fi

  local relative_path=$(printf '../%.0s' $(seq 1 $n))
  builtin cd -- "$relative_path"
}

# Create aliases z1 to z99 to quickly cd up N directories
for i in $(seq 1 99); do
  alias "z$i"="updir $i"
done