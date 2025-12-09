# Fish shell aliases for rsync (ported from bash/zsh)
abbr -a rsync-copy 'rsync -avz --progress -h'
abbr -a rsync-move 'rsync -avz --progress -h --remove-source-files'
abbr -a rsync-update 'rsync -avzu --progress -h'
abbr -a rsync-synchronize 'rsync -avzu --delete --progress -h'
