# pyenv.bundle.sh — Python virtual environment management functions for Bash

# Default venv name
: "${PYTHON_VENV_NAME:=venv}"

# Define an array of virtual environment names (removing duplicates manually if needed)
PYTHON_VENV_NAMES=("$PYTHON_VENV_NAME" "venv" ".venv")

# Activate the specified or first existing virtual environment in current dir
vrun() {
  local name=${1:-}
  if [ -z "$name" ]; then
    local found=false
    for name in "${PYTHON_VENV_NAMES[@]}"; do
      if [ -d "$name" ]; then
        found=true
        break
      fi
    done
    if [ "$found" = false ]; then
      echo "Error: no virtual environment found in current directory" >&2
      return 1
    fi
  fi
  local venvpath="$name"

  if [ ! -d "$venvpath" ]; then
    echo "Error: no such venv in current directory: $name" >&2
    return 1
  fi

  if [ ! -f "$venvpath/bin/activate" ]; then
    echo "Error: '$name' is not a proper virtual environment" >&2
    return 1
  fi

  # shellcheck disable=SC1090
  . "$venvpath/bin/activate" || return $?
  echo "Activated virtual environment ${name}"
}

# Create new venv with specified name (default PYTHON_VENV_NAME) and activate it
mkv() {
  local name=${1:-$PYTHON_VENV_NAME}
  python3 -m venv "$name" || return $?
  echo "Created venv in '$name'" >&2
  vrun "$name"
}

# Automatically activate virtualenv on directory change if PYTHON_AUTO_VRUN=true
if [ "${PYTHON_AUTO_VRUN:-}" = "true" ]; then
  _previous_venv="$VIRTUAL_ENV"
  auto_vrun() {
    # Deactivate if left original venv directory (ignoring subdirs)
    if [ -n "$(type -t deactivate)" ] && [[ $PWD != "$_previous_venv"* ]]; then
      deactivate >/dev/null 2>&1
    fi

    # Activate if any venv found among known names
    for prefix in "${PYTHON_VENV_NAMES[@]}"; do
      if [ -f "${prefix}/bin/activate" ]; then
        [ -n "$(type -t deactivate)" ] && deactivate >/dev/null 2>&1
        # shellcheck disable=SC1090
        source "${prefix}/bin/activate" >/dev/null 2>&1
        _previous_venv="$VIRTUAL_ENV"
        break
      fi
    done
  }
  PROMPT_COMMAND="auto_vrun${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
  auto_vrun
fi
