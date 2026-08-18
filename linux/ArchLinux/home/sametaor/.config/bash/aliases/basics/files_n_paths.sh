# Basic aliases (converted from your zsh)
alias c='clear'
alias rm='rm -ir'
alias rmf='rm -irf'
alias cp='cp -irv'
alias mkd='mkdir -ip'
# mkz needs function (positional arg not supported by alias)
mkz() {
  mkdir -p "$1" && cd "$1"
}
alias zshrc='nvim ~/.config/zsh/.zshrc'
alias dud='du -d 1 -h'
alias duh='du -sh'
alias t='tail -f'
alias path='echo -e "${PATH//:/\\n}"'
