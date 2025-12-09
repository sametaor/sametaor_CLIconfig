# command-not-found.fish
# Comprehensive cross-platform command-not-found handler for fish shell

# Fish uses function __fish_command_not_found_handler

# Helper function to check if command exists
function __cnf_command_exists
    command -v $argv[1] >/dev/null 2>&1
end

# ============================================================================
# LINUX DISTRIBUTIONS
# ============================================================================

# Arch Linux and derivatives
if test -f /etc/arch-release
    function __fish_command_not_found_handler --on-event fish_command_not_found
        echo "fish: command not found: $argv[1]" >&2
        set -l found 0

        # Priority 1: pkgfile
        if __cnf_command_exists /usr/bin/pkgfile
            echo "[Arch Repositories]" >&2
            if /usr/bin/pkgfile -b -v "$argv[1]" 2>/dev/null
                set found 1
                echo "Install with: sudo pacman -S <package>" >&2
            end
        end

        # Priority 2: AUR helpers
        if test $found -eq 0
            if __cnf_command_exists /usr/bin/yay
                echo "[AUR - yay]" >&2
                if /usr/bin/yay -Ss "^$argv[1]\$" 2>/dev/null | head -n 5
                    set found 1
                    echo "Install with: yay -S <package>" >&2
                end
            else if __cnf_command_exists /usr/bin/paru
                echo "[AUR - paru]" >&2
                if /usr/bin/paru -Ss "^$argv[1]\$" 2>/dev/null | head -n 5
                    set found 1
                    echo "Install with: paru -S <package>" >&2
                end
            end
        end

        # Priority 3: Flatpak
        if test $found -eq 0; and __cnf_command_exists /usr/bin/flatpak
            echo "[Flatpak]" >&2
            if /usr/bin/flatpak search "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/flatpak search "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: flatpak install <app-id>" >&2
            end
        end

        # Priority 4: Homebrew
        if test $found -eq 0; and __cnf_command_exists /home/linuxbrew/.linuxbrew/bin/brew
            echo "[Homebrew]" >&2
            if /home/linuxbrew/.linuxbrew/bin/brew which-formula --explain "$argv[1]" 2>/dev/null
                set found 1
                echo "Install with: brew install <formula>" >&2
            end
        end

        test $found -eq 0; and echo "Not found in any package manager." >&2
    end

    # Debian/Ubuntu and derivatives
else if test -f /etc/debian_version
    function __fish_command_not_found_handler --on-event fish_command_not_found
        set -l found 0

        # Priority 1: Native apt command-not-found
        if __cnf_command_exists /usr/lib/command-not-found
            /usr/lib/command-not-found -- "$argv[1]"
            set found 1
        else if __cnf_command_exists /usr/share/command-not-found/command-not-found
            /usr/share/command-not-found/command-not-found -- "$argv[1]"
            set found 1
        end

        if test $found -eq 0
            echo "fish: command not found: $argv[1]" >&2
        end

        # Priority 2: Snap
        if test $found -eq 0; and __cnf_command_exists /usr/bin/snap
            echo "[Snap Store]" >&2
            if /usr/bin/snap find "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/snap find "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: sudo snap install <package>" >&2
            end
        end

        # Priority 3: Flatpak
        if test $found -eq 0; and __cnf_command_exists /usr/bin/flatpak
            echo "[Flatpak]" >&2
            if /usr/bin/flatpak search "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/flatpak search "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: flatpak install <app-id>" >&2
            end
        end

        # Priority 4: Homebrew
        if test $found -eq 0; and __cnf_command_exists /home/linuxbrew/.linuxbrew/bin/brew
            echo "[Homebrew]" >&2
            if /home/linuxbrew/.linuxbrew/bin/brew which-formula --explain "$argv[1]" 2>/dev/null
                set found 1
                echo "Install with: brew install <formula>" >&2
            end
        end

        test $found -eq 0; and echo "Not found in any package manager." >&2
    end

    # Fedora/RHEL/CentOS
