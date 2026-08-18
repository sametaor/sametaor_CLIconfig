## venv settings
: ${PYTHON_VENV_NAME:=venv}

# Array of possible virtual environment names to look for, in order
# -U for removing duplicates
typeset -gaU PYTHON_VENV_NAMES
[[ -n "$PYTHON_VENV_NAMES" ]] || PYTHON_VENV_NAMES=($PYTHON_VENV_NAME venv .venv)

# Activate a the python virtual environment specified.
# If none specified, use the first existing in $PYTHON_VENV_NAMES.
function vrun() {
  if [[ -z "$1" ]]; then
    local name
    for name in $PYTHON_VENV_NAMES; do
      local venvpath="${name:P}"
      if [[ -d "$venvpath" ]]; then
        vrun "$name"
        return $?
      fi
    done
    echo >&2 "Error: no virtual environment found in current directory"
  fi

  local name="${1:-$PYTHON_VENV_NAME}"
  local venvpath="${name:P}"

  if [[ ! -d "$venvpath" ]]; then
    echo >&2 "Error: no such venv in current directory: $name"
    return 1
  fi

  if [[ ! -f "${venvpath}/bin/activate" ]]; then
    echo >&2 "Error: '${name}' is not a proper virtual environment"
    return 1
  fi

  . "${venvpath}/bin/activate" || return $?
  echo "Activated virtual environment ${name}"
}

# Create a new virtual environment using the specified name.
# If none specified, use $PYTHON_VENV_NAME
function mkv() {
  local name="${1:-$PYTHON_VENV_NAME}"
  local venvpath="${name:P}"

  python3 -m venv "${name}" || return
  echo >&2 "Created venv in '${venvpath}'"
  vrun "${name}"
}

if [[ "$PYTHON_AUTO_VRUN" == "true" ]]; then
  # Automatically activate venv when changing dir
  function auto_vrun() {
    # deactivate if we're on a different dir than VIRTUAL_ENV states
    # we don't deactivate subdirectories!
    if (( $+functions[deactivate] )) && [[ $PWD != ${VIRTUAL_ENV:h}* ]]; then
      deactivate > /dev/null 2>&1
    fi

    if [[ $PWD != ${VIRTUAL_ENV:h} ]]; then
      local file
      for file in "${^PYTHON_VENV_NAMES[@]}"/bin/activate(N.); do
        # make sure we're not in a venv already
        (( $+functions[deactivate] )) && deactivate > /dev/null 2>&1
        source $file > /dev/null 2>&1
        break
      done
    fi
  }
  add-zsh-hook chpwd auto_vrun
  auto_vrun
fi