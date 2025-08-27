#!/usr/bin/env bash
# alias-tips for Bash: remind when you type long form instead of an alias.
# Pure Bash, no external deps. If ble.sh is present, uses blehook automatically.

# Load user options if present
PLUGIN_OPTS="${HOME}/.config/bash/plugin-opts/alias-tips.sh"
if [ -f "$PLUGIN_OPTS" ]; then
  # shellcheck source=/dev/null
  source "$PLUGIN_OPTS"
fi

# ---------------------------------------
# Config (override via env before sourcing)
# ---------------------------------------
: "${ALIASTIPS_PREFIX:=1}"       # 1: match when command STARTS WITH alias expansion; 0: exact match only
: "${ALIASTIPS_MIN_WORDS:=2}"    # ignore aliases whose expansion has fewer than N words (avoid noise like g=git)
: "${ALIASTIPS_SHOW_COLOR:=1}"   # 1: faint gray, 0: no color
: "${ALIASTIPS_LABEL:=alias tip}"# label in the printed hint

# ---------------------------------------
# Internal state
# ---------------------------------------
declare -gA ALIASTIPS_MAP=()       # aliasName -> expansion
declare -gA ALIASTIPS_BY_CMD=()    # firstWord -> "alias1 alias2 ..."
declare -gA ALIASTIPS_NAMES=()     # aliasName -> 1 (for quick existence test)
declare -g  ALIASTIPS_NEXT_TIP=
declare -g  ALIASTIPS_LAST_CMD=
declare -g  ALIASTIPS_DIRTY=
declare -g  ALIASTIPS__in_preexec=

# Colors
if [[ -t 2 && $ALIASTIPS_SHOW_COLOR -eq 1 && -z ${NO_COLOR:-} ]]; then
  ALIASTIPS_COLOR=$'\e[90m'   # faint/bright black
  ALIASTIPS_RESET=$'\e[0m'
else
  ALIASTIPS_COLOR=
  ALIASTIPS_RESET=
fi

# ---------------------------------------
# Utils
# ---------------------------------------
alias_tips__unescape_single_quoted() {
  local s=$1
  s=${s//\'\\\'\'/\'}
  printf %s "$s"
}

alias_tips_refresh() {
  ALIASTIPS_MAP=()
  ALIASTIPS_BY_CMD=()
  ALIASTIPS_NAMES=()

  local line name raw exp
  while IFS= read -r line; do
    [[ $line == alias\ *=* ]] || continue
    name=${line#alias }
    name=${name%%=*}
    ALIASTIPS_NAMES["$name"]=1

    raw=${line#alias $name=}
    if [[ $raw == \'*\' ]]; then
      exp=${raw:1:-1}
      exp=$(alias_tips__unescape_single_quoted "$exp")
    else
      exp=$raw
    fi

    if [[ $exp == *[';&|><(){}$`']* ]]; then
      continue
    fi

    local _arr
    read -r -a _arr <<< "$exp"
    local words=${#_arr[@]}
    (( words >= ALIASTIPS_MIN_WORDS )) || continue

    ALIASTIPS_MAP["$name"]=$exp

    local head=${exp%%[[:space:]]*}
    if [[ -n ${ALIASTIPS_BY_CMD[$head]:-} ]]; then
      ALIASTIPS_BY_CMD[$head]+=" $name"
    else
      ALIASTIPS_BY_CMD[$head]=$name
    fi
  done < <(alias -p)
}

alias_tips_preexec() {
  [[ -n $ALIASTIPS__in_preexec ]] && return
  ALIASTIPS__in_preexec=1

  local cmd=$BASH_COMMAND
  cmd=${cmd##[[:space:]]}
  [[ -z $cmd ]] && { ALIASTIPS__in_preexec=; return; }

  local first=${cmd%%[[:space:]]*}
  if [[ $first == alias || $first == unalias ]]; then
    ALIASTIPS_DIRTY=1
  fi

  if [[ -n ${ALIASTIPS_NAMES[$first]:-} ]]; then
    ALIASTIPS__in_preexec=
    return
  fi

  local candidates=${ALIASTIPS_BY_CMD[$first]:-}
  [[ -n $candidates ]] || { ALIASTIPS__in_preexec=; return; }

  local name exp tip=""
  for name in $candidates; do
    exp=${ALIASTIPS_MAP[$name]}
    [[ -n $exp ]] || continue
    if (( ALIASTIPS_PREFIX )); then
      if [[ $cmd == "$exp" || $cmd == "$exp "* ]]; then
        tip=$name; break
      fi
    else
      if [[ $cmd == "$exp" ]]; then
        tip=$name; break
      fi
    fi
  done

  if [[ -n $tip && $cmd != "$ALIASTIPS_LAST_CMD" ]]; then
    ALIASTIPS_NEXT_TIP="${ALIASTIPS_LABEL}: ${tip} -> ${ALIASTIPS_MAP[$tip]}"
    ALIASTIPS_LAST_CMD=$cmd
  else
    ALIASTIPS_NEXT_TIP=
  fi

  ALIASTIPS__in_preexec=
}

alias_tips_precmd() {
  local st=$?

  if [[ -n $ALIASTIPS_DIRTY ]]; then
    alias_tips_refresh
    ALIASTIPS_DIRTY=
  fi

  if [[ -n $ALIASTIPS_NEXT_TIP ]]; then
    printf '%b\n' "${ALIASTIPS_COLOR}${ALIASTIPS_NEXT_TIP}${ALIASTIPS_RESET}" >&2
    ALIASTIPS_NEXT_TIP=
  fi

  return $st
}

alias_tips_enable() {
  [[ $- == *i* ]] || return 0

  alias_tips_refresh

#  if type -t blehook >/dev/null 2>&1; then
#    blehook ble/widget/accept-line += alias_tips_preexec
#    blehook ble/prompt/prepare += alias_tips_precmd
#  else
    trap 'alias_tips_preexec' DEBUG
    case ";$PROMPT_COMMAND;" in
      *";alias_tips_precmd;"*) : ;;
      *) PROMPT_COMMAND="alias_tips_precmd${PROMPT_COMMAND:+;$PROMPT_COMMAND}" ;;
    esac
#  fi
}

alias_tips_disable() {
#  if type -t blehook >/dev/null 2>&1; then
#    blehook preexec-=alias_tips_preexec 2>/dev/null || true
#    blehook prompt-=alias_tips_precmd 2>/dev/null || true
#  else
    trap - DEBUG
    PROMPT_COMMAND="${PROMPT_COMMAND//alias_tips_precmd; }"
    PROMPT_COMMAND="${PROMPT_COMMAND//alias_tips_precmd}"
    PROMPT_COMMAND="${PROMPT_COMMAND/#; /}"
#  fi
}

alias_tips_rebuild() { alias_tips_refresh; }

alias_tips_enable
# End of alias-tips.sh