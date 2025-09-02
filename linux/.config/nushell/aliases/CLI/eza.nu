export alias l = eza -lhF
export alias la = eza -lAhF
export alias lr = eza -RhF -L 2
export alias lt = eza -l -h -t created -F
export alias ll = eza -l
export alias ldot = eza -ld .*
export alias lS = eza -1Ss Extension -hF
export alias lart = eza -1artF
export alias lrt = eza -1rtF
export alias lsr = eza -lARhF -l 2
export alias lsn = eza -1

# Use lsm only once, latest version:
export alias lsm = eza -lbhHigUmuSa@ --time-style=long-iso --git --icons=always --colour=always

export alias ls = eza -a -l --icons=always --colour=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o
export alias lst = ls -T -L 2 --no-user
