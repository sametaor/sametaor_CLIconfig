# Define 'y' function for yazi+zoxide navigation
# Add a `y` function to zsh that opens ranger either at the given directory or
# at the one zoxide suggests
y() {
  if [ "$1" != "" ]; then
    if [ -d "$1" ]; then
      yazi "$1"
    else
      yazi "$(zoxide query $1)"
    fi
  else
    yazi
  fi
    return $?
}