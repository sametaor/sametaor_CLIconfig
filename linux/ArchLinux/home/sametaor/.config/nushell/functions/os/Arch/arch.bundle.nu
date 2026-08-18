
# pacman.nu - Fixed parsing

## Main upgrade function with keyring check
export def --env upgrade [] {
  print ":: Syncing package databases..."
  sudo pacman -Sy
  
  print ":: Checking Arch Linux PGP Keyring..."
  
  # Get installed version
  let installed_info = (^sudo pacman -Qi archlinux-keyring | complete).stdout
  let installed_ver = (
    $installed_info
    | lines
    | where $in =~ "^Version         :"
    | split column " : " version
    | get version.0?
    | first?
  )
  
  # Get current version  
  let current_info = (^sudo pacman -Si archlinux-keyring | complete).stdout
  let current_ver = (
    $current_info
    | lines
    | where $in =~ "^Version         :"
    | split column " : " version
    | get version.0?
    | first?
  )
  
  if $installed_ver != $current_ver {
    print " Arch Linux PGP Keyring is out of date."
    print " Updating before full system upgrade."
    sudo pacman -S --needed --noconfirm archlinux-keyring
  } else {
    print " Arch Linux PGP Keyring is up to date."
    print " Proceeding with full system upgrade."
  }
  
  # AUR helper or pacman
  if (which yay | is-not-empty) {
    yay -Su
  } else if (which trizen | is-not-empty) {
    trizen -Su
  } else if (which pacaur | is-not-empty) {
    pacaur -Su
  } else if (which aura | is-not-empty) {
    sudo aura -Su
  } else {
    sudo pacman -Su
  }
}

## Fixed pacweb function
export def pacweb [
    pkg: string  # Package name
    --help(-h)
  ] {
    if $help {
      print "pacweb - open the website of an ArchLinux package"
      print "Usage: pacweb <package_name>"
      return 1
    }
    
    let pkg_info = (^sudo pacman -Si $pkg | complete).stdout
    
    if ($pkg_info | str length) == 0 {
      return
    }
    
    let repo_line = ($pkg_info | lines | where $in =~ "^Repo" | first?)
    let repo = if $repo_line != null {
      $repo_line | split column " : " repo | get repo.1 | first?
    } else { "extra" }
    
    let arch_line = ($pkg_info | lines | where $in =~ "^Arch" | first?)
    let arch = if $arch_line != null {
      $arch_line | split column " : " arch | get arch.1 | first?
    } else { "x86_64" }
    
    ^xdg-open $"https://www.archlinux.org/packages/($repo)/($arch)/($pkg)/"
}

## Simplified paclist
export def paclist [] {
  pacman -Qqe 
  | lines
  | where ($in | str trim | len) > 0
  | split column " " pkg
  | get pkg.0
  | each {|pkg| ^pacman -Qs $"^($pkg)$" --color=auto }
}

## Simplified pacdisowned  
export def pacdisowned [] {
  let tmp_dir = (mktemp -d | str trim)
  let db_file = $"/($tmp_dir)/db"
  let fs_file = $"/($tmp_dir)/fs"
  
  try {
    pacman -Qlq | sort | uniq o> $db_file
    ^find /etc /usr ! -name "lost+found" -type d -printf '%p/\n' -o -print
    | sort o> $fs_file
    
    ^comm -23 $fs_file $db_file
  } catch {
    print "Error generating disowned file list"
  }
  rm -rf $tmp_dir
}

## Key signing function
export def pacmansignkeys [...keys: string] {
  for key in $keys {
    sudo pacman-key --recv-keys $key
    sudo pacman-key --lsign-key $key
    
    # Trust the key (simplified)
    print $"trust\n3\nquit"
    | sudo gpg --homedir /etc/pacman.d/gnupg --no-permission-warning --command-fd 0 --edit-key $key
  }
}
