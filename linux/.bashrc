#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

complete -F _command doas

eval "$(oh-my-posh init bash --config 'https://raw.githubusercontent.com/sametaor/sametaor_CLIconfig/refs/heads/master/misc/sametaor.omp.json')"
eval "$(zoxide init bash)"

sudo pacman -Syu && yay -a && sudo pacman -Qdtq | ifne sudo pacman -Rns - && sudo pacman -Scc --noconfirm && yay -a -Scc --noconfirm

clear

fastfetch