else if test -f /etc/fedora-release; or test -f /etc/redhat-release
    function __fish_command_not_found_handler --on-event fish_command_not_found
        set -l found 0

        # Priority 1: PackageKit
        if __cnf_command_exists /usr/libexec/pk-command-not-found
            if test -S /var/run/dbus/system_bus_socket; and __cnf_command_exists /usr/libexec/packagekitd
                /usr/libexec/pk-command-not-found $argv
                set found 1
            end
        end

        if test $found -eq 0
            echo "fish: command not found: $argv[1]" >&2

            # Priority 2: dnf provides
            if __cnf_command_exists /usr/bin/dnf
                echo "[DNF Repositories]" >&2
                if /usr/bin/dnf provides "*/$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                    /usr/bin/dnf provides "*/$argv[1]" 2>/dev/null | head -n 10
                    set found 1
                    echo "Install with: sudo dnf install <package>" >&2
                end
            end
        end

        # Priority 3: Flatpak
        if test $found -eq 0; and __cnf_command_exists /usr/bin/flatpak
            echo "[Flatpak]" >&2
            if /usr/bin/flatpak search "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/flatpak search "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: flatpak install <app-id>" >&2
            end
        end

        # Priority 4: Homebrew
        if test $found -eq 0; and __cnf_command_exists /home/linuxbrew/.linuxbrew/bin/brew
            echo "[Homebrew]" >&2
            if /home/linuxbrew/.linuxbrew/bin/brew which-formula --explain "$argv[1]" 2>/dev/null
                set found 1
                echo "Install with: brew install <formula>" >&2
            end
        end

        test $found -eq 0; and echo "Not found in any package manager." >&2
    end

    # openSUSE
else if test -f /etc/SUSE-brand; or test -f /etc/SuSE-release
    function __fish_command_not_found_handler --on-event fish_command_not_found
        set -l found 0

        # Priority 1: Native SUSE
        if __cnf_command_exists /usr/bin/command-not-found
            /usr/bin/command-not-found "$argv[1]"
            set found 1
        else
            echo "fish: command not found: $argv[1]" >&2

            # Priority 2: zypper
            if __cnf_command_exists /usr/bin/zypper
                echo "[Zypper Repositories]" >&2
                if /usr/bin/zypper search --provides --match-exact "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                    /usr/bin/zypper search --provides --match-exact "$argv[1]" 2>/dev/null | head -n 10
                    set found 1
                    echo "Install with: sudo zypper install <package>" >&2
                end
            end
        end

        # Priority 3: Flatpak
        if test $found -eq 0; and __cnf_command_exists /usr/bin/flatpak
            echo "[Flatpak]" >&2
            if /usr/bin/flatpak search "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/flatpak search "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: flatpak install <app-id>" >&2
            end
        end

        # Priority 4: Homebrew
        if test $found -eq 0; and __cnf_command_exists /home/linuxbrew/.linuxbrew/bin/brew
            echo "[Homebrew]" >&2
            if /home/linuxbrew/.linuxbrew/bin/brew which-formula --explain "$argv[1]" 2>/dev/null
                set found 1
                echo "Install with: brew install <formula>" >&2
            end
        end

        test $found -eq 0; and echo "Not found in any package manager." >&2
    end

    # NixOS
else if test -f /etc/NIXOS
    function __fish_command_not_found_handler --on-event fish_command_not_found
        set -l found 0

        # Priority 1: Native NixOS
        if __cnf_command_exists /run/current-system/sw/bin/command-not-found
            /run/current-system/sw/bin/command-not-found $argv
            set found 1
        else
            echo "fish: command not found: $argv[1]" >&2

            # Priority 2: nix-locate
            if __cnf_command_exists /run/current-system/sw/bin/nix-locate
                echo "[Nix Packages]" >&2
                if /run/current-system/sw/bin/nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root "/bin/$argv[1]" 2>/dev/null | head -n 10
                    set found 1
                    echo "Install with: nix-env -iA nixpkgs.<package>" >&2
                end
            end
        end

        # Priority 3: Flatpak
        if test $found -eq 0; and __cnf_command_exists /run/current-system/sw/bin/flatpak
            echo "[Flatpak]" >&2
            if /run/current-system/sw/bin/flatpak search "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /run/current-system/sw/bin/flatpak search "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: flatpak install <app-id>" >&2
            end
        end

        test $found -eq 0; and echo "Not found in any package manager." >&2
    end

    # Alpine Linux
