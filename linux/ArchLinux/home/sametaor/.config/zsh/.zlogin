if [[ -f /etc/arch-release ]] && command -v ifne >/dev/null 2>&1 && command -v doas >/dev/null 2>&1; then
    sudo pacman -Syu && yay -a && sudo pacman -Qdtq | ifne sudo pacman -Rns - && sudo pacman -Scc --noconfirm && yay -a -Scc --noconfirm

elif ! command -v ifne >/dev/null 2>&1; then
    sudo pacman -Syu && yay -a
    orphans=$(sudo pacman -Qdtq)
    if [[ -n "$orphans" ]]; then
        echo "$orphans" | sudo pacman -Rns -
    fi
    sudo pacman -Scc --noconfirm && yay -a -Scc --noconfirm

fi

if [[ -f /usr/sbin/softwareupdate ]]; then
    sudo softwareupdate -ia
    
    if [[ -f /usr/local/bin/brew ]]; then
      brew upgrade
    fi
fi
