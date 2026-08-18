
# apt.nu - Debian/Ubuntu APT utilities

## Prints apt history (Debian/Ubuntu)
export def apt-history [
  action?: string  # install, upgrade, remove, rollback, list
  pkg1?: string
  pkg2?: string
] {
  let log_files = (^ls -rt /var/log/dpkg* | get name)
  
  switch $action {
    "install" => {
      ^zgrep --no-filename "install " $log_files
    }
    "upgrade" | "remove" => {
      ^zgrep --no-filename $action $log_files
    }
    "rollback" => {
      if ($pkg1 | is-empty) or ($pkg2 | is-empty) {
        print "Usage: apt-history rollback <pkg1> <pkg2>"
        return 1
      }
      ^zgrep --no-filename "upgrade " $log_files
      | ^grep $pkg1 -A 10000000
      | ^grep $pkg2 -B 10000000
      | ^awk '{print $4"=" $5}'
    }
    "list" => {
      ^zgrep --no-filename "" $log_files
    }
    _ => {
      print "APT History Commands:"
      print "  apt-history install    - List installed packages"
      print "  apt-history upgrade    - List upgraded packages"  
      print "  apt-history remove     - List removed packages"
      print "  apt-history rollback <pkg1> <pkg2> - Rollback info"
      print "  apt-history list       - List all dpkg logs"
      return 1
    }
  }
}

## List packages by size
export def apt-list-packages [] {
  ^dpkg-query -W --showformat '${Installed-Size} ${Package} ${Status}\n'
  | lines
  | where $in !~ "deinstall"
  | split column " " size pkg status
  | select size pkg
  | sort-by size --reverse
}

## Simplified kerndeb (kernel deb package builder)
export def kerndeb [] {
  print "Kernel package builder (requires make-kpkg setup)"
  print "Note: MAKEFLAGS -jX temporarily unset for kernel build"
  
  # Clear parallel jobs from MAKEFLAGS
  mut makeflags = $env.MAKEFLAGS?
  if ($makeflags | is-not-empty) {
    $makeflags = ($makeflags | str replace --regex --all '(-j\s*[\d]+)' "")
    print $"MAKEFLAGS set to: '($makeflags)'"
  }
  
  let appendage = "-custom"
  let revision = (date now | format date "%Y%m%d")
  
  print $"Building kernel with appendage: ($appendage), revision: ($revision)"
  
  # Run kernel build commands
  ^make-kpkg clean
  
  ^time ^fakeroot ^make-kpkg --append-to-version $appendage --revision $revision kernel_image kernel_headers
}
