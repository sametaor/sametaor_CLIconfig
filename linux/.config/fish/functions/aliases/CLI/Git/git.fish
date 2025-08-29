# Git aliases and functions for Fish (ported from bash/zsh)
alias ga 'git add'
alias gall 'git add .'
alias gb 'git branch'
alias gba 'git branch -a'
alias gc 'git commit -v'
alias gca 'git commit -v -a'
alias gci 'git commit --interactive'
alias gcl 'git clone'
alias gcm 'git commit -v -m'
alias gdel 'git branch -D'
alias gexport 'git archive --format=zip --output'
alias gl 'git pull'
alias gm 'git merge'
alias gp 'git push'
function gpp
    git pull; and git push
end
alias gpr 'git pull --rebase'
alias gs 'git status'
alias gw 'git whatchanged'
function git-send
    git add .; and git commit -m $argv[1]; and git push
end
