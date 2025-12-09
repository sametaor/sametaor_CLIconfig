if test -f /etc/arch-release; and command -q ifne; and command -q doas
    sudo pacman -Syu; and yay -a; and sudo pacman -Qdtq | ifne sudo pacman -Rns -; and sudo pacman -Scc --noconfirm; and yay -a -Scc --noconfirm

else if not command -q ifne
    sudo pacman -Syu; and yay -a

    set -l orphans (sudo pacman -Qdtq)
    if test -n "$orphans"
        printf '%s\n' $orphans | sudo pacman -Rns -
    end

    sudo pacman -Scc --noconfirm; and yay -a -Scc --noconfirm
end

if test -f /usr/sbin/softwareupdate
    sudo softwareupdate -ia

    if test -f /usr/local/bin/brew
        brew upgrade
    end
end
