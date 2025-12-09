# Fish shell aliases for yt-dlp (ported from bash/zsh)
abbr -a ytnpl 'yt-dlp --no-playlist --restrict-filenames'
abbr -a ytp 'ytnpl --write-subs --write-auto-subs --format 244+299'
abbr -a ytpp 'ytnpl --write-subs --write-auto-subs --format 247+299'
abbr -a yts 'ytnpl --write-subs --write-auto-subs --format worstaudio --extract-audio'
abbr -a ytm 'ytnpl --format bestaudio --extract-audio'
