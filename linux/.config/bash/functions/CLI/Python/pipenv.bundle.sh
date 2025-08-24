# pipenv.bundle.sh — Bash equivalent of zsh _pipenv_chpwd hook

# Track previous directory to detect changes
export PREV_PWD=""

_pipenv_chpwd() {
  local SHOULD_CD=false

  # Check if Pipfile exists in cwd or parent dirs (up to two levels)
  if [[ ! -e "$PWD/Pipfile" ]]; then
    if [[ ! -e "$PWD/../Pipfile" ]]; then
      if [[ ! -e "$PWD/../../Pipfile" ]]; then
        return
      else
        SHOULD_CD=true
      fi
    else
      SHOULD_CD=true
    fi
  fi

  # Check if PIPENV_ACTIVE is unset or empty
  if [[ -z "$PIPENV_ACTIVE" ]]; then
    if pipenv --venv >/dev/null 2>&1; then
      if [[ "$SHOULD_CD" == true ]]; then
        pipenv shell "cd $PWD"
      else
        pipenv shell
      fi
    fi
  fi
}

# Wrapper to check directory change and run _pipenv_chpwd
_check_dir_change() {
  if [[ "$PREV_PWD" != "$PWD" ]]; then
    _pipenv_chpwd
    PREV_PWD="$PWD"
  fi
}

# Setup PROMPT_COMMAND hook to call our checker before each prompt
PROMPT_COMMAND="_check_dir_change${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

# Run once on initial shell load if pipenv is installed
if command -v pipenv >/dev/null 2>&1; then
  _pipenv_chpwd
fi
