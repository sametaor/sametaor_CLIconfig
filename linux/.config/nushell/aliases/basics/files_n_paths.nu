export alias cd = z
export alias c = clear
export alias rm = rm -ir
export alias rmf = rm -irf
export alias cp = cp -irv
#export alias mkd = ^mkdir -ip

# mkz is a function for taking an argument:
export def mkz [dir: string] {
  mkdir $dir
  cd $dir
}

export alias zshrc = nvim ~/.zshrc
export alias dud = du -d 1 -h
#export alias duh = ^du -sh
export alias t = tail -f

# path alias requires string manipulation:
export def path [] {
  $env.PATH | split row ":" | each {|p| echo $p }
}
