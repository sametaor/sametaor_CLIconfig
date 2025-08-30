abbr -a pacupg 'sudo pacman -Syu'
abbr -a pacin 'sudo pacman -S'
abbr -a paclean 'sudo pacman -Sc'
abbr -a pacins 'sudo pacman -U'
abbr -a paclr 'sudo pacman -Scc'
abbr -a pacre 'sudo pacman -R'
abbr -a pacrem 'sudo pacman -Rns'
abbr -a pacrep 'pacman -Si'
abbr -a pacreps 'pacman -Ss'
abbr -a pacloc 'pacman -Qi'
abbr -a paclocs 'pacman -Qs'
abbr -a pacinsd 'sudo pacman -S --asdeps'
abbr -a pacmir 'sudo pacman -Syy'
abbr -a paclsorphans 'sudo pacman -Qdt'
abbr -a pacrmorphans 'sudo pacman -Rs (pacman -Qtdq)'
abbr -a pacfileupg 'sudo pacman -Fy'
abbr -a pacfiles 'pacman -F'
abbr -a pacls 'pacman -Ql'
abbr -a pacown 'pacman -Qo'
abbr -a pacupd 'sudo pacman -Sy'
abbr -a pacmanallkeys 'sudo pacman-key --refresh-keys'
abbr -a paclist "pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
abbr -a pacsearch "pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse"
abbr -a paccacherm 'sudo paccache -r'
abbr -a pactree 'sudo pactree'
abbr -a pacwhy 'sudo pactree -r'
function pacown
  sudo pacman -Qo $argv
end
function pactree
  sudo pactree $argv
end
function pacwhy
  sudo pactree -r $argv
end
abbr -a yaconf 'yay -Pg'
abbr -a yaclean 'yay -Sc'
abbr -a yaclr 'yay -Scc'
abbr -a yaupg 'yay -Syu'
abbr -a yasu 'yay -Syu --noconfirm'
abbr -a yain 'yay -S'
abbr -a yains 'yay -U'
abbr -a yare 'yay -R'
abbr -a yarem 'yay -Rns'
abbr -a yarep 'yay -Si'
abbr -a yareps 'yay -Ss'
abbr -a yaloc 'yay -Qi'
abbr -a yalocs 'yay -Qs'
abbr -a yalst 'yay -Qe'
abbr -a yaorph 'yay -Qtd'
abbr -a yainsd 'yay -S --asdeps'
abbr -a yamir 'yay -Syy'
abbr -a yaupd 'yay -Sy'