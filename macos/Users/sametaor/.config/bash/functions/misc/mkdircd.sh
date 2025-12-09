# mkdircd.bash

function mkdircd() {
  # Check if at least one argument is provided
  if [[ $# -eq 0 ]]; then
    echo "Usage: mkdircd DIRECTORY [DIRECTORY...]" >&2
    return 1
  fi

  # Create all directories with parent directory support (-p flag)
  mkdir -p "$@" || return 1

  # cd into the last directory
  cd "${@: -1}"
}

