# command-not-found.zsh
# Comprehensive cross-platform command-not-found handler
# Supports: Linux (multiple distros), macOS, Windows (WSL), Termux
# Universal package managers: Homebrew, Flatpak, Snap, Nix, AppImage

# Try to source external handler scripts first
for file (
  # Arch Linux - pkgfile: https://wiki.archlinux.org/index.php/Pkgfile#Command_not_found
  /usr/share/doc/pkgfile/command-not-found.zsh
  # Homebrew: https://github.com/Homebrew/homebrew-command-not-found
  /opt/homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
  /usr/local/Homebrew/Library/Homebrew/command-not-found/handler.sh
  /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
); do
  if [[ -r "$file" ]]; then
    source "$file"
    unset file
    return 0
  fi
done
unset file

# ============================================================================
# LINUX DISTRIBUTIONS - Combined handlers with fallback priorities
# ============================================================================

# Arch Linux and derivatives (Manjaro, EndeavourOS, Garuda, etc.)
if [[ -f /etc/arch-release ]] && ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    printf "zsh: command not found: %s\n" "$1" >&2
    local found=0
    
    # Priority 1: pkgfile (native Arch tool)
    if [[ -x /usr/bin/pkgfile ]]; then
      printf "\n[Arch Repositories]\n" >&2
      if /usr/bin/pkgfile -b -v "$1" 2>/dev/null; then
        found=1
        printf "Install with: sudo pacman -S <package>\n\n" >&2
      fi
    fi
    
    # Priority 2: AUR helpers (yay, paru)
    if [[ $found -eq 0 ]]; then
      if [[ -x /usr/bin/yay ]]; then
        printf "[AUR - yay]\n" >&2
        if /usr/bin/yay -Ss "^$1$" 2>/dev/null | head -n 5; then
          found=1
          printf "Install with: yay -S <package>\n\n" >&2
        fi
      elif [[ -x /usr/bin/paru ]]; then
        printf "[AUR - paru]\n" >&2
        if /usr/bin/paru -Ss "^$1$" 2>/dev/null | head -n 5; then
          found=1
          printf "Install with: paru -S <package>\n\n" >&2
        fi
      fi
    fi
    
    # Priority 3: Flatpak
    if [[ $found -eq 0 && -x /usr/bin/flatpak ]]; then
      printf "[Flatpak]\n" >&2
      if /usr/bin/flatpak search "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/flatpak search "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: flatpak install <app-id>\n\n" >&2
      fi
    fi
    
    # Priority 4: Homebrew/Linuxbrew
    if [[ $found -eq 0 && -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
      printf "[Homebrew]\n" >&2
      if /home/linuxbrew/.linuxbrew/bin/brew which-formula --explain "$1" 2>/dev/null; then
        found=1
        printf "Install with: brew install <formula>\n\n" >&2
      fi
    fi
    
    [[ $found -eq 0 ]] && printf "Not found in any package manager.\n" >&2
    return 127
  }
fi

# Debian/Ubuntu and derivatives (Mint, Pop!_OS, elementary, etc.)
if [[ -f /etc/debian_version ]] && ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    local found=0
    
    # Priority 1: Native apt command-not-found
    if [[ -x /usr/lib/command-not-found ]]; then
      /usr/lib/command-not-found -- "$1"
      found=1
    elif [[ -x /usr/share/command-not-found/command-not-found ]]; then
      /usr/share/command-not-found/command-not-found -- "$1"
      found=1
    fi
    
    if [[ $found -eq 0 ]]; then
      printf "zsh: command not found: %s\n" "$1" >&2
    fi
    
    # Priority 2: Snap (common on Ubuntu)
    if [[ $found -eq 0 && -x /usr/bin/snap ]]; then
      printf "\n[Snap Store]\n" >&2
      if /usr/bin/snap find "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/snap find "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: sudo snap install <package>\n\n" >&2
      fi
    fi
    
    # Priority 3: Flatpak
    if [[ $found -eq 0 && -x /usr/bin/flatpak ]]; then
      printf "[Flatpak]\n" >&2
      if /usr/bin/flatpak search "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/flatpak search "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: flatpak install <app-id>\n\n" >&2
      fi
    fi
    
    # Priority 4: Homebrew/Linuxbrew
    if [[ $found -eq 0 && -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
      printf "[Homebrew]\n" >&2
      if /home/linuxbrew/.linuxbrew/bin/brew which-formula --explain "$1" 2>/dev/null; then
        found=1
        printf "Install with: brew install <formula>\n\n" >&2
      fi
    fi
    
    [[ $found -eq 0 ]] && printf "Not found in any package manager.\n" >&2
    return 127
  }
fi

# Fedora/RHEL/CentOS and derivatives (Rocky, Alma, etc.)
if [[ -f /etc/fedora-release || -f /etc/redhat-release ]] && ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    local found=0
    
    # Priority 1: PackageKit (native Fedora tool)
    if [[ -x /usr/libexec/pk-command-not-found ]]; then
      if [[ -S /var/run/dbus/system_bus_socket && -x /usr/libexec/packagekitd ]]; then
        /usr/libexec/pk-command-not-found "$@"
        found=1
      fi
    fi
    
    if [[ $found -eq 0 ]]; then
      printf "zsh: command not found: %s\n" "$1" >&2
      
      # Priority 2: dnf provides (manual search)
      if [[ -x /usr/bin/dnf ]]; then
        printf "\n[DNF Repositories]\n" >&2
        if /usr/bin/dnf provides "*/$1" 2>/dev/null | grep -q "$1"; then
          /usr/bin/dnf provides "*/$1" 2>/dev/null | head -n 10
          found=1
          printf "Install with: sudo dnf install <package>\n\n" >&2
        fi
      fi
    fi
    
    # Priority 3: Flatpak
    if [[ $found -eq 0 && -x /usr/bin/flatpak ]]; then
      printf "[Flatpak]\n" >&2
      if /usr/bin/flatpak search "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/flatpak search "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: flatpak install <app-id>\n\n" >&2
      fi
    fi
    
    # Priority 4: Homebrew/Linuxbrew
    if [[ $found -eq 0 && -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
      printf "[Homebrew]\n" >&2
      if /home/linuxbrew/.linuxbrew/bin/brew which-formula --explain "$1" 2>/dev/null; then
        found=1
        printf "Install with: brew install <formula>\n\n" >&2
      fi
    fi
    
    [[ $found -eq 0 ]] && printf "Not found in any package manager.\n" >&2
    return 127
  }
fi

# openSUSE and derivatives (Leap, Tumbleweed, MicroOS)
if [[ -f /etc/SUSE-brand || -f /etc/SuSE-release ]] && ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    local found=0
    
    # Priority 1: Native SUSE command-not-found
    if [[ -x /usr/bin/command-not-found ]]; then
      /usr/bin/command-not-found "$1"
      found=1
    else
      printf "zsh: command not found: %s\n" "$1" >&2
      
      # Priority 2: zypper search
      if [[ -x /usr/bin/zypper ]]; then
        printf "\n[Zypper Repositories]\n" >&2
        if /usr/bin/zypper search --provides --match-exact "$1" 2>/dev/null | grep -q "$1"; then
          /usr/bin/zypper search --provides --match-exact "$1" 2>/dev/null | head -n 10
          found=1
          printf "Install with: sudo zypper install <package>\n\n" >&2
        fi
      fi
    fi
    
    # Priority 3: Flatpak
    if [[ $found -eq 0 && -x /usr/bin/flatpak ]]; then
      printf "[Flatpak]\n" >&2
      if /usr/bin/flatpak search "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/flatpak search "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: flatpak install <app-id>\n\n" >&2
      fi
    fi
    
    # Priority 4: Homebrew/Linuxbrew
    if [[ $found -eq 0 && -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
      printf "[Homebrew]\n" >&2
      if /home/linuxbrew/.linuxbrew/bin/brew which-formula --explain "$1" 2>/dev/null; then
        found=1
        printf "Install with: brew install <formula>\n\n" >&2
      fi
    fi
    
    [[ $found -eq 0 ]] && printf "Not found in any package manager.\n" >&2
    return 127
  }
fi

# NixOS: https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/programs/command-not-found
if [[ -f /etc/NIXOS ]] && ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    local found=0
    
    # Priority 1: NixOS native command-not-found
    if [[ -x /run/current-system/sw/bin/command-not-found ]]; then
      /run/current-system/sw/bin/command-not-found "$@"
      found=1
    else
      printf "zsh: command not found: %s\n" "$1" >&2
      
      # Priority 2: nix-locate (from nix-index)
      if [[ -x /run/current-system/sw/bin/nix-locate ]]; then
        printf "\n[Nix Packages]\n" >&2
        if /run/current-system/sw/bin/nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root "/bin/$1" 2>/dev/null | head -n 10; then
          found=1
          printf "Install with: nix-env -iA nixpkgs.<package>\n\n" >&2
        fi
      fi
    fi
    
    # Priority 3: Flatpak
    if [[ $found -eq 0 && -x /run/current-system/sw/bin/flatpak ]]; then
      printf "[Flatpak]\n" >&2
      if /run/current-system/sw/bin/flatpak search "$1" 2>/dev/null | grep -q "$1"; then
        /run/current-system/sw/bin/flatpak search "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: flatpak install <app-id>\n\n" >&2
      fi
    fi
    
    [[ $found -eq 0 ]] && printf "Not found in any package manager.\n" >&2
    return 127
  }
fi

# Gentoo and derivatives (Funtoo, Calculate Linux)
if [[ -f /etc/gentoo-release ]] && ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    printf "zsh: command not found: %s\n" "$1" >&2
    local found=0
    
    # Priority 1: e-file (from app-portage/pfl)
    if [[ -x /usr/bin/e-file ]]; then
      printf "\n[Gentoo Portage]\n" >&2
      if /usr/bin/e-file "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/e-file "$1" 2>/dev/null | head -n 10
        found=1
        printf "Install with: sudo emerge <package>\n\n" >&2
      fi
    fi
    
    # Priority 2: Flatpak
    if [[ $found -eq 0 && -x /usr/bin/flatpak ]]; then
      printf "[Flatpak]\n" >&2
      if /usr/bin/flatpak search "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/flatpak search "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: flatpak install <app-id>\n\n" >&2
      fi
    fi
    
    # Priority 3: Homebrew/Linuxbrew
    if [[ $found -eq 0 && -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
      printf "[Homebrew]\n" >&2
      if /home/linuxbrew/.linuxbrew/bin/brew which-formula --explain "$1" 2>/dev/null; then
        found=1
        printf "Install with: brew install <formula>\n\n" >&2
      fi
    fi
    
    [[ $found -eq 0 ]] && printf "Not found in any package manager.\n" >&2
    return 127
  }
fi

# Alpine Linux
if [[ -f /etc/alpine-release ]] && ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    printf "zsh: command not found: %s\n" "$1" >&2
    local found=0
    
    # Priority 1: apk search
    if [[ -x /sbin/apk ]]; then
      printf "\n[Alpine Packages]\n" >&2
      if /sbin/apk search -e "cmd:$1" 2>/dev/null | grep -q "$1"; then
        /sbin/apk search -e "cmd:$1" 2>/dev/null
        found=1
        printf "Install with: apk add <package>\n\n" >&2
      fi
    fi
    
    # Priority 2: Flatpak
    if [[ $found -eq 0 && -x /usr/bin/flatpak ]]; then
      printf "[Flatpak]\n" >&2
      if /usr/bin/flatpak search "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/flatpak search "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: flatpak install <app-id>\n\n" >&2
      fi
    fi
    
    [[ $found -eq 0 ]] && printf "Not found in any package manager.\n" >&2
    return 127
  }
fi

# Void Linux
if [[ -f /etc/void-release ]] && ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    printf "zsh: command not found: %s\n" "$1" >&2
    local found=0
    
    # Priority 1: xbps-query
    if [[ -x /usr/bin/xbps-query ]]; then
      printf "\n[Void Packages]\n" >&2
      if /usr/bin/xbps-query -Rs "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/xbps-query -Rs "$1" 2>/dev/null | head -n 10
        found=1
        printf "Install with: sudo xbps-install <package>\n\n" >&2
      fi
    fi
    
    # Priority 2: Flatpak
    if [[ $found -eq 0 && -x /usr/bin/flatpak ]]; then
      printf "[Flatpak]\n" >&2
      if /usr/bin/flatpak search "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/flatpak search "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: flatpak install <app-id>\n\n" >&2
      fi
    fi
    
    [[ $found -eq 0 ]] && printf "Not found in any package manager.\n" >&2
    return 127
  }
fi

# ============================================================================
# TERMUX (Android)
# ============================================================================

if [[ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found ]]; then
  command_not_found_handler() {
    /data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
  }
fi

# ============================================================================
# macOS: Combined handler for all package managers
# ============================================================================

if [[ "$OSTYPE" == darwin* ]] && ! typeset -f command_not_found_handle > /dev/null; then
  command_not_found_handler() {
    printf "zsh: command not found: %s\n" "$1" >&2
    local found=0
    
    # Priority 1: Homebrew (most common on macOS)
    if [[ -x /opt/homebrew/bin/brew ]]; then
      printf "\n[Homebrew]\n" >&2
      if /opt/homebrew/bin/brew which-formula --explain "$1" 2>/dev/null; then
        found=1
        printf "Install with: brew install <formula>\n\n" >&2
      fi
    elif [[ -x /usr/local/bin/brew ]]; then
      printf "\n[Homebrew]\n" >&2
      if /usr/local/bin/brew which-formula --explain "$1" 2>/dev/null; then
        found=1
        printf "Install with: brew install <formula>\n\n" >&2
      fi
    fi
    
    # Priority 2: MacPorts
    if [[ $found -eq 0 && -x /opt/local/bin/port ]]; then
      printf "[MacPorts]\n" >&2
      if /opt/local/bin/port provides "$1" 2>/dev/null; then
        found=1
        printf "Install with: sudo port install <package>\n\n" >&2
      fi
    fi
    
    # Priority 3: Nix (macOS support)
    if [[ $found -eq 0 && -x /nix/var/nix/profiles/default/bin/nix-locate ]]; then
      printf "[Nix]\n" >&2
      if /nix/var/nix/profiles/default/bin/nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root "/bin/$1" 2>/dev/null | head -n 5; then
        found=1
        printf "Install with: nix-env -iA nixpkgs.<package>\n\n" >&2
      fi
    fi
    
    # Priority 4: Fink
    if [[ $found -eq 0 && -x /sw/bin/fink ]]; then
      printf "[Fink]\n" >&2
      local fink_output=$(/sw/bin/fink apropos "$1" 2>/dev/null | head -n 10)
      if [[ -n "$fink_output" ]]; then
        printf "%s\n" "$fink_output"
        found=1
        printf "Install with: fink install <package>\n\n" >&2
      fi
    fi
    
    [[ $found -eq 0 ]] && printf "Not found in any macOS package manager.\n" >&2
    return 127
  }
fi

# ============================================================================
# WINDOWS (WSL/Cygwin/MSYS2/Git Bash)
# ============================================================================

# WSL (Windows Subsystem for Linux)
if [[ -n "$WSL_DISTRO_NAME" ]] && ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    printf "zsh: command not found: %s\n" "$1" >&2
    local found=0
    
    # Check if this might be a Windows executable
    printf "\n[Windows Commands]\n" >&2
    if command -v powershell.exe >/dev/null 2>&1; then
      # Try to find in Windows PATH
      local win_cmd=$(powershell.exe -Command "Get-Command $1 -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source" 2>/dev/null)
      if [[ -n "$win_cmd" ]]; then
        printf "Found in Windows: %s\n" "$win_cmd"
        printf "Run with: $1.exe or powershell.exe -c $1\n\n" >&2
        found=1
      else
        # Suggest Windows package managers
        printf "Try searching in:\n" >&2
        printf "  - winget: winget search $1\n" >&2
        printf "  - choco: choco search $1\n" >&2
        printf "  - scoop: scoop search $1\n\n" >&2
      fi
    fi
    
    # Fall back to Linux package managers (WSL inherits Linux distro)
    # The distribution-specific handlers above will handle this
    
    return 127
  }
fi

# MSYS2 (Windows)
if [[ "$OSTYPE" == "msys" ]] && ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    printf "zsh: command not found: %s\n" "$1" >&2
    local found=0
    
    # Priority 1: pacman (MSYS2 uses pacman)
    if [[ -x /usr/bin/pacman ]]; then
      printf "\n[MSYS2 Packages]\n" >&2
      if /usr/bin/pacman -Ss "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/pacman -Ss "$1" 2>/dev/null | head -n 10
        found=1
        printf "Install with: pacman -S <package>\n\n" >&2
      fi
    fi
    
    [[ $found -eq 0 ]] && printf "Not found. Try: pacman -Ss <search-term>\n" >&2
    return 127
  }
