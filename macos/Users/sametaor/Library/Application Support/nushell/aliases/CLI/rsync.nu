export alias rsync-copy = rsync -avz --progress -h
export alias rsync-move = rsync -avz --progress -h --remove-source-files
export alias rsync-update = rsync -avzu --progress -h
export alias rsync-synchronize = rsync -avzu --delete --progress -h
