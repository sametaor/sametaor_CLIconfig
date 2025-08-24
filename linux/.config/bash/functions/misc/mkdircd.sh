mkdircd() {
  if [ -z "$1" ]; then
    echo "Usage: mkdircd <directory>" >&2
    return 1
  fi
  mkdir -p -- "$1" && cd -- "$1"
}