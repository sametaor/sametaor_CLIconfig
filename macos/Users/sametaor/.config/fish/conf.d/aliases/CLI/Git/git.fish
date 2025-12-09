# Git aliases and functions for Fish (ported from bash/zsh)
abbr -a ga 'git add'
abbr -a gall 'git add .'
abbr -a gb 'git branch'
abbr -a gba 'git branch -a'
abbr -a gc 'git commit -v'
abbr -a gca 'git commit -v -a'
abbr -a gci 'git commit --interactive'
abbr -a gcl 'git clone'
abbr -a gcm 'git commit -v -m'
abbr -a gdel 'git branch -D'
abbr -a gexport 'git archive --format=zip --output'
abbr -a gl 'git pull'
abbr -a gm 'git merge'
abbr -a gp 'git push'
function gpp
    git pull; and git push
end
abbr -a gpr 'git pull --rebase'
abbr -a gs 'git status'
abbr -a gw 'git whatchanged'
function git-send
    git add .; and git commit -m $argv[1]; and git push
end
