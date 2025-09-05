export alias h = history
export def hl [] { history | less }
export def hs [pattern: string] { history | grep $pattern }
export def hsi [pattern: string] { history | grep -i $pattern }
export def hgrep [pattern: string] { fc -El 0 | grep $pattern }
export alias help = man
#export alias p = ^ps -eo user,pid,ppid,c,stime,tty,time,comm
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
def zipnew [archive_name: string, ...files: string] {
  ^zip -r $archive_name $files
}

def zipadd [archive_name: string, ...files: string] {
  ^zip -ur $archive_name $files
}

def zipls [archive_name: string] {
  unzip -l $archive_name
}

def zipfix [
  archive_name: string,
  --out: string = "fixed.zip" # The output file name
] {
  ^zip -F $archive_name --out $out
}

def unzip_to [
  archive_name: string,
  destination: path = "." # The destination path
] {
  unzip $archive_name -d $destination
}

def zipdel [archive_name: string, ...files_to_remove: string] {
  ^zip -d $archive_name $files_to_remove
}

def unzipt [archive_name: string] {
  unzip -t $archive_name
}

def zipenc [archive_name: string, ...files: string] {
  ^zip -er $archive_name $files
}

# "Smart" extract function that detects compression from file extension.
# Usage: untar archive.tar.gz
def "untar" [archive_name: string] {
    if ($archive_name | str ends-with ".tar.gz" or ($archive_name | str ends-with ".tgz")) {
        tar -xzvf $archive_name
    } else if ($archive_name | str ends-with ".tar.bz2" or ($archive_name | str ends-with ".tbz2")) {
        tar -xjvf $archive_name
    } else if ($archive_name | str ends-with ".tar.xz" or ($archive_name | str ends-with ".txz")) {
        tar -xJvf $archive_name
    } else if ($archive_name | str ends-with ".tar") {
        tar -xvf $archive_name
    } else {
        error make {msg: "Unsupported file type"}
    }
}

# Creates a gzipped tar archive (.tar.gz)
# Usage: tar create archive.tar.gz file1 folder/
def "tar create" [archive_name: string, ...files: string] {
  tar -czvf $archive_name $files
}

# Lists the contents of any tar archive.
# Usage: tar ls archive.tar.gz
def "tar ls" [archive_name: string] {
  tar -tvf $archive_name
}
