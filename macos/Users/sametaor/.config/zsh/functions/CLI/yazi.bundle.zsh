# Define 'y' function for yazi+zoxide navigation
# Add a `y` function to zsh that opens ranger either at the given directory or
# at the one zoxide suggests
#y() {
# if [ "$1" != "" ]; then
#   if [ -d "$1" ]; then
#      yazi "$1"
#    else
#      yazi "$(zoxide query $1)"
#    fi
#  else
#    yazi
#  fi
#    return $?
#}


y() {
  echo "arg: '$1'"
  if [ -n "$1" ]; then
    if [ -d "$1" ]; then
      echo "calling: yazi '$1'"
      yazi "$1"
    else
      echo "calling: yazi \$(zoxide query '$1')"
      yazi "$(zoxide query "$1")"
    fi
  else
    echo "calling: yazi"
    yazi
  fi
}

# Reused from https://github.com/fdw/yazi-zoxide-zsh/blob/main/ranger-zoxide.plugin.zsh
