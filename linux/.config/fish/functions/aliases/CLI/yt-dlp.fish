# Fish shell aliases for yt-dlp (ported from bash/zsh)
alias ytnpl 'yt-dlp --no-playlist --restrict-filenames'
alias ytp 'ytnpl --write-subs --write-auto-subs --format 244+299'
alias ytpp 'ytnpl --write-subs --write-auto-subs --format 247+299'
alias yts 'ytnpl --write-subs --write-auto-subs --format worstaudio --extract-audio'
alias ytm 'ytnpl --format bestaudio --extract-audio'
