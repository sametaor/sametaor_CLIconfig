#!/bin/bash
set -e

# Check for AUR helper
if [ -x /usr/bin/paru ] && [[ $EUID -ne 0 ]]; then
    upd_cmd="paru -Su"
    echo "Detected Paru, using it to update the system.."
elif [ -x /usr/bin/topgrade ] && [[ $EUID -ne 0 ]]; then
    upd_cmd="topgrade"
    echo "Detected Topgrade, using it to update the system.."
elif [ -x /usr/bin/yay ] && [[ $EUID -ne 0 ]]; then
    upd_cmd="yay -Su"
    echo "Detected Yay, using it to update the system.."
else
    upd_cmd="sudo pacman -Su"
    if [[ $EUID -ne 0 ]]; then
        echo "No AUR helper installed, using Pacman to update.."
    else
        echo "Executed as root, using Pacman to update.."
    fi
fi 

if [ -x /usr/bin/reflector ]; then
    # Refresh mirrorlist
    echo "Refreshing mirrorlists.."
    sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist || { echo -e "\033[1;31m\nFailed to update mirrorlist\n\033[0m"; }
fi

echo ""

# Update pacman Files database
sudo pacman -Fy
echo ""

# Update mlocate index
if [ -x /usr/bin/locate ]; then 
    echo "Updating mlocate index.."
    sudo updatedb
fi 
echo ""

echo ""
echo "System updated! 🐧"