else if test -f /etc/alpine-release
    function __fish_command_not_found_handler --on-event fish_command_not_found
        echo "fish: command not found: $argv[1]" >&2
        set -l found 0

        if __cnf_command_exists /sbin/apk
            echo "[Alpine Packages]" >&2
            if /sbin/apk search -e "cmd:$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /sbin/apk search -e "cmd:$argv[1]" 2>/dev/null
                set found 1
                echo "Install with: apk add <package>" >&2
            end
        end

        if test $found -eq 0; and __cnf_command_exists /usr/bin/flatpak
            echo "[Flatpak]" >&2
            if /usr/bin/flatpak search "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/flatpak search "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: flatpak install <app-id>" >&2
            end
        end

        test $found -eq 0; and echo "Not found in any package manager." >&2
    end

    # Void Linux
else if test -f /etc/void-release
    function __fish_command_not_found_handler --on-event fish_command_not_found
        echo "fish: command not found: $argv[1]" >&2
        set -l found 0

        if __cnf_command_exists /usr/bin/xbps-query
            echo "[Void Packages]" >&2
            if /usr/bin/xbps-query -Rs "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/xbps-query -Rs "$argv[1]" 2>/dev/null | head -n 10
                set found 1
                echo "Install with: sudo xbps-install <package>" >&2
            end
        end

        if test $found -eq 0; and __cnf_command_exists /usr/bin/flatpak
            echo "[Flatpak]" >&2
            if /usr/bin/flatpak search "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/flatpak search "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: flatpak install <app-id>" >&2
            end
        end

        test $found -eq 0; and echo "Not found in any package manager." >&2
    end

    # Gentoo
else if test -f /etc/gentoo-release
    function __fish_command_not_found_handler --on-event fish_command_not_found
        echo "fish: command not found: $argv[1]" >&2
        set -l found 0

        if __cnf_command_exists /usr/bin/e-file
            echo "[Gentoo Portage]" >&2
            if /usr/bin/e-file "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/e-file "$argv[1]" 2>/dev/null | head -n 10
                set found 1
                echo "Install with: sudo emerge <package>" >&2
            end
        end

        if test $found -eq 0; and __cnf_command_exists /usr/bin/flatpak
            echo "[Flatpak]" >&2
            if /usr/bin/flatpak search "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/flatpak search "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: flatpak install <app-id>" >&2
            end
        end

        if test $found -eq 0; and __cnf_command_exists /home/linuxbrew/.linuxbrew/bin/brew
            echo "[Homebrew]" >&2
            if /home/linuxbrew/.linuxbrew/bin/brew which-formula --explain "$argv[1]" 2>/dev/null
                set found 1
                echo "Install with: brew install <formula>" >&2
            end
        end

        test $found -eq 0; and echo "Not found in any package manager." >&2
    end

    # ============================================================================
    # TERMUX
    # ============================================================================

else if test -x /data/data/com.termux/files/usr/libexec/termux/command-not-found
    function __fish_command_not_found_handler --on-event fish_command_not_found
        /data/data/com.termux/files/usr/libexec/termux/command-not-found "$argv[1]"
    end

    # ============================================================================
    # macOS
    # ============================================================================

else if string match -q "darwin*" $OSTYPE
    function __fish_command_not_found_handler --on-event fish_command_not_found
        echo "fish: command not found: $argv[1]" >&2
        set -l found 0

        # Priority 1: Homebrew
        if __cnf_command_exists /opt/homebrew/bin/brew
            echo "[Homebrew]" >&2
            if /opt/homebrew/bin/brew which-formula --explain "$argv[1]" 2>/dev/null
                set found 1
                echo "Install with: brew install <formula>" >&2
            end
        else if __cnf_command_exists /usr/local/bin/brew
            echo "[Homebrew]" >&2
            if /usr/local/bin/brew which-formula --explain "$argv[1]" 2>/dev/null
                set found 1
                echo "Install with: brew install <formula>" >&2
            end
        end

        # Priority 2: MacPorts
        if test $found -eq 0; and __cnf_command_exists /opt/local/bin/port
            echo "[MacPorts]" >&2
            if /opt/local/bin/port provides "$argv[1]" 2>/dev/null
                set found 1
                echo "Install with: sudo port install <package>" >&2
            end
        end

        # Priority 3: Nix
        if test $found -eq 0; and __cnf_command_exists /nix/var/nix/profiles/default/bin/nix-locate
            echo "[Nix]" >&2
            if /nix/var/nix/profiles/default/bin/nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root "/bin/$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: nix-env -iA nixpkgs.<package>" >&2
            end
        end

        # Priority 4: Fink
        if test $found -eq 0; and __cnf_command_exists /sw/bin/fink
            echo "[Fink]" >&2
            set -l fink_output (/sw/bin/fink apropos "$argv[1]" 2>/dev/null | head -n 10)
            if test -n "$fink_output"
                echo "$fink_output"
                set found 1
                echo "Install with: fink install <package>" >&2
            end
        end

        test $found -eq 0; and echo "Not found in any macOS package manager." >&2
    end

    # ============================================================================
    # WSL
    # ============================================================================

