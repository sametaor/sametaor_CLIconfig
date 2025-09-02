export alias h = history
export def hl [] { history | less }
export def hs [pattern: string] { history | grep $pattern }
export def hsi [pattern: string] { history | grep -i $pattern }
export def hgrep [pattern: string] { fc -El 0 | grep $pattern }
export alias help = man
export alias p = ps -f
export alias sortnr = sort -n -r
export alias unexport = unset

# Pipeline abbreviations best handled as short functions:
export def H [data] { $data | head }
export def T [data] { $data | tail }
export def G [data pattern: string] { $data | grep $pattern }
export def L [data] { $data | less }
export def M [data] { $data | most }
export def LL [data] { $data | less }  # stderr redirect not needed in Nu
export def CA [data] { $data | cat -A }
# For NE and NUL, redirecting output is typically unnecessary in Nu, so skip.
# For P, pygmentize -l pytb (No direct Nushell replacement for rich tracebacks; omit or wrap in bat/less as needed)

export alias ping = prettyping
export alias what = navi --query
export alias nano = nano --modernbindings
export alias sudo = doas
export alias ':q' = exit
export alias sudoedit = doas rnano
export alias vim = nvim
export alias vi = nvim
export alias neo = tmatrix -s 15 --fade -c default -C cyan -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10
export alias matrix = tmatrix -s 15 --fade -c default -f 1,1 -G 0,70 -g 20,60 -l 2,60 -r 5,10
export alias lolcat = lolcat -t

# Bat/cat logic (manual pick of binary, not portable in Nushell presets):
export alias rcat = cat          # use cat for rcat
export alias zip = unzip -l
export alias rar = unrar l
export alias tar = tar tf
export alias 'tar.gz' = echo