fi

# ============================================================================
# UNIVERSAL PACKAGE MANAGERS (fallback for any system)
# ============================================================================

# Only define universal fallback if no other handler was defined
if ! typeset -f command_not_found_handler > /dev/null; then
  command_not_found_handler() {
    printf "zsh: command not found: %s\n" "$1" >&2
    local found=0
    
    # Try Nix (cross-platform)
    if [[ -x /nix/var/nix/profiles/default/bin/nix-locate ]]; then
      printf "\n[Nix]\n" >&2
      if /nix/var/nix/profiles/default/bin/nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root "/bin/$1" 2>/dev/null | head -n 5; then
        found=1
        printf "Install with: nix-env -iA nixpkgs.<package>\n\n" >&2
      fi
    fi
    
    # Try Flatpak (Linux)
    if [[ $found -eq 0 && -x /usr/bin/flatpak ]]; then
      printf "[Flatpak]\n" >&2
      if /usr/bin/flatpak search "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/flatpak search "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: flatpak install <app-id>\n\n" >&2
      fi
    fi
    
    # Try Snap (Linux)
    if [[ $found -eq 0 && -x /usr/bin/snap ]]; then
      printf "[Snap]\n" >&2
      if /usr/bin/snap find "$1" 2>/dev/null | grep -q "$1"; then
        /usr/bin/snap find "$1" 2>/dev/null | head -n 5
        found=1
        printf "Install with: sudo snap install <package>\n\n" >&2
      fi
    fi
    
    # Try Homebrew/Linuxbrew (cross-platform)
    if [[ $found -eq 0 ]]; then
      for brew_path in /home/linuxbrew/.linuxbrew/bin/brew /opt/homebrew/bin/brew /usr/local/bin/brew; do
        if [[ -x "$brew_path" ]]; then
          printf "[Homebrew]\n" >&2
          if "$brew_path" which-formula --explain "$1" 2>/dev/null; then
            found=1
            printf "Install with: brew install <formula>\n\n" >&2
          fi
          break
        fi
      done
    fi
    
    [[ $found -eq 0 ]] && printf "Not found in any available package manager.\n" >&2
    return 127
  }
fi