else if set -q WSL_DISTRO_NAME
    function __fish_command_not_found_handler --on-event fish_command_not_found
        echo "fish: command not found: $argv[1]" >&2
        set -l found 0

        echo "[Windows Commands]" >&2
        if __cnf_command_exists powershell.exe
            set -l win_cmd (powershell.exe -Command "Get-Command $argv[1] -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Source" 2>/dev/null)
            if test -n "$win_cmd"
                echo "Found in Windows: $win_cmd"
                echo "Run with: $argv[1].exe or powershell.exe -c $argv[1]" >&2
                set found 1
            else
                echo "Try Windows package managers:" >&2
                echo "  - winget: winget search $argv[1]" >&2
                echo "  - choco: choco search $argv[1]" >&2
                echo "  - scoop: scoop search $argv[1]" >&2
            end
        end
    end

    # ============================================================================
    # MSYS2
    # ============================================================================

else if string match -q msys $OSTYPE
    function __fish_command_not_found_handler --on-event fish_command_not_found
        echo "fish: command not found: $argv[1]" >&2
        set -l found 0

        if __cnf_command_exists /usr/bin/pacman
            echo "[MSYS2 Packages]" >&2
            if /usr/bin/pacman -Ss "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/pacman -Ss "$argv[1]" 2>/dev/null | head -n 10
                set found 1
                echo "Install with: pacman -S <package>" >&2
            end
        end

        test $found -eq 0; and echo "Not found. Try: pacman -Ss <search-term>" >&2
    end

    # ============================================================================
    # UNIVERSAL FALLBACK
    # ============================================================================

else
    function __fish_command_not_found_handler --on-event fish_command_not_found
        echo "fish: command not found: $argv[1]" >&2
        set -l found 0

        # Try Nix
        if __cnf_command_exists /nix/var/nix/profiles/default/bin/nix-locate
            echo "[Nix]" >&2
            if /nix/var/nix/profiles/default/bin/nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root "/bin/$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: nix-env -iA nixpkgs.<package>" >&2
            end
        end

        # Try Flatpak
        if test $found -eq 0; and __cnf_command_exists /usr/bin/flatpak
            echo "[Flatpak]" >&2
            if /usr/bin/flatpak search "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/flatpak search "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: flatpak install <app-id>" >&2
            end
        end

        # Try Snap
        if test $found -eq 0; and __cnf_command_exists /usr/bin/snap
            echo "[Snap]" >&2
            if /usr/bin/snap find "$argv[1]" 2>/dev/null | grep -q "$argv[1]"
                /usr/bin/snap find "$argv[1]" 2>/dev/null | head -n 5
                set found 1
                echo "Install with: sudo snap install <package>" >&2
            end
        end

        # Try Homebrew
        if test $found -eq 0
            for brew_path in /home/linuxbrew/.linuxbrew/bin/brew /opt/homebrew/bin/brew /usr/local/bin/brew
                if __cnf_command_exists $brew_path
                    echo "[Homebrew]" >&2
                    if $brew_path which-formula --explain "$argv[1]" 2>/dev/null
                        set found 1
                        echo "Install with: brew install <formula>" >&2
                    end
                    break
                end
            end
        end

        test $found -eq 0; and echo "Not found in any available package manager." >&2
    end
end
