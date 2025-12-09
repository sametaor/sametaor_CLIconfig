if ("/etc/arch-release" | path exists ) and (not (which ifne | is-empty)) and (not (which doas | is-empty)) {
    # Run pacman update
    sudo pacman -Syu
    yay -a
    # Remove orphans via ifne
    sudo pacman -Qdtq | ^ifne sudo pacman -Rns -
    sudo pacman -Scc --noconfirm
    yay -a -Scc --noconfirm
} else if (which ifne | is-empty) {
    # Update system packages
    sudo pacman -Syu
    yay -a
    # Get list of orphan packages
    let orphans = (sudo pacman -Qdtq)
    # If orphan list is not empty, remove them individually
    if ($orphans != "") {
        echo $orphans | each { |pkg| sudo pacman -Rns $pkg }
    }
    # Clear package caches
    sudo pacman -Scc --noconfirm
    yay -a -Scc --noconfirm
}

if ("/usr/sbin/softwareupdate" | path exists ) {
    sudo softwareupdate -ia

    if ("/usr/local/bin/brew" | path exists ) {
      brew upgrade
    }
}
