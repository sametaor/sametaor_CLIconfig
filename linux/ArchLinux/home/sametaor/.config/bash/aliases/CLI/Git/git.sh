# git.sh — Git aliases and functions for Bash

alias ga="git add"
alias gall="git add ."
alias gb="git branch"
alias gba="git branch -a"
alias gc="git commit -v"
alias gca="git commit -v -a"
alias gci="git commit --interactive"
alias gcl="git clone"
alias gcm="git commit -v -m"
alias gdel="git branch -D"
alias gexport="git archive --format=zip --output"
alias gl="git pull"
alias gm="git merge"
alias gp="git push"

# 'gpp' (pull & push) as a function to handle errors gracefully:
gpp() { git pull && git push; }

alias gpr="git pull --rebase"
alias gs="git status"
alias gw="git whatchanged"

# git-send: commit all changes with a message and push
git-send() { git add . && git commit -m "$1" && git push; }