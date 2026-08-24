#!/usr/bin/env bash

# ───────────────────────────────────────────────────────────────
# Load all ASCII frame files
#frames=("$HOME/ascii/deus_ex/progress-"*.png.txt)
mapfile -t frames < <(printf "%s\n" "$HOME/Projects/github/sametaor_CLIconfig/linux/ArchLinux/home/sametaor/.config/fastfetch/logos/ascii/deus_ex_retrowave/"*.png.txt | sort -V)
COLOR='\e[1;94m'
RESET='\033[0m'

# ───────────────────────────────────────────────────────────────
# Load utils for cursor position
source "/home/sametaor/Projects/github/sametaor_CLIconfig/linux/ArchLinux/home/sametaor/.config/fastfetch/scripts/utils.sh"
read -r CURSOR_ROW CURSOR_COL < <(get_cursor_position)
CURSOR_ROW=${CURSOR_ROW:-1}

# Measure terminal height
TOTAL_LINES=$(tput lines)

# Measure height of one ASCII frame
FRAME_HEIGHT=$(wc -l <"${frames[0]}")
NEOFETCH_OFFSET=2 # Neofetch title line spacing
REQUIRED_SPACE=$((CURSOR_ROW + FRAME_HEIGHT + NEOFETCH_OFFSET))

# If not enough space, clear screen and remeasure position
if ((REQUIRED_SPACE >= TOTAL_LINES)); then
  clear
  read CURSOR_ROW CURSOR_COL < <(get_cursor_position)
fi

# ───────────────────────────────────────────────────────────────
# Hide cursor and switch to raw input mode (no echo, no Enter required)
tput civis
stty -echo -icanon time 0 min 0

# ───────────────────────────────────────────────────────────────
# Draw system info (neofetch) on the right once
tput cup "$CURSOR_ROW" 0
fastfetch --logo-width 0 --file ~/Projects/github/sametaor_CLIconfig/linux/ArchLinux/home/sametaor/.config/fastfetch/logos/ascii/deus_ex_retrowave/progress-0.png.txt

# ───────────────────────────────────────────────────────────────
# Principal Loop
while true; do
  for f in "${frames[@]}"; do
    tput cup "$CURSOR_ROW" 0
    echo -e "${COLOR}$(<"$f")${RESET}"
    sleep 0.025

    # ─── comprobar si hay una tecla presionada:
    if read -rsn1 -t 0; then
      break 2
    fi
  done
done

# ───────────────────────────────────────────────────────────────
# Restore normal terminal behavior
tput cup 32 0
echo
stty sane
tput cnorm

# Due credits go to AslanLM and his project, Gifetch. Project link:- https://github.com/AslanLM/Gifetch
# I used the gifetch script and modified it accordingly, feel free to reuse it in your own way!
