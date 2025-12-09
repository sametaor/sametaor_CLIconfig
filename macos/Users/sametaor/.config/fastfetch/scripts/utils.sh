get_cursor_position() {
  exec </dev/tty
  oldstty=$(stty -g)
  stty raw -echo min 0 time 1
  echo -en "\033[6n" >/dev/tty
  IFS=';' read -r -d R row col
  stty "$oldstty"
  row=${row#*[}
  echo "$row $col"
}

# Due credits go to AslanLM and his project, Gifetch. Project link:- https://github.com/AslanLM/Gifetch
