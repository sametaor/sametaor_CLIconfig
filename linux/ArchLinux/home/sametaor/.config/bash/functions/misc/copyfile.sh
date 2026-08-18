copyfile() {
  if [ -z "$1" ]; then
    echo "Usage: copyfile <file>" >&2
    return 1
  fi
  clipcopy "$1"
}