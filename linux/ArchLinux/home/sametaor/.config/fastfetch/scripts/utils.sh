get_cursor_position() {
  exec </dev/tty
  oldstty=$(stty -g)
  stty raw -echo min 0 time 1
  while read -r -t 0.01; do : ; done
  echo -en "\033[6n" >/dev/tty
  IFS=';' read -r -d R row col
  stty "$oldstty"
  row=${row#*[}
  row=${row//[^0-9]/}
  col=${col//[^0-9]/}
  echo "${row:-1} ${col:-1}"
}

# Due credits go to AslanLM and his project, Gifetch. Project link:- https://github.com/AslanLM/Gifetch
