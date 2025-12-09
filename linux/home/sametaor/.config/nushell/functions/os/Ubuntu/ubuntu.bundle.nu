
## Add repository and install package (interactive)
export def aar [
  ppa: string              # PPA repository (e.g., ppa:something/repo)
  package?: string         # Package name (optional, prompts if not provided)
] {
  # Determine package name
  let pkg = if ($package | is-not-empty) {
    $package
  } else {
    # Extract default package name from PPA
    let default_pkg = ($ppa | split row "/" | last)
    
    let user_input = (input $"Type in the package name to install/upgrade with this ppa [($default_pkg)]: ")
    
    if ($user_input | str trim | is-empty) {
      $default_pkg
    } else {
      $user_input
    }
  }
  
  # Determine apt command
  let apt_cmd = if ($env.APT? | is-not-empty) {
    $env.APT
  } else {
    "apt"
  }
  
  print $"Adding repository: ($ppa)"
  sudo apt-add-repository $ppa
  
  print "Updating package lists..."
  sudo $apt_cmd update
  
  print $"Installing package: ($pkg)"
  sudo $apt_cmd install $pkg
}

## APT History viewer
export def apt-history [
  action?: string  # install, upgrade, remove, rollback, list
  pkg1?: string    # First package (for rollback)
  pkg2?: string    # Second package (for rollback)
] {
  # Get dpkg log files
  let log_files = try {
    ^ls -rt /var/log/dpkg* | lines
  } catch {
    print "Error: No dpkg log files found"
    return 1
  }
  
  match $action {
    "install" => {
      ^zgrep --no-filename "install " ...$log_files
    }
    "upgrade" => {
      ^zgrep --no-filename "upgrade " ...$log_files
    }
    "remove" => {
      ^zgrep --no-filename "remove " ...$log_files
    }
    "rollback" => {
      if ($pkg1 | is-empty) or ($pkg2 | is-empty) {
        print "Error: rollback requires two package names"
        print "Usage: apt-history rollback <package1> <package2>"
        return 1
      }
      ^zgrep --no-filename "upgrade " ...$log_files
      | ^grep $pkg1 -A 10000000
      | ^grep $pkg2 -B 10000000
      | ^awk '{print $4"="$5}'
    }
    "list" => {
      ^zgrep --no-filename "" ...$log_files
    }
    null | "" => {
      print "APT History - Parameters:"
      print "  install              Lists all packages that have been installed"
      print "  upgrade              Lists all packages that have been upgraded"
      print "  remove               Lists all packages that have been removed"
      print "  rollback <p1> <p2>   Lists rollback information between two packages"
      print "  list                 Lists all contents of dpkg logs"
      return 1
    }
    _ => {
      print $"Unknown action: ($action)"
      apt-history
      return 1
    }
  }
}

## Kernel debian package builder
export def kerndeb [] {
  # Check if make-kpkg exists
  if (which make-kpkg | is-empty) {
    print "Error: make-kpkg not found. Install kernel-package."
    return 1
  }
  
  # Temporarily unset parallel jobs from MAKEFLAGS
  mut makeflags = $env.MAKEFLAGS?
  if ($makeflags | is-not-empty) {
    $makeflags = ($makeflags | str replace --regex --all '-j\s*\d+' "")
    print $"MAKEFLAGS set to '($makeflags)'"
  } else {
    $makeflags = ""
    print "MAKEFLAGS set to ''"
  }
  
  let appendage = "-custom"  # Shows up in uname -r
  let revision = (date now | format date "%Y%m%d")  # Shows up in .deb filename
  
  print $"Building kernel with:"
  print $"  Appendage: ($appendage)"
  print $"  Revision: ($revision)"
  
  # Clean previous builds
  print "Cleaning previous builds..."
  ^make-kpkg clean
  
  # Build kernel packages
  print "Building kernel packages (this will take a while)..."
  with-env {MAKEFLAGS: $makeflags} {
    ^time ^fakeroot ^make-kpkg --append-to-version $appendage --revision $revision kernel_image kernel_headers
  }
}

## List packages by installed size
export def apt-list-packages [
  --top(-t): int = 50      # Show top N packages
  --human(-h)              # Human-readable sizes
] {
  let packages = (
    ^dpkg-query -W --showformat '${Installed-Size} ${Package} ${Status}\n'
    | lines
    | where ($in | str trim | len) > 0
    | where $in !~ "deinstall"
    | split column " " size pkg status
    | select size pkg
    | update size { |row| $row.size | into int }
    | sort-by size --reverse
    | first $top
  )
  
  if $human {
    $packages | update size { |row|
      let size_kb = $row.size
      if $size_kb > 1048576 {
        let gb = ($size_kb / 1048576 | math round --precision 2)
        $"($gb)GB"
      } else if $size_kb > 1024 {
        let mb = ($size_kb / 1024 | math round --precision 1)
        $"($mb)MB"
      } else {
        $"($size_kb)KB"
      }
    }
  } else {
    $packages
  }
}
