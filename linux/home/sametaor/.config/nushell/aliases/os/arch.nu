# Pacman
export alias pacupg = sudo pacman -Syu
export alias pacin = sudo pacman -S
export alias paclean = sudo pacman -Sc
export alias pacins = sudo pacman -U
export alias paclr = sudo pacman -Scc
export alias pacre = sudo pacman -R
export alias pacrem = sudo pacman -Rns
export alias pacrep = pacman -Si
export alias pacreps = pacman -Ss
export alias pacloc = pacman -Qi
export alias paclocs = pacman -Qs
export alias pacinsd = sudo pacman -S --asdeps
export alias pacmir = sudo pacman -Syy
export alias paclsorphans = sudo pacman -Qdt

export def pacrmorphans [] {
  sudo pacman -Rs (pacman -Qtdq)
}

export alias pacfileupg = sudo pacman -Fy
export alias pacfiles = pacman -F
export alias pacls = pacman -Ql

export alias pacown = pacman -Qo
export alias pacupd = sudo pacman -Sy
export alias pacmanallkeys = sudo pacman-key --refresh-keys

export def paclist [] {
  pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}
export def pacsearch [] {
  pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse
}

export def pactree [pkg: string] {
  sudo pactree $pkg
}
export def pacwhy [pkg: string] {
  sudo pactree -r $pkg
}
export alias paccacherm = sudo paccache -r

# Yay
export alias yaconf = yay -Pg
export alias yaclean = yay -Sc
export alias yaclr = yay -Scc
export alias yaupg = yay -Syu
export alias yasu = yay -Syu --noconfirm
export alias yain = yay -S
export alias yains = yay -U
export alias yare = yay -R
export alias yarem = yay -Rns
export alias yarep = yay -Si
export alias yareps = yay -Ss
export alias yaloc = yay -Qi
export alias yalocs = yay -Qs
export alias yalst = yay -Qe
export alias yaorph = yay -Qtd
export alias yainsd = yay -S --asdeps
export alias yamir = yay -Syy
export alias yaupd = yay -Sy
