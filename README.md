# sametaor_CLIconfig
(The content below has been written by perplexity's assistant, future rectification and further commits will follow. Stay tuned!)

This repository serves as a unified, version-controlled collection of **dotfiles and environment configuration scripts** for a variety of operating systems and platforms. Its primary goal is to **streamline the process of setting up a personalized, consistent, and productivity-focused user shell/CLI experience** across:

- **Linux**
- **Windows**
- (*Future support*) **macOS**
- (*Planned*) **Android**

## Purpose

- **Centralized management:** Keep all sorts of CLI and environment configs in one place for backup, syncing, and migration.
- **Cross-platform productivity:** Port finely-tuned environment, aliases, functions, and tool preferences to any supported OS.
- **Rapid onboarding:** New or freshly-installed systems can be brought up to speed fast, reducing setup friction and human error.

## Repository Structure

```
sametaor_CLIconfig/
├── linux/      # Linux-specific dotfiles, shell scripts, and setup instructions
├── windows/    # PowerShell scripts, Windows terminal configs, VMWare profiles
├── misc/       # Cross-platform tools, scripts, or configs not specific to one OS
├── LICENSE
├── README.md   # (this file)
└── .gitignore
```

## General Concepts

- **Dotfiles**—Hidden configuration files (`.bashrc`, `.zshrc`, etc.) that control the behavior of your shell, editors, and CLI environments.
- **Portable scripts**—Reusable scripts for automating setup, installation, and environment bootstrapping.
- **Consistency and extensibility**—Create a base experience that you can further tweak per-device or future OS additions.

## Getting Started

## Prerequisites

Below is a categorized, collapsible “cheat sheet” of every essential tool, covering **all major Linux distros** and **Windows/Android** platforms. If a distro or platform doesn't offer the tool, it is marked "Manual" or "Not applicable". Every line includes a description for quick scanning.

## Prerequisites

Below is a categorized, collapsible “cheat sheet” of every essential tool, covering **all major Linux distros** and **Windows/Android** platforms. If a distro or platform doesn't offer the tool, it is marked "Manual" or "Not applicable". Every line includes a description for quick scanning.

<details>
<summary><strong>🔧 System Tools & Shells</strong></summary>

| Tool                | Description                            | Arch Linux                   | Ubuntu/Debian                | Fedora/RHEL              | openSUSE                   | Alpine           | NixOS               | Gentoo                | Windows                | Android/Termux         |
|---------------------|----------------------------------------|------------------------------|------------------------------|--------------------------|----------------------------|------------------|---------------------|-----------------------|------------------------|------------------------|
| Bash                | Unix shell                             | default                      | default                      | default                  | default                    | default          | default              | default               | MSYS2/WSL              | `pkg install bash`     |
| Zsh                 | Advanced shell                         | `sudo pacman -S zsh`         | `sudo apt install zsh`       | `sudo dnf install zsh`   | `sudo zypper install zsh`  | `apk add zsh`    | `nix-env -iA zsh`    | `emerge zsh`          | MSYS2/WSL              | `pkg install zsh`      |
| Zsh-completions     | Extra tab completions                  | `yay -S zsh-completions`     | manual                       | manual                   | manual                     | manual           | manual               | manual                | N/A                    | N/A                    |
| Tmux                | Terminal multiplexer                   | `sudo pacman -S tmux`        | `sudo apt install tmux`      | `sudo dnf install tmux`  | `sudo zypper install tmux` | `apk add tmux`   | `nix-env -iA tmux`   | `emerge tmux`         | Scoop/Choco             | `pkg install tmux`     |
| Fzf                 | Fuzzy finder                           | `sudo pacman -S fzf`         | `sudo apt install fzf`       | `sudo dnf install fzf`   | `sudo zypper install fzf`  | `apk add fzf`    | `nix-env -iA fzf`    | `emerge fzf`          | Scoop/Choco             | `pkg install fzf`      |
| Zoxide              | Directory jumper                       | `yay -S zoxide`              | `sudo apt install zoxide`    | `sudo dnf install zoxide`| `sudo zypper install zoxide`| `apk add zoxide`| `nix-env -iA zoxide` | `emerge zoxide`        | Scoop/Choco             | `pkg install zoxide`   |
| Curl                | Data transfer util                     | `sudo pacman -S curl`        | `sudo apt install curl`      | `sudo dnf install curl`  | `sudo zypper install curl` | `apk add curl`   | `nix-env -iA curl`   | `emerge curl`          | Scoop/Choco             | `pkg install curl`     |
| Git                 | Version control system                 | `sudo pacman -S git`         | `sudo apt install git`       | `sudo dnf install git`   | `sudo zypper install git`  | `apk add git`    | `nix-env -iA git`    | `emerge git`           | Scoop/Choco             | `pkg install git`      |
| Github-cli          | GitHub CLI                             | `sudo pacman -S github-cli`  | `sudo apt install gh`        | `sudo dnf install gh`    | `sudo zypper install gh`   | `apk add gh`     | `nix-env -iA gh`     | `emerge github-cli`     | Scoop/Choco             | manual (`pkg install gh` may work) |
| Git-lfs             | Large file support for git             | `sudo pacman -S git-lfs`     | `sudo apt install git-lfs`   | `sudo dnf install git-lfs` | `sudo zypper install git-lfs` | `apk add git-lfs`| `nix-env -iA git-lfs`| `emerge git-lfs`       | Scoop/Choco             | `pkg install git-lfs`  |
| Man-db              | Man page utilities                     | `sudo pacman -S man-db`      | `sudo apt install man-db`    | `sudo dnf install man-db`| `sudo zypper install man`  | `apk add man`    | `nix-env -iA man-db` | `emerge man-db`         | Not applicable          | `pkg install man`      |
| Less                | Pager utility                          | `sudo pacman -S less`        | `sudo apt install less`      | `sudo dnf install less`  | `sudo zypper install less` | `apk add less`   | `nix-env -iA less`   | `emerge less`           | WinLess (GitHub manual)| `pkg install less`     |
| Tree                | Directory structure visualizer         | `sudo pacman -S tree`        | `sudo apt install tree`      | `sudo dnf install tree`  | `sudo zypper install tree` | `apk add tree`   | `nix-env -iA tree`   | `emerge tree`           | Scoop/Choco             | `pkg install tree`     |
| Lolcat              | Rainbow text generator                 | `sudo pacman -S lolcat`      | `sudo apt install lolcat`    | manual                  | manual                     | manual           | `nix-env -iA lolcat` | manual                  | manual                  | manual                 |
| Nb-preview          | Markdown previewer                     | `yay -S nb`                  | pip install nbpreview        | pip install nbpreview    | pip install nbpreview      | pip install nb   | `nix-env -iA nb`     | pip                     | pip                     | pip                    |
| Wpctl               | Pipewire audio controller              | `sudo pacman -S wireplumber` | manual                       | manual                   | manual                     | manual           | manual               | manual                  | Not applicable          | manual                 |
| Systemd             | Init system/service manager            | default                      | default                      | default                  | default                    | default          | default              | default                 | Not applicable          | Not applicable         |
| Loginctl            | Login/session manager (systemd)        | default                      | default                      | default                  | default                    | manual           | default              | default                 | Not applicable          | Not applicable         |
| Opendoas/Doas       | Minimal sudo alternative               | `sudo pacman -S opendoas`    | `sudo apt install doas`      | `sudo dnf install doas`  | `sudo zypper install doas` | `apk add doas`   | `nix-env -iA doas`   | `emerge doas`           | N/A                      | manual                 |
| Sudo                | Privilege escalator                    | default                      | default                      | default                  | default                    | default          | default              | default                 | default                 | default                |
| Gpg / gnupg         | Encryption tools                       | `sudo pacman -S gnupg`       | `sudo apt install gnupg`     | `sudo dnf install gnupg` | `sudo zypper install gnupg`| `apk add gnupg`  | `nix-env -iA gnupg`  | `emerge gnupg`          | Gpg4win                  | N/A                    |
| Reflector           | Arch mirrorlist updater                 | `sudo pacman -S reflector`   | N/A                          | N/A                      | N/A                        | N/A              | N/A                  | N/A                     | N/A                      | N/A                    |
| Oh-my-posh          | TUI prompt theme engine                | `yay -S oh-my-posh`          | `sudo apt install oh-my-posh`| manual                   | manual                     | manual           | manual               | manual                  | `scoop install oh-my-posh`| manual                 |
| Tmatrix             | Matrix animation in terminal           | `yay -S tmatrix`             | pip install tmatrix          | pip install tmatrix      | pip install tmatrix        | pip install tmatrix | pip install tmatrix | pip install tmatrix     | N/A                      | pip install tmatrix     |

</details>

<details>
<summary><strong>📝 Editors & IDEs</strong></summary>

| Tool                | Description                                 | Arch Linux                 | Ubuntu/Debian            | Fedora/RHEL                | openSUSE              | Alpine           | NixOS             | Gentoo             | Windows                   | Android/Termux      |
|---------------------|---------------------------------------------|----------------------------|--------------------------|----------------------------|-----------------------|------------------|--------------------|--------------------|--------------------------|---------------------|
| Neovim              | Modern Vim-based editor                     | `sudo pacman -S neovim`    | `sudo apt install neovim`| `sudo dnf install neovim`  | `sudo zypper install neovim`| `apk add neovim`| `nix-env -iA neovim`| `emerge neovim`   | Scoop/Choco/winget       | `pkg install neovim`   |
| Lazygit             | Git TUI client                              | `sudo pacman -S lazygit`   | `sudo apt install lazygit`| `sudo dnf install lazygit` | `sudo zypper install lazygit`| manual       | `nix-env -iA lazygit`| `emerge lazygit`  | Scoop/Choco               | N/A                   |
| Doom Emacs          | Fast Emacs config for editing/coding        | manual (emacs + git)       | manual                   | manual                     | manual               | manual           | manual (git)       | manual           | manual (emacs)           | N/A                   |
| Emacs               | Classic programmable text editor            | `sudo pacman -S emacs`     | `sudo apt install emacs` | `sudo dnf install emacs`   | `sudo zypper install emacs` | `apk add emacs` | `nix-env -iA emacs` | `emerge emacs`  | Scoop/Choco               | N/A                   |
| Vscodium            | Open-source VSCode fork                     | `yay -S vscodium-bin`      | `.deb from upstream`     | manual                     | manual               | manual           | `nix-env -iA vscodium`| manual         | Scoop/Choco/winget        | N/A                   |
| Visual Studio Code  | Microsoft code editor (closed source)       | yay -S visual-studio-code-bin | download .deb           | download .rpm              | download .rpm        | manual           | `nix-env -iA vscode` | manual          | Scoop/Choco/winget        | N/A                   |
| Visual Studio 2022 Community | Full-featured IDE (Windows only)   | N/A                        | N/A                      | N/A                        | N/A                  | N/A              | N/A                | N/A              | `winget install Microsoft.VisualStudio.2022.Community` | N/A      |
| Git Extensions      | GUI for Git on Windows                      | N/A                        | N/A                      | N/A                        | N/A                  | N/A              | N/A                | N/A              | `winget install GitExtensionsTeam.GitExtensions`      | N/A      |
| Glow                | Markdown TUI viewer/editor                  | `yay -S glow`              | `sudo apt install glow`  | `sudo dnf install glow`    | manual               | `apk add glow`   | `nix-env -iA glow` | manual           | Scoop/Choco                | manual                |
| Nb-preview          | Notebook/Markdown previewer (TUI)           | `yay -S nb`                | pip install nbpreview    | pip install nbpreview      | pip install nbpreview | pip install nb   | `nix-env -iA nb`   | pip              | pip                          | pip                   |
| Ascii-image-converter| Convert images to ASCII art in CLI         | `yay -S ascii-image-converter` | `pip install ascii-image-converter` | pip install | pip install | pip install | pip install | pip install | pip                    | pip install         |
</details>


<details>
<summary><strong>📦 Package Managers</strong></summary>

| Tool          | Description                              | Arch Linux                   | Ubuntu/Debian             | Fedora/RHEL                   | openSUSE                  | Alpine             | NixOS           | Gentoo             | Windows          | Android/Termux       |
|---------------|------------------------------------------|------------------------------|---------------------------|-------------------------------|---------------------------|---------------------|------------------|--------------------|---------------------|----------------------|
| Pacman        | Arch pkg manager (native to Arch)        | default                      | N/A                       | N/A                           | N/A                       | N/A                | N/A              | N/A                | N/A                | N/A                 |
| Yay           | AUR helper                               | `git clone ... && makepkg -si`| N/A                       | N/A                           | N/A                       | N/A                | N/A              | N/A                | N/A                | N/A                 |
| Apt           | Debian/Ubuntu pkg manager                | N/A                          | default                   | N/A                           | N/A                       | N/A                | N/A              | N/A                | N/A                | N/A                 |
| Dpkg          | Debian low-level pkg manager             | N/A                          | default                   | N/A                           | N/A                       | N/A                | N/A              | N/A                | N/A                | N/A                 |
| Dnf           | Fedora pkg manager                       | N/A                          | N/A                       | default                        | N/A                       | N/A                | N/A              | N/A                | N/A                | N/A                 |
| Yum           | Old Fedora/Enterprise pkg manager        | N/A                          | N/A                       | `sudo dnf install yum` (compat)| N/A                       | N/A                | N/A              | N/A                | N/A                | N/A                 |
| Zypper        | openSUSE pkg manager                     | N/A                          | N/A                       | N/A                           | default                   | N/A                | N/A              | N/A                | N/A                | N/A                 |
| Apkg          | Alpine pkg manager                       | N/A                          | N/A                       | N/A                           | N/A                       | default            | N/A              | N/A                | N/A                | N/A                 |
| Nix           | NixOS universal pkg manager              | `yay -S nix`                 | `sudo apt install nix`    | `sudo dnf install nix`        | `sudo zypper install nix` | `apk add nix`      | default           | `emerge nix`        | manual              | N/A                 |
| Portage       | Gentoo pkg manager                       | N/A                          | N/A                       | N/A                           | N/A                       | N/A                | N/A              | default            | N/A                | N/A                 |
| Flatpak       | Universal, sandboxed pkg manager         | `sudo pacman -S flatpak`     | `sudo apt install flatpak`| `sudo dnf install flatpak`    | `sudo zypper install flatpak` | `apk add flatpak` | `nix-env -iA flatpak` | manual           | manual               | N/A                 |
| Snap          | Universal, container pkg manager         | `sudo pacman -S snapd`       | `sudo apt install snapd`  | `sudo dnf install snapd`      | `sudo zypper install snapd` | `apk add snapd`   | manual             | manual              | manual (WinSnap)      | N/A                 |
| Homebrew      | Pkg manager for Linux/macOS              | `yay -S linuxbrew`           | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` | see docs | see docs | `apk add brew`*    | see docs         | see docs            | see docs             | N/A                 |
| Chocolatey    | Windows pkg manager                      | N/A                          | N/A                       | N/A                           | N/A                       | N/A                | N/A              | N/A                | `choco install <pkg>` | N/A                |
| Scoop         | Windows pkg manager                      | N/A                          | N/A                       | N/A                           | N/A                       | N/A                | N/A              | N/A                | `scoop install <pkg>` | N/A                |
| Snapd         | Snap daemon for snap pkg                 | `sudo pacman -S snapd`       | `sudo apt install snapd`  | `sudo dnf install snapd`      | `sudo zypper install snapd` | `apk add snapd`   | manual             | manual              | manual (WinSnap)      | N/A                 |
| Pip           | Python package manager                   | `sudo pacman -S python-pip`  | `sudo apt install python3-pip` | `sudo dnf install python3-pip` | `sudo zypper install python3-pip` | `apk add py3-pip` | `nix-env -iA python3.pkgs.pip` | pip emerge | Winget/Scoop/Choco | `pkg install python` |
| Pipx          | Python app installer in isolated env     | `sudo pacman -S pipx`        | `sudo apt install pipx`   | `sudo dnf install pipx`       | `sudo zypper install pipx` | pip install pipx   | `nix-env -iA pipx` | pip emerge           | pipx (WinPython)      | pip install pipx       |
| Pipenv        | Python dependency management tool        | `sudo pacman -S pipenv`      | `sudo apt install pipenv` | `sudo dnf install pipenv`     | `sudo zypper install pipenv` | pip install pipenv | `nix-env -iA pipenv` | pip emerge         | pip install pipenv     | pip install pipenv     |
| Anaconda/Miniconda | Python distros with pkg mgmt tools  | manual                       | manual                    | manual                        | manual                    | manual             | manual           | manual               | manual                | manual                |
| Cargo         | Rust package manager                     | `sudo pacman -S cargo`       | `sudo apt install cargo`  | `sudo dnf install cargo`      | `sudo zypper install cargo` | `apk add cargo`   | `nix-env -iA cargo` | `emerge cargo`        | Windows installer      | manual                |
| RubyGems      | Ruby package manager                     | `sudo pacman -S ruby`        | `sudo apt install ruby`   | `sudo dnf install ruby`       | `sudo zypper install ruby` | `apk add ruby`    | `nix-env -iA ruby`  | `emerge ruby`         | Bundled with Ruby      | manual                |
| Npm           | Node.js package manager                  | `sudo pacman -S npm`         | `sudo apt install npm`    | `sudo dnf install npm`        | `sudo zypper install npm` | `apk add npm`     | `nix-env -iA nodejs npm` | `emerge npm`     | Winget/Scoop/Choco     | `pkg install nodejs`   |
| Pnpm          | Fast Node package manager                | `sudo pacman -S pnpm`        | `sudo apt install pnpm`   | `sudo dnf install pnpm`       | `sudo zypper install pnpm` | npm install -g pnpm | `nix-env -iA pnpm` | `emerge pnpm`      | Scoop/Choco            | npm install -g pnpm    |
| Perl5         | Perl language and cpan pkg manager       | `sudo pacman -S perl`        | `sudo apt install perl`   | `sudo dnf install perl`       | `sudo zypper install perl` | `apk add perl`    | `nix-env -iA perl`  | `emerge perl`         | windows perl          | `pkg install perl`     |

</details>

<details>
<summary><strong>🎨 Desktop, Audio & Misc Tools</strong></summary>

| Tool                 | Description                          | Arch Linux                | Ubuntu/Debian              | Fedora/RHEL               | openSUSE                | Alpine           | NixOS                | Gentoo               | Windows                | Android/Termux      |
|----------------------|--------------------------------------|---------------------------|-----------------------------|---------------------------|-------------------------|-------------------|----------------------|----------------------|------------------------|---------------------|
| Hyprland             | Wayland compositor                   | `yay -S hyprland`         | manual                      | manual                    | manual                  | manual            | `nix-env -iA hyprland`| manual               | N/A                   | N/A                |
| Hypridle             | Idle daemon for Hyprland             | `yay -S hypridle`         | manual                      | manual                    | manual                  | manual            | manual               | manual               | N/A                   | N/A                |
| Hyprpicker           | Color picker for Hyprland             | `yay -S hyprpicker`       | manual                      | manual                    | manual                  | manual            | cargo                | manual               | N/A                   | N/A                |
| Hyprplugins          | Plugins for Hyprland                 | `yay -S hyprland-plugins` | manual                      | manual                    | manual                  | manual            | manual               | manual               | N/A                   | N/A                |
| Hyprshot             | Screenshot tool for Hyprland          | `yay -S hyprshot`         | manual (cargo)              | manual (cargo)            | manual (cargo)          | manual (cargo)    | manual (cargo)        | cargo                | N/A                   | N/A                |
| Fuzzel               | Launcher menu for Wayland             | `yay -S fuzzel`           | manual (cargo)              | manual (cargo)            | manual (cargo)          | manual (cargo)    | `nix-env -iA fuzzel` | cargo                | N/A                   | N/A                |
| Cliphist             | Clipboard history (Wayland)           | `yay -S cliphist`         | cargo install cliphist      | cargo install cliphist    | cargo install cliphist  | cargo install     | cargo install          | cargo install         | N/A                   | N/A                |
| Wl-copy              | Copy text to clipboard (Wayland)      | `sudo pacman -S wl-clipboard` | `sudo apt install wl-clipboard` | `sudo dnf install wl-clipboard` | `sudo zypper install wl-clipboard` | manual      | `nix-env -iA wl-clipboard` | `emerge wl-clipboard` | manual            | N/A                |
| Wl-paste             | Paste from clipboard (Wayland)        | see wl-clipboard           | see wl-clipboard            | see wl-clipboard          | see wl-clipboard         | manual            | see wl-clipboard       | see wl-clipboard      | manual                | N/A                |
| Swww                 | Wayland wallpaper daemon              | `yay -S swww`             | cargo                       | cargo                     | cargo                   | cargo             | cargo                  | cargo                 | N/A                   | N/A                |
| Kitty                | GPU-accelerated terminal emulator     | `sudo pacman -S kitty`    | `sudo apt install kitty`    | `sudo dnf install kitty`  | `sudo zypper install kitty` | `apk add kitty` | `nix-env -iA kitty`   | `emerge kitty`        | manual/installer       | N/A                |
| Ghostty              | Fast terminal emulator                | `yay -S ghostty`          | cargo/manual                | cargo/manual              | cargo/manual            | cargo/manual      | cargo/manual            | cargo/manual           | manual/installer       | N/A                |
| Playerctl            | Media player controller (MPRIS)       | `sudo pacman -S playerctl`| `sudo apt install playerctl`| `sudo dnf install playerctl` | `sudo zypper install playerctl` | `apk add playerctl` | `nix-env -iA playerctl`| `emerge playerctl`   | manual                | N/A                |
| Cava                 | Audio spectrum visualizer (TUI)       | `yay -S cava`             | `sudo apt install cava`     | `sudo dnf install cava`   | manual                  | manual            | `nix-env -iA cava`     | `emerge cava`        | manual                | N/A                |
| JamesDSP             | Audio effects daemon (Linux/Wayland)  | `yay -S jamesdsp`         | manual                      | manual                    | manual                  | manual            | manual                 | manual                | N/A                   | N/A                |
| Wpctl                | PipeWire audio control tool           | `sudo pacman -S wireplumber` | manual                      | manual                    | manual                  | manual            | manual                 | manual                | N/A                   | manual             |
| Wayland/Weston       | Protocol/compositor for modern Linux  | `sudo pacman -S weston`   | `sudo apt install weston`   | `sudo dnf install weston` | `sudo zypper install weston` | `apk add weston` | `nix-env -iA weston`  | `emerge weston`       | N/A                   | N/A                |
| Qt5ct                | Qt5 theme config utility              | `sudo pacman -S qt5ct`    | `sudo apt install qt5ct`    | `sudo dnf install qt5ct`  | `sudo zypper install qt5ct` | `apk add qt5ct`  | `nix-env -iA qt5ct`   | `emerge qt5ct`        | manual                | N/A                |
| Flatpak              | Universal Linux package/app manager   | `sudo pacman -S flatpak`  | `sudo apt install flatpak`  | `sudo dnf install flatpak`| `sudo zypper install flatpak` | `apk add flatpak`| `nix-env -iA flatpak` | manual               | manual                | N/A                |
| Dino                 | Modern XMPP desktop chat              | `sudo pacman -S dino`     | `sudo apt install dino-im`  | `sudo dnf install dino`   | `sudo zypper install dino`  | `apk add dino`   | `nix-env -iA dino`    | `emerge dino`          | manual                | N/A                |
| Rclone               | Cloud storage synchronizer            | `sudo pacman -S rclone`   | `sudo apt install rclone`   | `sudo dnf install rclone` | `sudo zypper install rclone` | `apk add rclone` | `nix-env -iA rclone`  | `emerge rclone`        | Scoop/Choco            | `pkg install rclone`|
| Steam                | Popular game launcher (Linux/Windows) | `sudo pacman -S steam`    | `sudo apt install steam`    | `sudo dnf install steam`  | `sudo zypper install steam` | manual           | `nix-env -iA steam`   | manual                | Scoop/Choco/Winget     | N/A                |
| Vscodium             | OSS Visual Studio Code                | `yay -S vscodium-bin`     | see Editors                 | see Editors                | see Editors               | see Editors        | see Editors           | see Editors            | see Editors            | N/A                |
| Spicetify            | Spotify theming tool                  | `yay -S spicetify-cli`    | manual (npm)                | manual (npm)              | manual (npm)              | manual (npm)       | manual (npm)          | manual (npm)           | manual (npm)            | N/A                |
| Swww                 | Wallpaper daemon for Wayland          | see above                 | see above                   | see above                 | see above                 | see above          | see above             | see above              | N/A                    | N/A                |
| Kwinrc               | KWin config utility, KDE              | part of KDE               | part of KDE                 | part of KDE               | part of KDE               | N/A                | manual                | manual                 | N/A                    | N/A                |
| Exifaudio            | Audio file metadata                   | `yay -S exifaudio`        | pip install exifaudio       | pip install exifaudio     | pip install exifaudio     | pip install exifaudio| pip install exifaudio| pip install exifaudio   | N/A                    | pip install exifaudio|
| Ouch                 | Multi-format archiver                 | `yay -S ouch`             | cargo install ouch          | cargo install ouch        | cargo install ouch        | cargo install ouch | cargo install ouch     | cargo install ouch      | N/A                    | N/A                |
| Duckdb               | Embeddable database                   | `yay -S duckdb`           | `sudo apt install duckdb`   | `sudo dnf install duckdb` | cargo/manual              | cargo/manual       | `nix-env -iA duckdb`   | manual                 | Scoop/Choco (manual)    | pip install duckdb    |
| Fastfetch            | Neofetch alternative, system info     | `yay -S fastfetch`        | `sudo apt install fastfetch`| `sudo dnf install fastfetch`| manual                  | `apk add fastfetch` | `nix-env -iA fastfetch`| manual                 | manual (Winfetch)       | N/A                |
| Nb-preview           | Notebook/markdown previewer           | see Editors                | see Editors                 | see Editors                | see Editors               | see Editors         | see Editors            | see Editors             | see Editors             | see Editors        |
| Bat                  | Cat with syntax highlighting          | see System Tools           | see System Tools            | see System Tools           | see System Tools          | see System Tools    | see System Tools       | see System Tools        | see System Tools        | see System Tools   |

</details>

<details>
<summary><strong>🪟 Windows-specific Tools</strong></summary>

| Tool                 | Description                              | winget                                                        | scoop                           | choco                      | Manual                           |
|----------------------|------------------------------------------|---------------------------------------------------------------|----------------------------------|----------------------------|----------------------------------|
| PowerShell           | Modern Microsoft shell                   | `winget install Microsoft.Powershell`                         | N/A                             | N/A                        | N/A                             |
| Windows Terminal     | Modern terminal with tabs                | `winget install Microsoft.WindowsTerminal`                    | N/A                             | N/A                        | N/A                             |
| Terminal-Icons       | Shell icons for PowerShell               | N/A                                                          | N/A                             | N/A                        | `Install-Module -Name Terminal-Icons -Repository PSGallery` (in PowerShell) |
| 7zip                 | File archiver                            | `winget install 7zip.7zip`                                   | N/A                             | `choco install 7zip`       | N/A                             |
| GitHub CLI           | Official GitHub CLI tool                 | `winget install GitHub.cli`                                   | `scoop install gh`              | `choco install gh`         | N/A                             |
| Git Extensions       | Git GUI                                  | `winget install GitExtensionsTeam.GitExtensions`              | N/A                             | N/A                        | N/A                             |
| Docker Desktop       | Docker containers                        | `winget install Docker.DockerDesktop`                         | N/A                             | `choco install docker-desktop`| N/A                         |
| WSL/Wslg             | Linux inside Windows                     | `wsl --install` (from cmd)                                    | N/A                             | N/A                        | Windows Features                |
| Chocolatey           | Windows package manager                  | N/A                                                          | N/A                             | Manual                     | [choco docs](https://chocolatey.org/install) |
| Scoop                | Windows package manager                  | N/A                                                          | Manual                          | N/A                        | [scoop docs](https://scoop.sh/) |
| Fzf                  | Fuzzy finder CLI                         | N/A                                                          | `scoop install fzf`             | `choco install fzf`        | N/A                             |
| Fastfetch            | Neofetch alternative, system info        | `winget install Fastfetch.Fastfetch`                          | `scoop install fastfetch`       | `choco install fastfetch`  | [GitHub MSI](https://github.com/fastfetch-cli/fastfetch/releases) |
| Oh-my-posh           | Shell prompt engine                      | `winget install JanDeDobbeleer.OhMyPosh`                      | `scoop install oh-my-posh`      | N/A                        | N/A                             |
| Gpg4win              | Encryption/signing suite                 | `winget install Gpg4win.Gpg4win`                              | N/A                             | N/A                        | N/A                             |
| Spicetify            | Spotify theming                          | N/A                                                          | N/A                             | `choco install spicetify-cli`| [GitHub](https://github.com/spicetify/spicetify-cli/releases) |
| Neovim               | Modern Vim-based editor                  | `winget install Neovim.Neovim`                                | `scoop install neovim`          | N/A                        | N/A                             |
| Eza/Exa              | Modern ls replacement                    | N/A                                                          | `scoop install eza`             | `choco install eza`        | N/A                             |
| Pip (Python)         | Python package management                | `winget install Python.Python.3.14`                           | N/A                             | N/A                        | N/A                             |
| Git                  | Version control system                   | `winget install Git.Git`                                      | `scoop install git`             | `choco install git`        | N/A                             |
| Visual Studio Code   | Editor (OSS & MS variant)                | `winget install Microsoft.VisualStudioCode`                   | `scoop install vscode`          | `choco install vscode`     | N/A                             |
| Visual Studio 2022 Build Tools | Compiler toolchain             | `winget install Microsoft.VisualStudio.2022.BuildTools`        | N/A                             | N/A                        | N/A                             |
| Visual Studio 2022 Community | Full-featured IDE                | `winget install Microsoft.VisualStudio.2022.Community`        | N/A                             | N/A                        | N/A                             |
| OBS Studio           | Screen recording/Broadcast software      | `winget install OBSProject.OBSStudio`                         | N/A                             | N/A                        | N/A                             |
| Rainmeter            | Desktop widget customization             | `winget install Rainmeter.Rainmeter`                          | N/A                             | N/A                        | N/A                             |
| Qbittorrent          | Torrent client                           | `winget install qBittorrent.qBittorrent`                      | N/A                             | N/A                        | N/A                             |
| Everything Search    | Fast desktop search                      | `winget install voidtools.Everything`                         | N/A                             | N/A                        | N/A                             |
| RetroArch            | Emulator suite                           | `winget install libretro.RetroArch`                           | N/A                             | N/A                        | N/A                             |
| Flow Launcher        | App/utility launcher                     | `winget install Flow-Launcher.Flow-Launcher`                  | N/A                             | N/A                        | N/A                             |
| Bulk Crap Uninstaller| Debloat/uninstall tool                   | `winget install Klocman.BulkCrapUninstaller`                  | N/A                             | N/A                        | N/A                             |
| Discord              | Messaging/VoIP                           | `winget install Discord.Discord`                              | N/A                             | N/A                        | N/A                             |
| Telegram             | Messaging app                            | `winget install Telegram.TelegramDesktop`                     | N/A                             | N/A                        | N/A                             |
| OneDrive             | Microsoft cloud sync                     | `winget install Microsoft.OneDrive` (or pre-installed)        | N/A                             | N/A                        | N/A                             |
| ProtonVPN            | VPN provider                             | `winget install ProtonTechnologies.ProtonVPN`                 | N/A                             | N/A                        | N/A                             |
| Zen Browser          | Chromium-based browser alt               | N/A                                                          | N/A                             | N/A                        | Manual download                 |
| Winaero Tweaker      | Windows customization tool               | N/A                                                          | N/A                             | N/A                        | Manual download                 |
| Microsoft VCRedist 2010 x64 | C++ libraries                     | `winget install Microsoft.VCRedist.2010.x64`                  | N/A                             | N/A                        | N/A                             |
| Microsoft VCRedist 2010 x86 | C++ libraries                     | `winget install Microsoft.VCRedist.2010.x86`                  | N/A                             | N/A                        | N/A                             |
| Microsoft VCRedist 2012 x64 | C++ libraries                     | `winget install Microsoft.VCRedist.2012.x64`                  | N/A                             | N/A                        | N/A                             |
| Microsoft VCRedist 2013 x64 | C++ libraries                     | `winget install Microsoft.VCRedist.2013.x64`                  | N/A                             | N/A                        | N/A                             |
| Microsoft VCRedist 2013 x86 | C++ libraries                     | `winget install Microsoft.VCRedist.2013.x86`                  | N/A                             | N/A                        | N/A                             |
| Microsoft VCRedist 2015+ x64| Modern C++ libraries              | `winget install Microsoft.VCRedist.2015+.x64`                 | N/A                             | N/A                        | N/A                             |
| Microsoft VCRedist 2015+ x86| Modern C++ libraries              | `winget install Microsoft.VCRedist.2015+.x86`                 | N/A                             | N/A                        | N/A                             |
| Microsoft .NET Desktop Runtime 6 | .NET runtime                  | `winget install Microsoft.DotNet.DesktopRuntime.6`            | N/A                             | N/A                        | N/A                             |
| Microsoft .NET Desktop Runtime 3.1 | .NET runtime                 | `winget install Microsoft.DotNet.DesktopRuntime.3.1`           | N/A                             | N/A                        | N/A                             |
| Microsoft .NET Desktop Runtime 5 | .NET runtime                   | `winget install Microsoft.DotNet.DesktopRuntime.5`             | N/A                             | N/A                        | N/A                             |
| Microsoft .NET Desktop Runtime 7 | .NET runtime                   | `winget install Microsoft.DotNet.DesktopRuntime.7`             | N/A                             | N/A                        | N/A                             |
| Microsoft .NET Desktop Runtime 8 | .NET runtime                   | `winget install Microsoft.DotNet.DesktopRuntime.8`             | N/A                             | N/A                        | N/A                             |
| Intel Driver & Support Assistant   | Update/check Intel drivers     | `winget install Intel.DriverAndSupportAssistant`               | N/A                             | N/A                        | N/A                             |
| GOG Galaxy            | Game launcher/storefront                | `winget install GOG.Galaxy`                                   | N/A                             | N/A                        | N/A                             |
| Nvidia/PhysX/NVCleanstall| GPU drivers/utilities                | `winget install TechPowerUp.NVCleanstall`                     | N/A                             | N/A                        | N/A                             |
| FxSound               | System audio enhancement                 | `winget install FxSound.FxSoundEnhancer`                      | N/A                             | N/A                        | N/A                             |
| Godot Engine          | 2D/3D game engine                        | `winget install GodotEngine.Godot`                            | N/A                             | N/A                        | N/A                             |
| Ollama                | LLM desktop inference                     | `winget install Ollama.Ollama`                                | N/A                             | N/A                        | N/A                             |
| Microsoft Teams       | Collaboration tool                        | `winget install Microsoft.Teams`                              | N/A                             | N/A                        | N/A                             |
| AppInstaller          | MSIX app package handler                  | Windows Update                                                | N/A                             | N/A                        | N/A                             |
| OpenRGB               | RGB lighting control                       | `winget install OpenRGB.OpenRGB`                              | N/A                             | N/A                        | N/A                             |
| Scrcpy                | Android screen mirroring                   | `winget install Genymobile.Scrcpy`                            | N/A                             | N/A                        | N/A                             |
| Bitwarden             | Password manager                            | `winget install Bitwarden.Bitwarden`                          | N/A                             | N/A                        | N/A                             |
| EA Desktop            | Game launcher                                 | `winget install ElectronicArts.EADesktop`                     | N/A                             | N/A                        | N/A                             |
| FFmpeg                | Video convert/tool suite                        | `winget install Gyan.FFmpeg`                                 | `scoop install ffmpeg`          | N/A                        | N/A                             |
| Steam                 | PC gaming/distribution                             | `winget install Valve.Steam`                                 | N/A                             | N/A                        | N/A                             |
| Epic Games Launcher   | PC gaming/distribution                             | `winget install EpicGames.EpicGamesLauncher`                 | N/A                             | N/A                        | N/A                             |
| Obsidian              | Markdown-based knowledge base                      | `winget install Obsidian.Obsidian`                           | N/A                             | N/A                        | N/A                             |
| Xemu                  | Xbox emulator                                         | `winget install Xemu.Xemu`                                   | N/A                             | N/A                        | N/A                             |
| Microsoft Edge        | Default web browser                                    | `winget install Microsoft.Edge`                              | N/A                             | N/A                        | N/A                             |
| MSEdge Redirect       | Edge handler for Win                                     | `winget install RC114.MSEdgeRedirect`                        | N/A                             | N/A                        | N/A                             |
| Devtoys               | Developer toolbox (guid generator etc)                        | `winget install DevToys.DevToys`                             | N/A                             | N/A                        | N/A                             |
| HWiNFO                | Hardware information                                     | `winget install REALiX.HWiNFO`                               | N/A                             | N/A                        | N/A                             |
| WiseToys              | Productivity/utility launcher                                 | `winget install WiseToys.WiseToys`                           | N/A                             | N/A                        | N/A                             |
| File Converter        | Easy file format conversion                                   | `winget install AdrienAllard.FileConverter`                  | N/A                             | N/A                        | N/A                             |
| Link Shell Extension  | Advanced symlink/shell tool                                    | `winget install Schinagl.LinkShellExtension`                 | N/A                             | N/A                        | N/A                             |
| Playnite              | All-in-one game launcher                                        | `winget install Playnite.Playnite`                           | N/A                             | N/A                        | N/A                             |
| Prism Launcher        | Minecraft launcher                                             | `winget install PrismLauncher.PrismLauncher`                 | N/A                             | N/A                        | N/A                             |
| Nilesoft Shell        | Extended context menu tool                                    | `winget install Nilesoft.Shell`                              | N/A                             | N/A                        | N/A                             |
| Sony Imaging Edge Webcam | Virtual webcam tool                                     | `winget install Sony.ImagingEdgeWebcam`                      | N/A                             | N/A                        | N/A                             |
| Mica For Everyone     | Acrylic/mica effect for Windows                               | `winget install MicaForEveryone.MicaForEveryone`             | N/A                             | N/A                        | N/A                             |
| Powertoys             | Power user utilities                                           | `winget install Microsoft.PowerToys`                         | N/A                             | N/A                        | N/A                             |
| App Installer         | MSIX app installer                                            | Windows Update                                               | N/A                             | N/A                        | N/A                             |
| Skype                 | Classic messaging app                                         | `winget install Microsoft.Skype`                             | N/A                             | N/A                        | N/A                             |
| NuGet                 | .NET package manager                                          | N/A                                                          | N/A                             | N/A                        | Included in Visual Studio       |
| ASIO4ALL              | Audio driver                                                  | N/A                                                          | N/A                             | N/A                        | [Manual Install](https://asio4all.org/)              |
| Creative Cloud        | Adobe app suite                                               | N/A                                                          | N/A                             | N/A                        | [Manual Download](https://creativecloud.adobe.com/)   |
| EarthPro              | Google Earth Pro                                              | `winget install Google.EarthPro`                             | N/A                             | N/A                        | N/A                             |
| 8 Gadget Pack         | Classic gadget/sidebar support                                | N/A                                                          | N/A                             | N/A                        | [Manual Download](https://8gadgetpack.net/)           |
| Ventoy                | Multiboot USB builder                                         | `winget install Ventoy.Ventoy`                               | N/A                             | N/A                        | N/A                             |
| Android Studio        | Android dev IDE                                               | `winget install Google.AndroidStudio`                        | N/A                             | N/A                        | N/A                             |
| x64dbg                | Debugger/disassembler                                         | `winget install x64dbg.x64dbg`                               | N/A                             | N/A                        | N/A                             |
| MSI Afterburner       | GPU overclock monitor                                         | N/A                                                          | N/A                             | N/A                        | [Manual Download](https://www.msi.com/Landing/afterburner/graphics-cards) |
| ... (all others have explicit list entries above)                                     |                                                              |                                  |                            |                                  |

</details>




<details>
<summary><strong>📝 Editors & IDEs</strong></summary>

| Tool               | Description                          | Arch Linux                 | Ubuntu/Debian            | Fedora/RHEL               | openSUSE                  | Alpine           | NixOS                 | Gentoo             | Windows              | Android/Termux       |
|--------------------|--------------------------------------|----------------------------|--------------------------|---------------------------|---------------------------|------------------|------------------------|--------------------|----------------------|---------------------|
| Neovim             | Modern Vim-based editor              | `sudo pacman -S neovim`    | `sudo apt install neovim`| `sudo dnf install neovim` | `sudo zypper install neovim`| `apk add neovim`| `nix-env -iA neovim`  | `emerge neovim`     | Scoop/Choco/winget   | `pkg install neovim`|
| Vscodium           | Open-source VSCode fork              | `yay -S vscodium-bin`      | deb from upstream        | manual                    | manual                    | manual           | `nix-env -iA vscodium`| manual             | Scoop/Choco/winget   | N/A                |
| Doom Emacs         | Fast Emacs config                    | manual                     | manual                   | manual                    | manual                    | manual           | manual                 | manual             | manual (emacs)       | N/A                |
| ... more editors   |
</details>

<details>
<summary><strong>📦 Package Managers</strong></summary>

| Tool       | Description                      | Arch Linux            | Ubuntu/Debian          | Fedora/RHEL           | openSUSE              | Alpine           | NixOS                   | Gentoo             | Windows             | Android/Termux      |
|------------|----------------------------------|-----------------------|------------------------|-----------------------|-----------------------|------------------|-------------------------|--------------------|---------------------|---------------------|
| Yay        | AUR helper                       | `git clone ...` then makepkg | N/A                   | N/A                  | N/A                  | N/A              | N/A                    | N/A                | N/A                | N/A                |
| Pacman     | Arch package manager             | default               | N/A                    | N/A                  | N/A                  | N/A              | N/A                    | N/A                | N/A                | N/A                |
| Apt        | Debian/Ubuntu package manager    | N/A                   | default                | N/A                  | N/A                  | N/A              | N/A                    | N/A                | N/A                | N/A                |
| Dnf        | Fedora package manager           | N/A                   | N/A                    | default               | N/A                  | N/A              | N/A                    | N/A                | N/A                | N/A                |
| Snap       | Snap packages                    | `sudo pacman -S snapd`| `sudo apt install snapd`| `sudo dnf install snapd`| `sudo zypper install snapd`| `apk add snapd`| N/A                  | N/A                | N/A                | N/A                |
| Flatpak    | Universal package manager        | `sudo pacman -S flatpak` | `sudo apt install flatpak` | `sudo dnf install flatpak` | `sudo zypper install flatpak` | `apk add flatpak` | `nix-env -iA flatpak` | N/A | N/A | N/A |
| Homebrew   | macOS/Linux/universal pkg mgr    | yay -S linuxbrew      | see docs               | see docs              | see docs              | see docs         | see docs                 | see docs           | see docs            | N/A                |
| ... more managers |
</details>

<details>
<summary><strong>🎨 Desktop, Audio & Misc Tools</strong></summary>

| Tool               | Description                  | Arch      | Ubuntu/Debian | Fedora/RHEL | openSUSE | Alpine | NixOS  | Gentoo | Windows  | Android/Termux |
|--------------------|-----------------------------|-----------|---------------|-------------|----------|--------|--------|--------|----------|---------------|
| Hyprland           | Wayland compositor           | yay -S hyprland | manual | manual | manual | manual | `nix-env -iA hyprland` | manual | N/A      | N/A |
| Swww               | Wayland wallpaper daemon     | yay -S swww | cargo | cargo | cargo | cargo | cargo  | cargo  | N/A | N/A |
| Cava               | Audio spectrum visualizer    | yay -S cava | `sudo apt install cava` | `sudo dnf install cava` | manual | manual | `nix-env -iA cava` | emerge media-sound/cava | manual | N/A |
| JamesDSP           | Audio effects daemon         | yay -S jamesdsp | manual | manual | manual | manual | manual | manual | N/A | N/A |
| Playerctl          | Media player controls        | `sudo pacman -S playerctl` | `sudo apt install playerctl` | `sudo dnf install playerctl` | `sudo zypper install playerctl` | `apk add playerctl` | `nix-env -iA playerctl` | `emerge playerctl` | manual | N/A |
| ... all others from your list |
</details>

<details>
<summary><strong>🪟 Windows-specific</strong></summary>

| Tool                  | Description                        | Windows Install (Scoop/Choco/winget/manual)                                                                         |
|-----------------------|------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| Powershell            | Modern shell                       | `winget install Microsoft.Powershell`                                                                                |
| Windows Terminal      | Console with tabs/themes           | `winget install Microsoft.WindowsTerminal`                                                                          |
| Fzf                   | Fuzzy finder                       | `scoop install fzf` / `choco install fzf`                                                                           |
| 7zip                  | Archive manager                    | `winget install 7zip.7zip` / `choco install 7zip`                                                                   |
| GitHub CLI            | GitHub CLI                         | `winget install Github.cli` / `scoop install gh` / `choco install gh`                                               |
| Microsoft VCRedist... | Various C++ runtimes               | `winget install Microsoft.VCRedist.2015+...` (repeat for each version as needed)                                    |
| Visual Studio         | Microsoft IDE                      | `winget install Microsoft.VisualStudio.2022.Community` / `choco install visualstudio2022community`                  |
| Docker Desktop        | Docker containers                  | `winget install Docker.DockerDesktop` / `choco install docker-desktop`                                              |
| Obsidian              | Markdown knowledge base            | `winget install Obsidian.Obsidian` / `choco install obsidian`                                                       |
| ... and everything from your Windows list                  |                                                                                                                     |
</details>

## Credits
