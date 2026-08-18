
# command-not-found.nu

def file-executable [path: string] {
  ($path | path exists) and (
    try {
      (ls -l $path | get 0.mode? | default "" | str contains "x")
    } catch {
      false
    }
  )
}

# Main handler - prints output and returns empty string
export def command_not_found_handler [command: string] {
  print $"(ansi red_bold)Command not found:(ansi reset) ($command)"
  mut found = false
  
  # Arch Linux
  if ("/etc/arch-release" | path exists) and (file-executable "/usr/bin/pkgfile") {
    print "[Arch Repositories]"
    let result = (do -i { ^pkgfile -b -v $command } | complete)
    if $result.exit_code == 0 and ($result.stdout | str length) > 0 {
      print $result.stdout
      print "Install with: sudo pacman -S <package>"
      $found = true
    }
  }
  
  # macOS Homebrew
  if not $found and ($nu.os-info.name == "macos") {
    let brew_paths = ["/opt/homebrew/bin/brew", "/usr/local/bin/brew"]
    for brew_path in $brew_paths {
      if (file-executable $brew_path) {
        print "[Homebrew]"
        let result = (do -i { ^$brew_path which-formula --explain $command } | complete)
        if $result.exit_code == 0 {
          print $result.stdout
          print "Install with: brew install <formula>"
          $found = true
          break
        }
      }
    }
  }
  
  # Linux Homebrew
  if not $found and (file-executable "/home/linuxbrew/.linuxbrew/bin/brew") {
    print "[Homebrew]"
    let result = (do -i { ^/home/linuxbrew/.linuxbrew/bin/brew which-formula --explain $command } | complete)
    if $result.exit_code == 0 {
      print $result.stdout
      print "Install with: brew install <formula>"
      $found = true
    }
  }
  
  # Flatpak universal
  if not $found and (file-executable "/usr/bin/flatpak") {
    print "[Flatpak]"
    let result = (do -i { ^flatpak search $command } | complete)
    if $result.exit_code == 0 and ($result.stdout | str length) > 0 {
      print ($result.stdout | lines | first 5 | str join "")
      print "Install with: flatpak install <app-id>"
      $found = true
    }
  }
  
  # Snap universal
  if not $found and (file-executable "/usr/bin/snap") {
    print "[Snap]"
    let result = (do -i { ^snap find $command } | complete)
    if $result.exit_code == 0 and ($result.stdout | str length) > 0 {
      print ($result.stdout | lines | first 5 | str join "")
      print "Install with: sudo snap install <package>"
      $found = true
    }
  }
  
  if not $found {
    print "Not found in any available package manager."
  }
}
