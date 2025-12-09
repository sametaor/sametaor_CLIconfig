# --- Source per-user configuration (if present) ---
if [[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/bash/plugin-opts/alias-tips.sh" ]]; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}/bash/plugin-opts/alias-tips.sh"
fi

# --- Defaults if not set in opts file ---
: "${ALIASTIPS_COLOR:=$'\e[38;2;59;120;254m'}"   # Custom blue for alias tips
: "${ALIASTIPS_RESET:=$'\e[0m'}"
: "${ALIASTIPS_SHOW_COLOR:=1}"
: "${ALIASTIPS_LABEL:=󰛩' Alias tip:'}"
: "${ALIASTIPS_PREFIX:=0}"
: "${ALIASTIPS_MIN_WORDS:=1}"
: "${ALIASTIPS_IGNORE_CMDS:=ls cd pwd clear exit}"
ALIASTIPS_IGNORE_CMDS=($ALIASTIPS_IGNORE_CMDS)

declare -A ALIASTIPS_MAP        # alias name -> expansion
declare -A ALIASTIPS_BY_CMD     # first word of expansion -> "alias1 alias2 ..."
declare -A ALIASTIPS_NAMES      # Set/list of all alias names

# --- Gather current aliases, build lookup maps ---
alias_tips_refresh() {
  ALIASTIPS_MAP=()
  ALIASTIPS_BY_CMD=()
  ALIASTIPS_NAMES=()
  local line name raw exp head
  while IFS= read -r line; do
    [[ $line == alias\ *=* ]] || continue
    name=${line#alias }
    name=${name%%=*}
    ALIASTIPS_NAMES["$name"]=1
    raw=${line#alias $name=}
    if [[ $raw == \'*\' ]]; then
      exp=${raw:1:-1}
    else
      exp=$raw
    fi
    # Skip if expansion contains pipes, etc.
    [[ $exp == *[';&|><(){}$`']* ]] && continue
    read -r -a _arr <<< "$exp"
    (( ${#_arr[@]} >= ALIASTIPS_MIN_WORDS )) || continue
    ALIASTIPS_MAP["$name"]="$exp"
    head=${exp%%[[:space:]]*}
    if [[ -n ${ALIASTIPS_BY_CMD[$head]:-} ]]; then
      ALIASTIPS_BY_CMD[$head]+=" $name"
    else
      ALIASTIPS_BY_CMD[$head]="$name"
    fi
  done < <(alias -p)
}

# --- Show the tip in chosen color/format ---
_alias_tips_show() {
  local msg="$1"
  if [[ $ALIASTIPS_SHOW_COLOR -eq 1 ]]; then
    printf '%b\n' "${ALIASTIPS_COLOR}${ALIASTIPS_LABEL} ${msg}${ALIASTIPS_RESET}" >&2
  else
    printf '%s %s\n' "${ALIASTIPS_LABEL}" "$msg" >&2
  fi
}

# --- Preexec: analyze command pre-execution ---
alias_tips_preexec() {
  [[ -n $ALIASTIPS__in_preexec ]] && return
  ALIASTIPS__in_preexec=1
  local cmdline="$1"
  [[ -z $cmdline ]] && { ALIASTIPS__in_preexec=; return; }
  local user_cmd="${cmdline##[[:space:]]}"  # Remove leading spaces

  # Check minimum word count
  if (( $(wc -w <<< "$user_cmd") < ALIASTIPS_MIN_WORDS )); then
    ALIASTIPS_NEXT_TIP=
    ALIASTIPS__in_preexec=
    return
  fi

  # Get first word, skip if ignored or it IS an alias itself
  local first=${user_cmd%%[[:space:]]*}
  for ignore in "${ALIASTIPS_IGNORE_CMDS[@]}"; do
    [[ "$first" == "$ignore" ]] && ALIASTIPS_NEXT_TIP= ALIASTIPS__in_preexec= && return
  done
  [[ -n ${ALIASTIPS_NAMES[$first]:-} ]] && ALIASTIPS_NEXT_TIP= ALIASTIPS__in_preexec= && return

  local tip="" name exp
  local candidates="${ALIASTIPS_BY_CMD[$first]:-}"
  [[ -z $candidates ]] && ALIASTIPS_NEXT_TIP= ALIASTIPS__in_preexec= && return

  for name in $candidates; do
    exp="${ALIASTIPS_MAP[$name]}"
    [[ -z $exp ]] && continue
    if (( ALIASTIPS_PREFIX )); then
      if [[ "$user_cmd" == "$exp" || "$user_cmd" == "$exp "* ]]; then
        tip="$name → $exp"
        break
      fi
    else
      if [[ "$user_cmd" == "$exp" ]]; then
        tip="$name → $exp"
        break
      fi
    fi
  done

  ALIASTIPS_NEXT_TIP="$tip"
  ALIASTIPS__in_preexec=
}

# --- Precmd: show tip and refresh if needed ---
alias_tips_precmd() {
  if [[ -n $ALIASTIPS_DIRTY ]]; then
    alias_tips_refresh
    ALIASTIPS_DIRTY=
  fi
  if [[ -n $ALIASTIPS_NEXT_TIP ]]; then
    _alias_tips_show "$ALIASTIPS_NEXT_TIP"
    ALIASTIPS_NEXT_TIP=
  fi
}

# --- Monitor alias/unalias for changes (refresh maps) ---
alias_tips_alias_mon() {
  local cmd="${BASH_COMMAND##[[:space:]]}"
  if [[ $cmd == alias* || $cmd == unalias* ]]; then
    ALIASTIPS_DIRTY=1
  fi
}
preexec_functions+=(alias_tips_alias_mon)

# --- Register with bash-preexec's hooks ---
preexec_functions+=(alias_tips_preexec)
precmd_functions+=(alias_tips_precmd)

# --- Initialize at shell load ---
alias_tips_refresh