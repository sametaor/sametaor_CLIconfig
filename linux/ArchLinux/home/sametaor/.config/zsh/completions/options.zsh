# nicer menu, group headers in blue
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format $'\n%F{blue}%B%d%b%f\n'
# extra matchers: case-insensitive, hyphen/underscore interchangeable
zstyle ':completion:*' matcher-list \
      'm:{a-zA-Z}={A-Za-z}' 'm:{_-}={-_}'
zstyle ':completion:*' special-dirs true
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' rehash true

