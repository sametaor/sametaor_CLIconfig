 # zoxide-ephemeral.nu (working version)

def enter-alt-screen [] {
  print -n "\e[?1049h"
  print -n "\e[?25l"
}

def exit-alt-screen [] {
  print -n "\e[?25h"
  print -n "\e[?1049l"
}

export def --env z [...args: string] {
  if ($args | is-empty) {
    cd $nu.home-path
    z-list-dir
    return
  }
  
  let target = ($args | first)
  
  if ($target | str starts-with "/") or ($target | str starts-with "~") or ($target | str starts-with ".") {
    try {
      cd ($target | path expand)
      z-list-dir
    } catch {
      print -e $"Error: Cannot change to directory '($target)'"
    }
    return
  }
  
  let result = (do -i { ^zoxide query ...$args } | complete)
  
  if $result.exit_code == 0 and ($result.stdout | str trim | is-not-empty) {
    cd ($result.stdout | str trim)
    z-list-dir
  } else {
    try {
      cd $target
      z-list-dir
    } catch {
      print -e $"Error: zoxide could not find '($target)'"
    }
  }
}

def z-list-dir [] {
  # Enter alternate screen
  ^tput smcup
  ^tput civis
  
  # Show the listing
  if (which eza | is-not-empty) {
    ^eza -a -l --icons=always --colour=always --hyperlink -F always --color-scale-mode=gradient --git --git-repos -o -G
  } else {
    ls
  }
  
  # Prompt and wait for user input using bash
  print "\n\e"
  input listen --types [key]
 }
