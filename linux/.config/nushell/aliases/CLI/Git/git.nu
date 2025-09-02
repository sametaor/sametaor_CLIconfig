export alias ga = git add
export alias gall = git add .
export alias gb = git branch
export alias gba = git branch -a
export alias gc = git commit -v
export alias gca = git commit -v -a
export alias gci = git commit --interactive
export alias gcl = git clone
export alias gcm = git commit -v -m
export alias gdel = git branch -D
export alias gexport = git archive --format=zip --output
export alias gl = git pull
export alias gm = git merge
export alias gp = git push

# gpp is two commands; use a Nushell function for sequencing:
export def gpp [] {
  git pull
  git push
}

export alias gpr = git pull --rebase
export alias gs = git status
export alias gw = git whatchanged

# Function alias; convert to Nushell function with parameter:
export def git-send [msg: string] {
  git add .
  git commit -m $msg
  git push
}