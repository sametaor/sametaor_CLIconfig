##############################################################################
#  Ephemeral directory listing after every  z  (zoxide) jump
#  – works even for thousands of lines, never pollutes scroll-back
##############################################################################

# 1  Wrapper
z() {
  # 0. If no args: default to zoxide-original behaviour (HOME jump)
  (( $# == 0 )) && { builtin cd -- "$HOME"; return }

  # 1. If the first arg looks like an absolute or relative path, just cd
  #     • begins with /   → absolute
  #     • begins with .   → ./something  or  ../something
  #     • begins with ~   → home expansion
  case $1 in
    (/*|.~*|.*) builtin cd -- "$1" && _z_after_zoxide_cd; return ;;
  esac

  # 2. Else ask zoxide.  If it fails, try cd anyway (covers /root etc.)
  local dest
  if dest=$(command zoxide query -- "$@"); then
    builtin cd -- "$dest"
  else
    builtin cd -- "$1" 2>/dev/null || return  # honour shell errors
  fi

  _z_after_zoxide_cd                           # schedule once-off listing
}

# 2  Install a *single* precmd hook each time z() succeeds
_z_after_zoxide_cd() {
  add-zsh-hook -D precmd _zoxide_ephemeral_list        # remove any old copy
  add-zsh-hook    precmd _zoxide_ephemeral_list
}

# 3  The one-shot hook
_zoxide_ephemeral_list() {
  add-zsh-hook -D precmd _zoxide_ephemeral_list        # self-destruct

  # Enter alternate screen ─ nothing shown here reaches the main buffer
  tput smcup                                           # save screen
  tput civis                                           # hide cursor

  if command -v eza &>/dev/null; then
    eza -a -l --icons=always --colour=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o -G       # your preferred flags
  else
    ls -CF --color=auto
  fi

  # Prompt the user; -n disables newline echo, -s “silent”, 1 char, 10-s timeout
  printf '\nPress any key to continue… '
  read -s -t 10 -k 1                                  # key or 10-s fall-back

  # Leave alternate screen (restores original contents instantly)
  tput cnorm                                           # show cursor
  tput rmcup                                           # restore screen
}