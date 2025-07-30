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

<details>
<summary><strong>🔧 System Tools & Shells</strong></summary>

| Tool        | Description                 | Arch (Pacman/yay)                       | Ubuntu/Debian (apt)           | Fedora/RHEL (dnf)           | openSUSE (zypper)          | Alpine (apk)            | NixOS (nix-env)               | Gentoo (emerge)     | Windows (winget/scoop/choco)             | Android/Termux         |
|-------------|----------------------------|------------------------------------------|-------------------------------|-----------------------------|----------------------------|--------------------------|-------------------------------|---------------------|------------------------------------------|------------------------|
| Bash        | Unix shell                 | `sudo pacman -S bash`                   | `sudo apt install bash`        | `sudo dnf install bash`     | `sudo zypper install bash` | `apk add bash`           | `nix-env -iA nixos.bash`      | `emerge bash`       | Default/MSYS2/`winget install GNU.Bash`  | `pkg install bash`     |
| Zsh         | Advanced shell             | `sudo pacman -S zsh`                    | `sudo apt install zsh`         | `sudo dnf install zsh`      | `sudo zypper install zsh`  | `apk add zsh`            | `nix-env -iA nixos.zsh`       | `emerge zsh`        | `winget install GNU.Zsh`                | `pkg install zsh`      |
| Zsh-completions | Extra tab completions  | `yay -S zsh-completions`                | `sudo apt install zsh-common`* | `dnf copr enable ngompa/shells && sudo dnf install zsh-completions` | `sudo zypper install zsh-completions` | `apk add zsh-completions` | `nix-env -iA nixos.zsh-completions` | `emerge zsh-completions` | `scoop install zsh-completions` | `pkg install zsh-completions` |
| Tmux        | Terminal multiplexer       | `sudo pacman -S tmux`                   | `sudo apt install tmux`        | `sudo dnf install tmux`     | `sudo zypper install tmux` | `apk add tmux`           | `nix-env -iA nixos.tmux`      | `emerge tmux`       | `winget install GnuWin32.Tmux`/`scoop install tmux` | `pkg install tmux`   |
| Fzf         | Fuzzy finder               | `sudo pacman -S fzf`                    | `sudo apt install fzf`         | `sudo dnf install fzf`      | `sudo zypper install fzf`  | `apk add fzf`            | `nix-env -iA nixos.fzf`       | `emerge fzf`        | `winget install fzf`/`scoop install fzf`/`choco install fzf` | `pkg install fzf`   |
| Zoxide      | Directory jumper           | `yay -S zoxide`                         | `sudo apt install zoxide`      | `sudo dnf install zoxide`   | `sudo zypper install zoxide`| `apk add zoxide`        | `nix-env -iA nixos.zoxide`    | `emerge zoxide`     | `scoop install zoxide`/`choco install zoxide`| `pkg install zoxide`|
| Curl        | Data transfer util         | `sudo pacman -S curl`                   | `sudo apt install curl`        | `sudo dnf install curl`     | `sudo zypper install curl` | `apk add curl`           | `nix-env -iA nixos.curl`      | `emerge curl`       | `winget install curl`/`scoop install curl`/`choco install curl` | `pkg install curl` |
| Git         | Version control            | `sudo pacman -S git`                    | `sudo apt install git`         | `sudo dnf install git`      | `sudo zypper install git`  | `apk add git`            | `nix-env -iA nixos.git`       | `emerge git`        | `winget install Git.Git`/`scoop install git`/`choco install git` | `pkg install git`  |
| Git-lfs     | Large file support for git | `sudo pacman -S git-lfs`                | `sudo apt install git-lfs`     | `sudo dnf install git-lfs`  | `sudo zypper install git-lfs`| `apk add git-lfs`      | `nix-env -iA nixos.git-lfs`   | `emerge git-lfs`    | `winget install GitHub.GitLFS`/`scoop install git-lfs`/`choco install git-lfs` | `pkg install git-lfs`|
| Man-db      | Man page utilities         | `sudo pacman -S man-db`                 | `sudo apt install man-db`      | `sudo dnf install man-db`   | `sudo zypper install man`  | `apk add man`            | `nix-env -iA nixos.man-db`    | `emerge man-db`     | `scoop install man-db`/`choco install man-db` | `pkg install man`      |
| Less        | Pager utility              | `sudo pacman -S less`                   | `sudo apt install less`        | `sudo dnf install less`     | `sudo zypper install less` | `apk add less`           | `nix-env -iA nixos.less`      | `emerge less`       | `scoop install less`                      | `pkg install less`     |
| Tree        | Directory visualizer       | `sudo pacman -S tree`                   | `sudo apt install tree`        | `sudo dnf install tree`     | `sudo zypper install tree` | `apk add tree`           | `nix-env -iA nixos.tree`      | `emerge tree`       | `scoop install tree`/`choco install tree` | `pkg install tree`     |
| Lolcat      | Rainbow text generator     | `sudo pacman -S lolcat`                 | `sudo apt install lolcat`**    | Gem: `gem install lolcat`   | Gem: `gem install lolcat`  | `gem install lolcat`     | `nix-env -iA nixos.lolcat`    | `emerge lolcat`     | `scoop install lolcat`/`choco install lolcat` | `pkg install lolcat`   |
| Bat         | `cat` with highlighting    | `sudo pacman -S bat`                    | `sudo apt install bat`         | `sudo dnf install bat`      | `sudo zypper install bat`  | `apk add bat`            | `nix-env -iA nixos.bat`       | `emerge bat`        | `winget install sharkdp.bat`/`scoop install bat`/`choco install bat` | `pkg install bat` |
| Hexyl       | Hex viewer                 | `sudo pacman -S hexyl`                  | `sudo apt install hexyl`       | `sudo dnf install hexyl`    | `sudo zypper install hexyl`| `apk add hexyl`          | `nix-env -iA nixos.hexyl`     | `emerge hexyl`      | `winget install sharkdp.hexyl`/`scoop install hexyl`/`choco install hexyl` | `pkg install hexyl`|
| Eza         | Modern ls replacement      | `sudo pacman -S eza`                    | `sudo apt install eza`         | `sudo dnf install eza`      | `sudo zypper install eza`  | `apk add eza`            | `nix-env -iA nixos.eza`       | `emerge eza`        | `winget install eza-community.eza`/`scoop install eza`/`choco install eza` | `pkg install eza` |
| Fd          | Find alternative           | `sudo pacman -S fd`                     | `sudo apt install fd-find`     | `sudo dnf install fd-find`  | `sudo zypper install fd`   | `apk add fd`             | `nix-env -iA nixos.fd`        | `emerge fd`         | `winget install sharkdp.fd`/`scoop install fd`/`choco install fd` | `pkg install fd`  |
| Ripgrep     | Modern grep                | `sudo pacman -S ripgrep`                | `sudo apt install ripgrep`     | `sudo dnf install ripgrep`  | `sudo zypper install ripgrep`| `apk add ripgrep`      | `nix-env -iA nixos.ripgrep`   | `emerge ripgrep`    | `winget install BurntSushi.ripgrep`/`scoop install ripgrep`/`choco install ripgrep` | `pkg install ripgrep`|
| Btop           | Resource monitor              | `sudo pacman -S btop`         | `sudo apt install btop`     | `sudo dnf install btop`     | `sudo zypper install btop` | `apk add btop`   | `nix-env -iA nixos.btop` | `emerge btop`      | `winget install aristocratos.btop` / `scoop install btop` / `choco install btop` | `pkg install btop` |
| Systemd        | Init/system manager           | Native/preinstalled           | `sudo apt install systemd`  | Included                    | Included             | `apk add openrc` (OpenRC alternative) | Included                | Included          | WSL/WSL2 (auto, see docs)     | `pkg install proot` (proot-distro for Termux) |
| Reflector      | Pacman mirror optimizer (Arch) | `sudo pacman -S reflector`    | `pip install rate-mirrors`  | `pip install rate-mirrors`  | `pip install rate-mirrors` | `pip install rate-mirrors` | `pip install rate-mirrors` | `pip install rate-mirrors` | `pip install rate-mirrors` | `pip install rate-mirrors` |
| Pkgtop         | TUI Package monitor           | `yay -S pkgtop` (AUR)         | `cargo install pkgtop`      | `cargo install pkgtop`      | `cargo install pkgtop` | `cargo install pkgtop` | `cargo install pkgtop` | `cargo install pkgtop` | `scoop install pkgtop`/`choco install pkgtop` | `pkg install pkgtop`   |
| Oh-my-posh     | Shell prompt theme engine     | `yay -S oh-my-posh-bin`       | `snap install oh-my-posh` (Snap, newer IoT) | `rpm -i oh-my-posh.rpm` (download from GitHub) | `curl -s https://ohmyposh.dev/install.sh | bash` | `curl -s https://ohmyposh.dev/install.sh | bash` | `curl -s https://ohmyposh.dev/install.sh | bash` | `curl -s https://ohmyposh.dev/install.sh | bash` | `winget install JanDeDobbeleer.OhMyPosh`/`scoop install oh-my-posh`/`choco install oh-my-posh` | `pkg install oh-my-posh` (if available) |
| CommandNotFound| Suggest missing apt packages  | N/A (not needed)              | `sudo apt install command-not-found` | `dnf install dnf-command-not-found` | `zypper install zypper-command-not-found` | `apk add command-not-found` | `nix-env -iA nixos.command-not-found` | `emerge command-not-found` | `scoop install command-not-found` | `pkg install command-not-found` |
| Pygmentize     | Syntax highlighter            | `sudo pacman -S python-pygments` | `sudo apt install python3-pygments` | `sudo dnf install python3-pygments` | `sudo zypper install python3-pygments` | `apk add py3-pygments` | `nix-env -iA nixos.python3.pkgs.pygments` | `emerge pygments` | `pip install Pygments`     | `pip install Pygments` |
| Yazi           | Modern terminal file manager  | `yay -S yazi`                 | `cargo install yazi-fm`     | `cargo install yazi-fm`     | `cargo install yazi-fm` | `cargo install yazi-fm` | `cargo install yazi-fm` | `cargo install yazi-fm` | `scoop install yazi`/`choco install yazi` | `pkg install yazi` |
| Tmatrix        | Matrix terminal animation     | `yay -S tmatrix`              |  `cargo install tmatrix`    | `cargo install tmatrix`     | `cargo install tmatrix`  | `cargo install tmatrix`| `cargo install tmatrix` | `cargo install tmatrix` | `scoop install tmatrix` | `pkg install tmatrix` |
| Powershell     | Windows shell & scripting      | `yay -S powershell`           | `sudo apt install powershell` | `sudo dnf install powershell` | `sudo zypper install powershell` | Manual | `nix-env -iA nixos.powershell` | `emerge powershell` | `winget install Microsoft.Powershell`/`scoop install powershell`/`choco install powershell` | N/A |
| Windows Terminal | Modern Windows terminal      | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | `winget install Microsoft.WindowsTerminal`/`scoop install windows-terminal`/`choco install microsoft-windows-terminal` | N/A |
| Gpg4win        | Windows GPG suite             | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | `winget install Gpg4win.Gpg4win`/`choco install gpg4win` | N/A |
| OneDrive       | Microsoft cloud storage        | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | Preinstalled/`winget install Microsoft.OneDrive` | N/A |
| Microsoft Edge | Chromium-based browser         | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | Preinstalled/`winget install Microsoft.Edge`/`scoop install microsoft-edge`/`choco install microsoft-edge` | N/A |
| Nilesoft Shell | Windows context menu shell     | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | `winget install Nilesoft.Shell`/`choco install nilesoft-shell` | N/A |
| Mica for Everyone | Window theming tool         | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | `winget install MicaForEveryone.MicaForEveryone`/`choco install mica-for-everyone` | N/A |
| Windhawk       | Windows modding platform       | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | `winget install Windhawk.Windhawk`/`choco install windhawk` | N/A |
| Nvidia PhysX   | Physics engine runtime         | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | `winget install Nvidia.PhysX` | N/A |
| NVCleanstall   | Nvidia driver customizer       | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | `winget install TechPowerUp.NVCleanstall` | N/A |
| Microsoft UI Xaml 2.7 | UI framework           | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | `winget install Microsoft.UI.Xaml.2.7` | N/A |
| Microsoft UI Xaml 2.8 | UI framework           | N/A                           | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | `winget install Microsoft.UI.Xaml.2.8` | N/A |
| Microsoft Visual C++ 2015 UWP Desktop Runtime Package | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2015UWPDesktopRuntimePackage` | N/A |
| Microsoft Visual C++ 2005 Redistributable (x64) | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2005Redistributable-x64` | N/A |
| Microsoft Visual C++ 2005 Redistributable (x86) | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2005Redistributable-x86` | N/A |
| Microsoft Visual C++ 2008 Redistributable - x64 | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2008Redistributable-x64` | N/A |
| Microsoft Visual C++ 2008 Redistributable - x86 | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2008Redistributable-x86` | N/A |
| Microsoft Visual C++ 2010 x64 Redistributable | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2010Redistributable-x64` | N/A |
| Microsoft Visual C++ 2010 x86 Redistributable | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2010Redistributable-x86` | N/A |
| Microsoft Visual C++ 2012 Redistributable (x64) | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2012Redistributable-x64` | N/A |
| Microsoft Visual C++ 2012 Redistributable (x86) | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2012Redistributable-x86` | N/A |
| Microsoft Visual C++ 2013 Redistributable (x64) | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2013Redistributable-x64` | N/A |
| Microsoft Visual C++ 2013 Redistributable (x86) | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2013Redistributable-x86` | N/A |
| Microsoft Visual C++ 2015-2022 Redistributable (x64) | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2015-2022Redistributable-x64` | N/A |
| Microsoft Visual C++ 2015-2022 Redistributable (x86) | VC++ runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.VC++2015-2022Redistributable-x86` | N/A |
| Microsoft .NET Windows Desktop Runtime 3.1 | .NET desktop runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.DesktopRuntime.3_1` | N/A |
| Microsoft .NET Windows Desktop Runtime 5.0 | .NET desktop runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.DesktopRuntime.5` | N/A |
| Microsoft .NET Windows Desktop Runtime 6.0 | .NET desktop runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.DesktopRuntime.6` | N/A |
| Microsoft .NET Windows Desktop Runtime 7.0 | .NET desktop runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.DesktopRuntime.7` | N/A |
| Microsoft .NET Windows Desktop Runtime 8.0 | .NET desktop runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.DesktopRuntime.8` | N/A |
| Microsoft .NET Windows Desktop Runtime 9.0 | .NET desktop runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.DesktopRuntime.9` | N/A |
| Microsoft .NET Runtime 3.1 | .NET runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.Runtime.3_1` | N/A |
| Microsoft .NET Runtime 5.0 | .NET runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.Runtime.5` | N/A |
| Microsoft .NET Runtime 6.0 | .NET runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.Runtime.6` | N/A |
| Microsoft .NET Runtime 7.0 | .NET runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.Runtime.7` | N/A |
| Microsoft .NET Runtime 8.0 | .NET runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.Runtime.8` | N/A |
| Microsoft .NET Runtime 9.0 | .NET runtime | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DotNet.Runtime.9` | N/A |
| EFI Boot Editor | EFI boot entry editor | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Hasleo.EFIBootEditor` | N/A |
| Microsoft AppInstaller | Windows app installer | N/A | N/A | N/A | N/A | N/A | N/A | N/A | `winget install Microsoft.DesktopAppInstaller` | N/A |
| Coreutils      | GNU core utilities            | `sudo pacman -S coreutils`              | `sudo apt install coreutils`  | `sudo dnf install coreutils`| `sudo zypper install coreutils` | `apk add coreutils` | `nix-env -iA nixos.coreutils` | `emerge coreutils` | `scoop install coreutils`/`choco install coreutils` | `pkg install coreutils` |
| Tree          | Directory visualizer           | `sudo pacman -S tree`                   | `sudo apt install tree`       | `sudo dnf install tree`     | `sudo zypper install tree` | `apk add tree`           | `nix-env -iA nixos.tree`      | `emerge tree`       | `scoop install tree`/`choco install tree` | `pkg install tree`     |
| Clang         | C/C++/ObjC compiler           | `sudo pacman -S clang`                  | `sudo apt install clang`      | `sudo dnf install clang`    | `sudo zypper install clang` | `apk add clang`          | `nix-env -iA nixos.clang`     | `emerge clang`      | `winget install LLVM.Clang`/`scoop install llvm`/`choco install llvm` | N/A |
| Make          | Build automation tool          | `sudo pacman -S make`                   | `sudo apt install make`       | `sudo dnf install make`     | `sudo zypper install make` | `apk add make`           | `nix-env -iA nixos.gnumake`   | `emerge make`       | `winget install GnuWin32.Make`/`scoop install make`/`choco install make` | N/A |
| Cmake         | Cross-platform build system    | `sudo pacman -S cmake`                  | `sudo apt install cmake`      | `sudo dnf install cmake`    | `sudo zypper install cmake` | `apk add cmake`          | `nix-env -iA nixos.cmake`     | `emerge cmake`      | `winget install Kitware.CMake`/`scoop install cmake`/`choco install cmake` | N/A |
| Termux-API    | Android terminal API bridge    | N/A                                    | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | N/A                                         | `pkg install termux-api` |
| Termux-exec   | Termux exec wrapper            | N/A                                    | N/A                          | N/A                        | N/A                      | N/A    | N/A                          | N/A                | N/A                                         | `pkg install termux-exec` |

\* Some zsh completions available as part of zsh-common or other packages
** On Debian/Ubuntu, may require Ruby (`gem install lolcat` if not in apt)

</details>

<details>
<summary><strong>📝 Editors & IDEs</strong></summary>

| Tool         | Description                      | Arch (Pacman/yay)        | Ubuntu/Debian (apt)      | Fedora/RHEL (dnf)    | openSUSE (zypper)    | Alpine (apk)            | NixOS (nix-env)           | Gentoo (emerge)     | Windows (winget/scoop/choco)                  | Android/Termux         |
|--------------|----------------------------------|--------------------------|--------------------------|----------------------|----------------------|--------------------------|---------------------------|---------------------|-----------------------------------------------|------------------------|
| Neovim       | Modern Vim-based editor          | `sudo pacman -S neovim`  | `sudo apt install neovim`| `sudo dnf install neovim`| `sudo zypper install neovim` | `apk add neovim`  | `nix-env -iA nixos.neovim` | `emerge neovim`    | `winget install Neovim.Neovim`/`scoop install neovim`/`choco install neovim`      | `pkg install neovim`   |
| Vim          | Classic modal editor             | `sudo pacman -S vim`     | `sudo apt install vim`   | `sudo dnf install vim`   | `sudo zypper install vim` | `apk add vim`       | `nix-env -iA nixos.vim`   | `emerge vim`       | `winget install Vim.Vim`/`scoop install vim`/`choco install vim`                | `pkg install vim`      |
| LunarVim     | Neovim IDE config               | `yay -S lunarvim`        | `bash <(curl ... installer)`| Manual             | Manual               | Manual                   | Manual                   | Manual              | [GitHub](https://github.com/LunarVim/LunarVim) installer                        | Manual                 |
| Emacs        | Programmable text editor         | `sudo pacman -S emacs`   | `sudo apt install emacs` | `sudo dnf install emacs`| `sudo zypper install emacs` | `apk add emacs`     | `nix-env -iA nixos.emacs` | `emerge emacs`     | `winget install GNU.Emacs`/`scoop install emacs`/`choco install emacs`          | `pkg install emacs`    |
| Helix        | Modal code editor                | `sudo pacman -S helix`   | `sudo apt install helix` | `sudo dnf install helix`| `sudo zypper install helix` | `apk add helix`     | `nix-env -iA nixos.helix` | `emerge helix`     | `winget install Helix.Helix`/`scoop install helix`/`choco install helix`        | Manual                 |
| Kakoune      | Modal code editor, vi inspired   | `sudo pacman -S kakoune` | `sudo apt install kakoune`| `sudo dnf install kakoune`| `sudo zypper install kakoune` | `apk add kakoune` | `nix-env -iA nixos.kakoune`| `emerge kakoune`   | `winget install Kakoune.Kakoune`/`scoop install kakoune`                        | Manual                 |
| Micro        | Modern terminal editor           | `sudo pacman -S micro`   | `sudo apt install micro` | `sudo dnf install micro`| `sudo zypper install micro` | `apk add micro`     | `nix-env -iA nixos.micro` | `emerge micro`     | `winget install zyedidia.micro`/`scoop install micro`/`choco install micro`     | `pkg install micro`    |
| Codium/VSCodium  | FOSS VSCode                  | `yay -S vscodium-bin`    | Download .deb           | Download .rpm         | Download .rpm         | Manual                   | `nix-env -iA nixos.vscodium` | Manual           | `winget install VSCodium.VSCodium`/`scoop install vscodium`/`choco install vscodium` | Manual                 |
| Kate         | KDE code editor                  | `sudo pacman -S kate`    | `sudo apt install kate` | `sudo dnf install kate`| `sudo zypper install kate` | `apk add kate`      | `nix-env -iA nixos.kate`  | `emerge kate`      | `winget install KDE.Kate`/`scoop install kate`                                  | Manual                 |
| Sublime Text | Proprietary editor (shareware)   | `yay -S sublime-text-4`| Manual (download)       | Manual (download)      | Manual (download)      | Manual                   | Manual                  | Manual             | `winget install SublimeHQ.SublimeText.4`/`choco install sublimetext`            | Manual                 |
| Geany        | Lightweight IDE/editor           | `sudo pacman -S geany`   | `sudo apt install geany`| `sudo dnf install geany`| `sudo zypper install geany` | `apk add geany`      | `nix-env -iA nixos.geany` | `emerge geany`     | `winget install Geany.Geany`                                                 | Manual                 |
| Nano         | Tiny terminal editor             | `sudo pacman -S nano`    | `sudo apt install nano` | `sudo dnf install nano`| `sudo zypper install nano` | `apk add nano`       | `nix-env -iA nixos.nano`  | `emerge nano`      | `winget install GNU.nano`/`scoop install nano`/`choco install nano`             | `pkg install nano`     |
| Glow         | Markdown TUI viewer/editor       | `yay -S glow`            | `sudo apt install glow` | `sudo dnf install glow`| Manual                 | `apk add glow`         | `nix-env -iA nixos.glow`  | Manual             | `winget install Charm.Glow`/`scoop install glow`/`choco install glow`           | `pkg install glow`     |
| Neovide      | Neovim GUI                       | `yay -S neovide`         | `sudo apt install neovide`| Manual              | Manual                 | Manual                   | `nix-env -iA nixos.neovide`| Manual            | `winget install Neovide.Neovide`/`scoop install neovide`/`choco install neovide`| Manual                 |
| Doom Emacs    | Emacs config framework  | `git clone https://github.com/hlissner/doom-emacs ~/.emacs.d && ~/.emacs.d/bin/doom install` | Same manual install | Same   | Same              | Same                   | Same             | Same            | N/A                               | N/A               |
| Lazygit       | Terminal git frontend   | `sudo pacman -S lazygit` | `sudo apt install lazygit` | `sudo dnf install lazygit` | `sudo zypper install lazygit` | `apk add lazygit` | `nix-env -iA nixos.lazygit` | `emerge lazygit` | `winget install JesseDuffield.Lazygit` / `scoop install lazygit` | N/A |
| Nb-preview    | Markdown/Notebook preview (TUI) | `yay -S nb`            | `pip install nbpreview`| `pip install nbpreview`| `pip install nbpreview`| `pip install nb`          | `nix-env -iA nixos.nb` | `pip install nb` | `pip install nbpreview`           | `pip install nbpreview` |
| Obsidian      | Markdown knowledge base / PKM    | Manual                  | Manual                 | Manual                 | Manual                 | Manual                   | Manual                   | Manual              | `winget install Obsidian.Obsidian`/`scoop install obsidian`/`choco install obsidian` | Manual |

</details>

<details>
<summary><strong>📦 Package Managers</strong></summary>

| Tool         | Description                  | Arch (Pacman/yay)          | Ubuntu/Debian (apt)     | Fedora/RHEL (dnf/yum)    | openSUSE (zypper)      | Alpine (apk)       | NixOS (nix-env)           | Gentoo (emerge)   | Windows (winget/scoop/choco)                             | Android/Termux         |
|--------------|-----------------------------|----------------------------|-------------------------|--------------------------|------------------------|---------------------|---------------------------|-------------------|----------------------------------------------------------|------------------------|
| Pacman       | Arch pkg manager (native)   | native                     | N/A                    | N/A                     | N/A                   | N/A                | N/A                      | N/A               | N/A                                                     | N/A                   |
| Yay          | AUR helper (Arch)           | `yay -S yay` or build      | `N/A`                  | N/A                     | N/A                   | N/A                | N/A                      | N/A               | N/A                                                     | N/A                   |
| Apt          | Debian pkg manager          | N/A                        | preinstalled           | N/A                     | N/A                   | N/A                | N/A                      | N/A               | N/A                                                     | N/A                   |
| Dpkg         | Debian low-level pkg mgr    | N/A                        | preinstalled           | N/A                     | N/A                   | N/A                | N/A                      | N/A               | N/A                                                     | N/A                   |
| Dnf          | Fedora pkg manager          | N/A                        | N/A                    | preinstalled            | N/A                   | N/A                | N/A                      | N/A               | N/A                                                     | N/A                   |
| Yum          | Old Fedora/pkg manager      | N/A                        | N/A                    | `sudo dnf install yum`  | N/A                   | N/A                | N/A                      | N/A               | N/A                                                     | N/A                   |
| Zypper       | openSUSE pkg manager        | N/A                        | N/A                    | N/A                     | preinstalled          | N/A                | N/A                      | N/A               | N/A                                                     | N/A                   |
| Apk          | Alpine pkg manager          | N/A                        | N/A                    | N/A                     | N/A                   | preinstalled       | N/A                      | N/A               | N/A                                                     | N/A                   |
| Nix          | Universal (declarative)     | `yay -S nix`               | `sudo apt install nix` | `sudo dnf install nix`  | `sudo zypper install nix` | `apk add nix`     | preinstalled             | `emerge nix`      | Manual ([nixos.org](https://nixos.org/download.html))    | N/A                   |
| Portage      | Gentoo pkg manager          | N/A                        | N/A                    | N/A                     | N/A                   | N/A                | N/A                      | preinstalled      | N/A                                                     | N/A                   |
| Flatpak      | Sandboxed package mgr       | `sudo pacman -S flatpak`   | `sudo apt install flatpak`| `sudo dnf install flatpak`| `sudo zypper install flatpak` | `apk add flatpak` | `nix-env -iA nixos.flatpak` | Manual           | `winget install Flatpak.Flatpak` (in preview)[¹]        | N/A                   |
| Snap         | Canonical container mgr     | `sudo pacman -S snapd`     | `sudo apt install snapd`| `sudo dnf install snapd`| `sudo zypper install snapd` | `apk add snapd`  | manual                   | manual            | `winget install Canonical.Snapcraft` (in preview)[²]    | `pkg install snap`     |
| Homebrew     | Crossplatform, mac/linux    | `yay -S linuxbrew`         | `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"` | `dnf install brew`* | N/A                   | `apk add brew`* | manual                   | manual            | Manual ([brew.sh](https://brew.sh/))                    | N/A                   |
| Chocolatey   | Windows package manager     | N/A                        | N/A                    | N/A                     | N/A                   | N/A                | N/A                      | N/A               | `choco install <pkg>` (see [choco docs](https://chocolatey.org/install)) | N/A         |
| Scoop        | Windows package manager     | N/A                        | N/A                    | N/A                     | N/A                   | N/A                | N/A                      | N/A               | `scoop install <pkg>` ([scoop docs](https://scoop.sh/)) | N/A                   |
| Pip          | Python package manager      | `sudo pacman -S python-pip`| `sudo apt install python3-pip`| `sudo dnf install python3-pip`| `sudo zypper install python3-pip` | `apk add py3-pip`| `nix-env -iA nixos.python3.pkgs.pip` | `emerge pip`    | `winget install Python.Python.3.14`/`scoop install python`/`choco install python` | `pkg install python`   |
| Pipx         | Python isolated script run  | `sudo pacman -S pipx`      | `sudo apt install pipx` | `sudo dnf install pipx` | `sudo zypper install pipx` | `pip install pipx`| `nix-env -iA nixos.pipx`        | `emerge pipx`    | `choco install pipx`                                      | `pip install pipx`     |
| Pipenv       | Python dependency manager   | `sudo pacman -S pipenv`    | `sudo apt install pipenv`| `sudo dnf install pipenv`| `sudo zypper install pipenv`| `pip install pipenv`| `nix-env -iA nixos.pipenv`| `emerge pipenv`    | `choco install pipenv`/`pipx install pipenv`              | `pip install pipenv`   |
| Cargo        | Rust package manager        | `sudo pacman -S cargo`     | `sudo apt install cargo`| `sudo dnf install cargo`| `sudo zypper install cargo`| `apk add cargo`        | `nix-env -iA nixos.cargo`      | `emerge cargo`    | `winget install Rustlang.Rustup`/`scoop install rustup`/`choco install rust` | `pkg install rust`     |
| Ruby Gems     | Ruby package manager        | `sudo pacman -S ruby`      | `sudo apt install ruby` | `sudo dnf install ruby` | `sudo zypper install ruby` | `apk add ruby`         | `nix-env -iA nixos.ruby`       | `emerge ruby`     | `winget install RubyInstallerTeam.Ruby`/`choco install ruby`      | `pkg install ruby`     |
| Npm          | Node package manager        | `sudo pacman -S npm`       | `sudo apt install npm`  | `sudo dnf install npm`  | `sudo zypper install npm`  | `apk add npm`          | `nix-env -iA nixos.nodejs`     | `emerge npm`      | `winget install OpenJS.NodeJS.LTS`/`scoop install nodejs-lts`/`choco install nodejs-lts` | `pkg install nodejs`  |
| Pnpm         | Fast node pkg manager       | `sudo pacman -S pnpm`/`npm i -g pnpm` | `sudo apt install pnpm`/`npm i -g pnpm` | `sudo dnf install pnpm`/`npm i -g pnpm` | `sudo zypper install pnpm`/`npm i -g pnpm` | `npm install -g pnpm` | `nix-env -iA nixos.nodePackages.pnpm` | `emerge pnpm`  | `winget install pnpm.pnpm`/`scoop install pnpm`             | `npm install -g pnpm` |
| Perl         | Perl/CPAN package manager   | `sudo pacman -S perl`      | `sudo apt install perl` | `sudo dnf install perl` | `sudo zypper install perl` | `apk add perl`         | `nix-env -iA nixos.perl`        | `emerge perl`     | `winget install StrawberryPerl.StrawberryPerl`/`choco install strawberryperl` | `pkg install perl`     |
| NuGet        | .NET package manager        | `sudo pacman -S nuget`     | `sudo apt install nuget` | `sudo dnf install nuget` | `sudo zypper install nuget` | Manual                | `nix-env -iA nixos.nuget`       | `emerge nuget`    | `winget install NuGet.NuGet`/`choco install nuget.commandline` | Manual                 |

[¹] `winget install Flatpak.Flatpak` is in preview, not yet default on Windows  
[²] Snapcraft, for snap builds, not for running snaps on Windows—see official docs for future progress  
\* Homebrew for Fedora, Alpine—use Linuxbrew/homebrew-core, but it’s not a core package in repos.

</details>

<details>
<summary><strong>🎨 Desktop, Audio & Misc Tools</strong></summary>

| Tool         | Description                        | Arch (Pacman/yay)          | Ubuntu/Debian (apt)       | Fedora/RHEL (dnf)    | openSUSE (zypper)    | Alpine (apk)           | NixOS (nix-env)            | Gentoo (emerge)      | Windows (winget/scoop/choco)                       | Android/Termux         |
|--------------|------------------------------------|----------------------------|---------------------------|----------------------|----------------------|-------------------------|----------------------------|----------------------|----------------------------------------------------|------------------------|
| Hyprland     | Wayland compositor                 | `yay -S hyprland`          | Manual (build)            | Manual (build)       | Manual (build)       | Manual                  | `nix-env -iA nixos.hyprland`    | Manual              | N/A                                               | N/A                   |
| Hypridle     | Idle daemon for Hyprland           | `yay -S hypridle`          | Manual (build)            | Manual (build)       | Manual (build)       | Manual                  | Manual                        | Manual              | N/A                                               | N/A                   |
| Hyprpicker   | Color picker for Hyprland          | `yay -S hyprpicker`        | Cargo                     | Cargo                | Cargo                | Cargo                   | Cargo                         | Manual              | N/A                                               | N/A                   |
| Hyprplugins  | Plugins for Hyprland               | `yay -S hyprland-plugins`  | Manual                    | Manual               | Manual               | Manual                  | Manual                        | Manual              | N/A                                               | N/A                   |
| Hyprshot     | Screenshot tool for Hyprland       | `yay -S hyprshot`          | Cargo                     | Cargo                | Cargo                | Cargo                   | Cargo                         | Cargo               | N/A                                               | N/A                   |
| Fuzzel       | Wayland launcher                   | `yay -S fuzzel`            | Cargo                     | Cargo                | Cargo                | Cargo                   | `nix-env -iA nixos.fuzzel`         | Cargo               | N/A                                               | N/A                   |
| Cliphist     | Clipboard history (Wayland)        | `yay -S cliphist`          | Cargo                     | Cargo                | Cargo                | Cargo                   | Cargo                         | Cargo               | N/A                                               | N/A                   |
| Wl-clipboard | Wayland clipboard utils (wl-copy/paste) | `sudo pacman -S wl-clipboard` | `sudo apt install wl-clipboard` | `sudo dnf install wl-clipboard` | `sudo zypper install wl-clipboard` | Manual | `nix-env -iA nixos.wl-clipboard` | `emerge wl-clipboard` | Manual | N/A |
| Swww         | Wallpaper daemon for Wayland       | `yay -S swww`              | Cargo                     | Cargo                | Cargo                | Cargo                   | Cargo                         | Cargo               | N/A                                               | N/A                   |
| Kitty        | GPU terminal emulator              | `sudo pacman -S kitty`     | `sudo apt install kitty`  | `sudo dnf install kitty` | `sudo zypper install kitty` | `apk add kitty`          | `nix-env -iA nixos.kitty`      | `emerge kitty`      | `winget install kovidgoyal.kitty`/`scoop install kitty` | Manual                |
| Ghostty      | Fast terminal emulator             | `yay -S ghostty`           | Cargo                     | Cargo                | Cargo                | Cargo                   | Cargo                         | Cargo               | `winget install Ghostty.Ghostty`                    | Manual                |
| Playerctl    | Media player controller (MPRIS)    | `sudo pacman -S playerctl` | `sudo apt install playerctl` | `sudo dnf install playerctl` | `sudo zypper install playerctl` | `apk add playerctl`    | `nix-env -iA nixos.playerctl`   | `emerge playerctl`  | Manual                                              | Manual                |
| Cava         | Audio spectrum visualizer (TUI)    | `yay -S cava`              | `sudo apt install cava`   | `sudo dnf install cava` | Manual                | Manual                  | `nix-env -iA nixos.cava`         | `emerge cava`       | Manual                                              | Manual                |
| JamesDSP     | Audio effects daemon (Wayland)     | `yay -S jamesdsp`          | Manual                    | Manual               | Manual               | Manual                  | Manual                        | Manual              | N/A                                               | N/A                   |
| Wireplumber  | PipeWire audio control tool        | `sudo pacman -S wireplumber`| Manual                   | Manual               | Manual               | Manual                  | Manual                        | Manual              | N/A                                               | Manual                |
| Wayland/Weston | Linux reference compositor       | `sudo pacman -S weston`    | `sudo apt install weston` | `sudo dnf install weston`| `sudo zypper install weston` | `apk add weston`    | `nix-env -iA nixos.weston`         | `emerge weston`     | Manual                                              | N/A                   |
| Qt5ct        | Qt5 theme config utility           | `sudo pacman -S qt5ct`     | `sudo apt install qt5ct`  | `sudo dnf install qt5ct` | `sudo zypper install qt5ct` | `apk add qt5ct`          | `nix-env -iA nixos.qt5ct`       | `emerge qt5ct`      | Manual                                              | N/A                   |
| Flatpak      | Universal app format               | `sudo pacman -S flatpak`   | `sudo apt install flatpak`| `sudo dnf install flatpak` | `sudo zypper install flatpak` | `apk add flatpak` | `nix-env -iA nixos.flatpak`     | Manual              | `winget install Flatpak.Flatpak` (preview)           | N/A                   |
| Dino         | Modern XMPP desktop chat           | `sudo pacman -S dino`      | `sudo apt install dino-im`| `sudo dnf install dino` | `sudo zypper install dino` | `apk add dino`             | `nix-env -iA nixos.dino`       | `emerge dino`       | Manual                                              | N/A                   |
| Rclone       | Cloud storage sync                 | `sudo pacman -S rclone`    | `sudo apt install rclone` | `sudo dnf install rclone` | `sudo zypper install rclone` | `apk add rclone`          | `nix-env -iA nixos.rclone`     | `emerge rclone`     | `winget install rclone.rclone`/`scoop install rclone`/`choco install rclone` | `pkg install rclone`  |
| Steam        | Popular game launcher              | `sudo pacman -S steam`     | `sudo apt install steam`  | `sudo dnf install steam` | `sudo zypper install steam` | Manual                      | `nix-env -iA nixos.steam`      | Manual              | `winget install Valve.Steam`/`scoop install steam`/`choco install steam` | N/A             |
| VSCodium     | OSS Visual Studio Code             | `yay -S vscodium-bin`      | Download .deb            | Download .rpm           | Download .rpm           | Manual                  | `nix-env -iA nixos.vscodium`    | Manual              | `winget install VSCodium.VSCodium`/`scoop install vscodium`/`choco install vscodium` | Manual          |
| Spicetify    | Spotify theming tool               | `yay -S spicetify-cli`     | Manual (`npm`/GitHub)    | Manual (`npm`/GitHub)    | Manual                  | Manual                  | Manual                        | Manual              | `winget install Spicetify.SpicetifyCli`/`scoop install spicetify-cli`/`choco install spicetify-cli` | Manual |
| Kwinrc       | KWin config utility (KDE)          | Part of KDE                | Part of KDE              | Part of KDE              | Part of KDE             | N/A                     | Manual                        | Manual              | N/A                                               | N/A                   |
| Exifaudio    | Audio file metadata tool           | `yay -S exifaudio`         | `pip install exifaudio`  | `pip install exifaudio`   | `pip install exifaudio` | `pip install exifaudio` | `pip install exifaudio`        | `pip install exifaudio` | N/A                                         | `pip install exifaudio`   |
| Ouch         | Multi-format archiver (cli)        | `yay -S ouch`              | `cargo install ouch`     | `cargo install ouch`      | `cargo install ouch`    | `cargo install ouch`    | `cargo install ouch`           | `cargo install ouch` | N/A                                               | N/A                   |
| DuckDB       | Embeddable database (CLI/SQL)      | `yay -S duckdb`            | `sudo apt install duckdb`| `sudo dnf install duckdb` | Cargo/manual             | Cargo/manual            | `nix-env -iA nixos.duckdb`      | Manual              | `winget install DuckDB.DuckDB`/`scoop install duckdb`          | `pip install duckdb`    |
| Fastfetch    | System info (neofetch alt)         | `yay -S fastfetch`         | `sudo apt install fastfetch` | `sudo dnf install fastfetch` | Manual            | `apk add fastfetch`    | `nix-env -iA nixos.fastfetch`   | Manual              | `winget install Fastfetch.Fastfetch`/`scoop install fastfetch`/`choco install fastfetch` | N/A |
| Nb-preview   | Notebook/Markdown previewer (TUI)  | `yay -S nb`                | `pip install nbpreview`  | `pip install nbpreview`   | `pip install nbpreview` | `pip install nb`         | `nix-env -iA nixos.nb`         | `pip install nb`    | `pip install nbpreview`                                | `pip install nbpreview` |
| Bat          | Cat with syntax highlighting       | `sudo pacman -S bat`       | `sudo apt install bat`   | `sudo dnf install bat`    | `sudo zypper install bat` | `apk add bat`          | `nix-env -iA nixos.bat`         | `emerge bat`        | `winget install sharkdp.bat`/`scoop install bat`/`choco install bat` | `pkg install bat`      |
| Ascii-image-converter | CLI image→ascii art           | `yay -S ascii-image-converter` | `snap install ascii-image-converter` \| [GitHub releases](https://github.com/TheZoraiz/ascii-image-converter/releases) | Manual / build from [GitHub] | Manual           | Manual        | Manual            | Manual              | `choco install ascii-image-converter` (community) | Manual            |
| Rmpc             | Terminal MPD client                | `yay -S rmpc`             | [GitHub binary](https://mierak.github.io/rmpc/) | Manual              | `sudo zypper install rmpc` (Tumbleweed) | `apk add rmpc`  | `nix-env -iA nixos.rmpc` | Manual           | N/A                     | N/A                |
| Tmuxinator       | Tmux session manager (Ruby)        | `gem install tmuxinator`  | `gem install tmuxinator`| `gem install tmuxinator`| `gem install tmuxinator`| `gem install tmuxinator` | `gem install tmuxinator` | `gem install tmuxinator` | N/A                | N/A                |
| Yt-dlp           | Video downloader (youtube-dl alt)  | `sudo pacman -S yt-dlp`   | `sudo apt install yt-dlp`| `sudo dnf install yt-dlp`| `sudo zypper install yt-dlp` | Manual        | `nix-env -iA nixos.yt-dlp` | `emerge yt-dlp`  | `winget install yt-dlp.yt-dlp` / `scoop install yt-dlp` / `choco install yt-dlp` | `pip install yt-dlp` |
| Navi             | Interactive cheatsheets            | `yay -S navi`             | `cargo install navi`  | `cargo install navi`| `cargo install navi`| `cargo install navi` | `cargo install navi` | `cargo install navi` | `scoop install navi`          | N/A                |
| Swww             | Wayland wallpaper daemon           | `yay -S swww`             | `cargo install swww`  | `cargo install swww`| `cargo install swww`| `cargo install swww` | `cargo install swww` | `cargo install swww` | N/A                     | N/A                |
| Tmatrix          | Matrix terminal animation            | `yay -S tmatrix`         | `cargo install tmatrix` | `cargo install tmatrix`| `cargo install tmatrix`| `cargo install tmatrix` | `cargo install tmatrix`| `cargo install tmatrix` | N/A                | N/A                |
| 7zip             | File archiver/compression tool       | `sudo pacman -S p7zip`   | `sudo apt install p7zip-full` | `sudo dnf install p7zip` | `sudo zypper install p7zip` | `apk add p7zip` | `nix-env -iA nixos.p7zip` | `emerge p7zip` | `winget install 7zip.7zip`/`scoop install 7zip`/`choco install 7zip` | Manual |
| Oh-my-posh       | Prompt theme engine (shells)         | Manual                   | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | `winget install JanDeDobbeleer.OhMyPosh`/`scoop install oh-my-posh`/`choco install oh-my-posh` | Manual |
| Spicetify        | Spotify client theming tool          | Manual                   | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | `winget install spicetify-cli.spicetify-cli`/`scoop install spicetify-cli` | Manual |
| Rainmeter        | Desktop customization (Windows)      | N/A                      | N/A                     | N/A                     | N/A                     | N/A                     | N/A                     | N/A                     | `winget install Rainmeter.Rainmeter`/`scoop install rainmeter`/`choco install rainmeter` | N/A |
| Qbittorrent      | BitTorrent client                    | `sudo pacman -S qbittorrent` | `sudo apt install qbittorrent` | `sudo dnf install qbittorrent` | `sudo zypper install qbittorrent` | `apk add qbittorrent` | `nix-env -iA nixos.qbittorrent` | `emerge qbittorrent` | `winget install qBittorrent.qBittorrent`/`scoop install qbittorrent`/`choco install qbittorrent` | Manual |
| OneDrive         | Cloud storage client                 | `yay -S onedrive-abraunegg` | `sudo apt install onedrive` | Manual                  | Manual                  | Manual                  | `nix-env -iA nixos.onedrive` | Manual                  | Native (Windows) / `winget install Microsoft.OneDrive` | Manual |
| ProtonVPN        | VPN client                           | Manual                   | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | `winget install ProtonVPN.ProtonVPN`/`scoop install protonvpn` | Manual |
| EarthPro         | Google Earth Pro                     | Manual                   | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | `winget install Google.EarthPro`/`scoop install google-earth-pro` | Manual |
| 8Gadget Pack     | Desktop gadgets (Windows)            | N/A                      | N/A                     | N/A                     | N/A                     | N/A                     | N/A                     | N/A                     | `winget install 8GadgetPack.8GadgetPack`/`choco install 8gadgetpack` | N/A |
| ASIO4ALL         | Audio driver (Windows)               | N/A                      | N/A                     | N/A                     | N/A                     | N/A                     | N/A                     | N/A                     | `winget install ASIO4ALL.ASIO4ALL`/`choco install asio4all` | N/A |
| Adobe Creative Cloud | Adobe suite launcher              | Manual                   | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | `winget install Adobe.AdobeCreativeCloud`/`choco install adobecreativecloud` | Manual |
| Zen Browser      | Minimalist web browser (Windows)     | N/A                      | N/A                     | N/A                     | N/A                     | N/A                     | N/A                     | N/A                     | Manual | N/A |
| Google Drive     | Cloud storage client                 | Manual                   | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | Manual                  | `winget install Google.Drive`/`scoop install google-drive`/`choco install googledrive` | Manual |

</details>

<details>
<summary><strong>🎮 Gaming and Multimedia Tools</strong></summary>

| Tool               | Description                        | Arch (Pacman/yay)          | Ubuntu/Debian (apt)       | Fedora/RHEL (dnf)    | openSUSE (zypper)    | Alpine (apk)           | NixOS (nix-env)            | Gentoo (emerge)      | Windows (winget/scoop/choco)                       | Android/Termux         |
|--------------------|------------------------------------|----------------------------|---------------------------|----------------------|----------------------|-------------------------|----------------------------|----------------------|----------------------------------------------------|------------------------|
| RetroArch          | Emulator frontend                  | `sudo pacman -S retroarch` | `sudo apt install retroarch` | `sudo dnf install retroarch` | `sudo zypper install retroarch` | `apk add retroarch` | `nix-env -iA nixos.retroarch` | `emerge retroarch` | `winget install Libretro.RetroArch`/`scoop install retroarch`/`choco install retroarch` | Manual |
| Discord            | Gaming/voice chat client           | `yay -S discord`           | `sudo apt install discord` | `sudo dnf install discord` | `sudo zypper install discord` | `flatpak install flathub com.discordapp.Discord` | `nix-env -iA nixos.discord` | `emerge discord` | `winget install Discord.Discord`/`scoop install discord`/`choco install discord` | Manual |
| EA Desktop         | EA game launcher                   | Manual                     | Manual                    | Manual                | Manual                | Manual                  | Manual                    | Manual                | `winget install ElectronicArts.EADesktop`/`scoop install ea-app` | Manual |
| Steam              | Game distribution platform         | `sudo pacman -S steam`     | `sudo apt install steam`  | `sudo dnf install steam` | `sudo zypper install steam` | `flatpak install flathub com.valvesoftware.Steam` | `nix-env -iA nixos.steam` | `emerge steam` | `winget install Valve.Steam`/`scoop install steam`/`choco install steam` | Manual |
| Epic Games Launcher| Game launcher/store                | `flatpak install flathub com.heroicgameslauncher.hgl` | `flatpak install flathub com.heroicgameslauncher.hgl` | `flatpak install flathub com.heroicgameslauncher.hgl` | `flatpak install flathub com.heroicgameslauncher.hgl` | `flatpak install flathub com.heroicgameslauncher.hgl` | `flatpak install flathub com.heroicgameslauncher.hgl` | `flatpak install flathub com.heroicgameslauncher.hgl` | `winget install EpicGames.EpicGamesLauncher`/`scoop install epic-games-launcher` | Manual |
| Xemu               | Xbox emulator                      | `yay -S xemu`              | `flatpak install flathub app.xemu.xemu` | `flatpak install flathub app.xemu.xemu` | `flatpak install flathub app.xemu.xemu` | `flatpak install flathub app.xemu.xemu` | `nix-env -iA nixos.xemu`   | Manual                | `winget install xemu-project.xemu`/`scoop install xemu` | Manual |
| Playnite           | Game library manager               | `flatpak install flathub com.playnite.Playnite` | `flatpak install flathub com.playnite.Playnite` | `flatpak install flathub com.playnite.Playnite` | `flatpak install flathub com.playnite.Playnite` | `flatpak install flathub com.playnite.Playnite` | `flatpak install flathub com.playnite.Playnite` | `flatpak install flathub com.playnite.Playnite` | `winget install Playnite.Playnite`/`scoop install playnite`/`choco install playnite` | Manual |
| Prism Launcher     | Minecraft launcher (multi-platform)| `yay -S prismlauncher`     | `sudo apt install prismlauncher` | `sudo dnf install prismlauncher` | `sudo zypper install prismlauncher` | `flatpak install flathub org.prismlauncher.PrismLauncher` | `nix-env -iA nixos.prismlauncher` | `emerge prismlauncher` | `winget install PrismLauncher.PrismLauncher`/`scoop install prismlauncher` | Manual |
| ArchiSteamFarm     | Steam farming bot                  | `dotnet tool install --global ArchiSteamFarm` | `dotnet tool install --global ArchiSteamFarm` | `dotnet tool install --global ArchiSteamFarm` | `dotnet tool install --global ArchiSteamFarm` | `dotnet tool install --global ArchiSteamFarm` | `dotnet tool install --global ArchiSteamFarm` | `dotnet tool install --global ArchiSteamFarm` | `winget install JustArchi.ArchiSteamFarm`/`scoop install archisteamfarm` | Manual |
| NVCleanstall       | NVIDIA driver customizer           | Manual                     | Manual                    | Manual                | Manual                | Manual                  | Manual                    | Manual                | `winget install TechPowerUp.NVCleanstall`/`choco install nvcleanstall` | Manual |

</details>

<details>
<summary><strong>🧑‍💻 Programming and Power-user Tools</strong></summary>

| Tool                   | Description                              | Arch (Pacman/yay)          | Ubuntu/Debian (apt)       | Fedora/RHEL (dnf)    | openSUSE (zypper)    | Alpine (apk)           | NixOS (nix-env)            | Gentoo (emerge)      | Windows (winget/scoop/choco)                       | Android/Termux         |
|------------------------|------------------------------------------|----------------------------|---------------------------|----------------------|----------------------|-------------------------|----------------------------|----------------------|----------------------------------------------------|------------------------|
| Powershell             | Cross-platform shell                     | `sudo pacman -S powershell`| `sudo apt install powershell` | `sudo dnf install powershell` | `sudo zypper install powershell` | Manual | `nix-env -iA nixos.powershell` | `emerge powershell` | `winget install Microsoft.Powershell`/`scoop install powershell`/`choco install powershell` | `pkg install powershell` |
| Windows Terminal       | Modern terminal emulator (Windows)       | `flatpak install flathub com.microsoft.WindowsTerminal` | `flatpak install flathub com.microsoft.WindowsTerminal` | `flatpak install flathub com.microsoft.WindowsTerminal` | `flatpak install flathub com.microsoft.WindowsTerminal` | N/A | N/A | N/A | `winget install Microsoft.WindowsTerminal`/`scoop install windows-terminal`/`choco install microsoft-windows-terminal` | N/A |
| Terminal Icons         | Terminal icon theme                      | Manual                     | Manual                   | Manual              | Manual              | Manual                 | Manual                    | Manual              | `winget install devblackops.terminal-icons`/`scoop install terminal-icons` | Manual |
| 7zip                   | File archiver/compression tool           | `sudo pacman -S p7zip`     | `sudo apt install p7zip-full` | `sudo dnf install p7zip` | `sudo zypper install p7zip` | `apk add p7zip` | `nix-env -iA nixos.p7zip` | `emerge p7zip` | `winget install 7zip.7zip`/`scoop install 7zip`/`choco install 7zip` | `pkg install p7zip` |
| Github CLI             | GitHub command-line tool                 | `sudo pacman -S github-cli`| `sudo apt install gh`    | `sudo dnf install gh`| `sudo zypper install gh` | `apk add gh` | `nix-env -iA nixos.gh` | `emerge gh` | `winget install GitHub.cli`/`scoop install gh`/`choco install gh` | `pkg install gh` |
| Git Extensions         | Git GUI extension                        | Manual                     | Manual                   | Manual              | Manual              | Manual                 | Manual                    | Manual              | `winget install GitExtensionsTeam.GitExtensions`/`choco install gitextensions` | Manual |
| Docker Desktop         | Container management (Windows/macOS)     | `yay -S docker-desktop-bin` | `brew install --cask docker` | `brew install --cask docker` | `brew install --cask docker` | Manual | Manual | Manual | `winget install Docker.DockerDesktop`/`scoop install docker-desktop`/`choco install docker-desktop` | Manual |
| Fzf                    | Fuzzy finder for terminal                | `sudo pacman -S fzf`       | `sudo apt install fzf`   | `sudo dnf install fzf` | `sudo zypper install fzf` | `apk add fzf` | `nix-env -iA nixos.fzf` | `emerge fzf` | `winget install junegunn.fzf`/`scoop install fzf`/`choco install fzf` | `pkg install fzf` |
| Fastfetch              | System info fetcher                      | `sudo pacman -S fastfetch` | `sudo apt install fastfetch` | `sudo dnf install fastfetch` | `sudo zypper install fastfetch` | `apk add fastfetch` | `nix-env -iA nixos.fastfetch` | `emerge fastfetch` | `winget install fastfetch.cli`/`scoop install fastfetch` | Manual |
| Oh-my-posh             | Prompt theme engine (shells)             | Manual                     | Manual                   | Manual              | Manual              | Manual                 | Manual                    | Manual              | `winget install JanDeDobbeleer.OhMyPosh`/`scoop install oh-my-posh`/`choco install oh-my-posh` | Manual |
| Gpg4win                | GPG suite for Windows                    | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install Gpg4win.Gpg4win`/`choco install gpg4win` | N/A |
| Spicetify              | Spotify client theming tool              | Manual                     | Manual                   | Manual              | Manual              | Manual                 | Manual                    | Manual              | `winget install spicetify-cli.spicetify-cli`/`scoop install spicetify-cli` | Manual |
| Rainmeter              | Desktop customization (Windows)          | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install Rainmeter.Rainmeter`/`scoop install rainmeter`/`choco install rainmeter` | N/A |
| Qbittorrent            | BitTorrent client                        | `sudo pacman -S qbittorrent` | `sudo apt install qbittorrent` | `sudo dnf install qbittorrent` | `sudo zypper install qbittorrent` | `apk add qbittorrent` | `nix-env -iA nixos.qbittorrent` | `emerge qbittorrent` | `winget install qBittorrent.qBittorrent`/`scoop install qbittorrent`/`choco install qbittorrent` | Manual |
| Everything search      | File search utility (Windows)            | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install voidtools.Everything`/`scoop install everything`/`choco install everything` | N/A |
| RetroArch              | Emulator frontend                        | `sudo pacman -S retroarch` | `sudo apt install retroarch` | `sudo dnf install retroarch` | `sudo zypper install retroarch` | `apk add retroarch` | `nix-env -iA nixos.retroarch` | `emerge retroarch` | `winget install Libretro.RetroArch`/`scoop install retroarch`/`choco install retroarch` | Manual |
| Flow Launcher          | Application launcher (Windows)           | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install Flow-Launcher.Flow-Launcher`/`scoop install flow-launcher`/`choco install flow-launcher` | N/A |
| Bulk Crap Uninstaller  | Bulk uninstaller (Windows)               | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install Klocman.BulkCrapUninstaller`/`scoop install bulk-crap-uninstaller`/`choco install bulk-crap-uninstaller` | N/A |
| FFmpeg                 | Multimedia framework/CLI tools           | `sudo pacman -S ffmpeg`    | `sudo apt install ffmpeg` | `sudo dnf install ffmpeg` | `sudo zypper install ffmpeg` | `apk add ffmpeg` | `nix-env -iA nixos.ffmpeg` | `emerge ffmpeg` | `winget install Gyan.FFmpeg`/`scoop install ffmpeg`/`choco install ffmpeg` | `pkg install ffmpeg` |
| Obsidian               | Markdown knowledge base / PKM            | Manual                     | Manual                   | Manual              | Manual              | Manual                 | Manual                    | Manual              | `winget install Obsidian.Obsidian`/`scoop install obsidian`/`choco install obsidian` | Manual |
| Xemu                   | Xbox emulator                            | `yay -S xemu`              | Manual                   | Manual              | Manual              | Manual                 | `nix-env -iA nixos.xemu`   | Manual              | `winget install xemu-project.xemu`/`scoop install xemu` | Manual |
| MS Edge Redirect       | Edge protocol redirector (Windows)       | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install rcmaehl.MSEdgeRedirect`/`choco install msedgeredirect` | N/A |
| DevToys                | Developer Swiss Army knife (Windows)     | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install DevToys.DevToys`/`scoop install devtoys`/`choco install devtoys` | N/A |
| HWiNFO                 | Hardware info tool (Windows)             | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install REALiX.HWiNFO`/`scoop install hwinfo`/`choco install hwinfo` | N/A |
| WiseToys               | Productivity tools suite (Windows)       | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install WiseCleaner.WiseToys`/`scoop install wisetoys` | N/A |
| FileConverter          | File format converter (Windows)          | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install AdrienAllard.FileConverter`/`choco install fileconverter` | N/A |
| Link Shell Extensions  | NTFS/symlink shell extension (Windows)   | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install HermannSchinagl.LinkShellExtension`/`choco install linkshellextension` | N/A |
| Playnite               | Game library manager                     | Manual                     | Manual                   | Manual              | Manual              | Manual                 | Manual                    | Manual              | `winget install Playnite.Playnite`/`scoop install playnite`/`choco install playnite` | Manual |
| Nilesoft Shell         | Windows shell extension                  | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install Nilesoft.Shell`/`scoop install nilesoft-shell` | N/A |
| Mica for Everyone      | Mica effect for Windows apps             | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install MicaForEveryone.MicaForEveryone`/`choco install micaforeveryone` | N/A |
| Microsoft PowerToys    | Power-user utilities (Windows)           | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install Microsoft.PowerToys`/`scoop install powertoys`/`choco install powertoys` | N/A |
| Microsoft NuGet        | .NET package manager                     | `sudo pacman -S nuget`     | `sudo apt install nuget` | `sudo dnf install nuget` | `sudo zypper install nuget` | Manual                | `nix-env -iA nixos.nuget`       | `emerge nuget`    | `winget install NuGet.NuGet`/`choco install nuget.commandline` | Manual |
| Ventoy                 | USB multiboot tool                       | `yay -S ventoy-bin`        | Manual                   | Manual              | Manual              | Manual                 | Manual                    | Manual              | `winget install Ventoy.Ventoy`/`scoop install ventoy`/`choco install ventoy` | Manual |
| Google Android Studio  | Android IDE                              | `sudo pacman -S android-studio` | `sudo apt install android-studio` | Manual | Manual | Manual | `nix-env -iA nixos.android-studio` | Manual | `winget install Google.AndroidStudio`/`scoop install android-studio`/`choco install androidstudio` | Manual |
| MSI Afterburner        | GPU overclocking tool (Windows)          | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install MSI.Afterburner`/`choco install msiafterburner` | N/A |
| Windhawk               | Windows modding framework                | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install Ramensoftware.Windhawk`/`choco install windhawk` | N/A |
| Wiztree                | Disk space analyzer (Windows)            | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install AntibodySoftware.WizTree`/`scoop install wiztree`/`choco install wiztree` | N/A |
| ArchiSteamFarm         | Steam farming bot                        | Manual                     | Manual                   | Manual              | Manual              | Manual                 | Manual                    | Manual              | `winget install JustArchi.ArchiSteamFarm`/`scoop install archisteamfarm` | Manual |
| Zen Browser            | Minimalist web browser (Windows)         | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | Manual | N/A |
| EFI Boot Editor        | EFI boot entry editor                    | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | `winget install Hasleo.EFIBootEditor` | N/A |
| Ollama                 | Local LLM runner/manager                 | Manual                     | Manual                   | Manual              | Manual              | Manual                 | Manual                    | Manual              | `winget install Ollama.Ollama`/`scoop install ollama` | Manual |
| Jq                     | JSON CLI processor                       | `sudo pacman -S jq`        | `sudo apt install jq`    | `sudo dnf install jq` | `sudo zypper install jq` | `apk add jq` | `nix-env -iA nixos.jq` | `emerge jq` | `winget install stedolan.jq`/`scoop install jq`/`choco install jq` | `pkg install jq` |
| Proot                  | User-space chroot (Linux/Android)        | `sudo pacman -S proot`     | `sudo apt install proot` | `sudo dnf install proot` | `sudo zypper install proot` | `apk add proot` | `nix-env -iA nixos.proot` | `emerge proot` | Manual | `pkg install proot` |
| Termux-API             | Android terminal API bridge              | N/A                        | N/A                      | N/A                 | N/A                 | N/A                    | N/A                       | N/A                 | N/A | `pkg install termux-api` |

</details>

<details>
<summary><strong>🌐 Social Media</strong></summary>

| Tool      | Description                | Arch (Pacman/yay)      | Ubuntu/Debian (apt)   | Fedora/RHEL (dnf)    | openSUSE (zypper)    | Alpine (apk)   | NixOS (nix-env)        | Gentoo (emerge)  | Windows (winget/scoop/choco)                  | Android/Termux         |
|-----------|----------------------------|------------------------|-----------------------|----------------------|----------------------|---------------|------------------------|------------------|-----------------------------------------------|------------------------|
| Discord   | Gaming/voice chat client   | `yay -S discord`       | `sudo apt install discord` | `sudo dnf install discord` | `sudo zypper install discord` | `flatpak install flathub com.discordapp.Discord` | `nix-env -iA nixos.discord` | `emerge discord` | `winget install Discord.Discord`/`scoop install discord`/`choco install discord` | Manual |
| Telegram  | Messaging app              | `sudo pacman -S telegram-desktop` | `sudo apt install telegram-desktop` | `sudo dnf install telegram-desktop` | `sudo zypper install telegram-desktop` | `flatpak install flathub org.telegram.desktop` | `nix-env -iA nixos.telegram-desktop` | `emerge telegram-desktop` | `winget install Telegram.TelegramDesktop`/`scoop install telegram`/`choco install telegram` | Manual |
| PreMiD    | Rich presence integration  | `npm install -g premid` | `npm install -g premid` | `npm install -g premid` | `npm install -g premid` | `npm install -g premid` | `npm install -g premid` | `npm install -g premid` | `winget install PreMiD.PreMiD`/`scoop install premid` | Manual |

</details>

> **Note:**  
> Some tools are only available through secondary means such as `pip`, `cargo`, `gem`, or manual download from their official website or GitHub releases. If a tool is not available through your platform’s main package manager, refer to the corresponding “Manual”, “GitHub”, or language-specific package column, or check the official project documentation for installation instructions. Some Windows utilities (like Windhawk, Zen Browser, EFI Boot Editor, etc.) require manual installation. Platform-specific or feature-only tools may also require dedicated setup outside package management systems.


## Credits

_All software, scripts, and config seeds referenced in this repository are the intellectual property of their respective authors and maintainers. Their generosity and effort enable this repo's cross-platform CLI and customization curation._

- [AdrienAllard/FileConverter](https://github.com/AdrienAllard/FileConverter) – [Adrien Allard](https://github.com/AdrienAllard)
- [alpinelinux/apk-tools](https://gitlab.alpinelinux.org/alpine/apk-tools) – [Alpine Team](https://alpinelinux.org/)
- [ArchiSteamFarm](https://github.com/JustArchiNET/ArchiSteamFarm) – [JustArchi](https://github.com/JustArchiNET)
- [Audio4Linux/JDSP4Linux](https://github.com/Audio4Linux/JDSP4Linux) – [Audio4Linux team](https://github.com/Audio4Linux)
- [Bat](https://github.com/sharkdp/bat) – [David Peter](https://github.com/sharkdp)
- [Bitwarden/clients](https://github.com/bitwarden/clients) – [Bitwarden Inc](https://bitwarden.com/)
- [Btop](https://github.com/aristocratos/btop) – [Aristocratos](https://github.com/aristocratos)
- [Bulk-Crap-Uninstaller](https://github.com/Klocman/Bulk-Crap-Uninstaller) – [Klocman](https://github.com/Klocman)
- [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) – [Andrew Gallant](https://github.com/BurntSushi)
- [busyloop/lolcat](https://github.com/busyloop/lolcat) – [Ruby community](https://github.com/busyloop)
- [charmbracelet/glow](https://github.com/charmbracelet/glow) – [Charmbracelet](https://github.com/charmbracelet)
- [ChrisTitusTech/winutil](https://github.com/ChrisTitusTech/winutil) – [Chris Titus](https://github.com/ChrisTitusTech)
- [cli/cli](https://github.com/cli/cli) – [GitHub](https://github.com/cli)
- [Cliphist](https://github.com/sentriz/cliphist) – [sentriz](https://github.com/sentriz)
- [containers/podman](https://github.com/containers/podman) – [Podman contributors](https://github.com/containers/podman)
- [dalance/nb](https://github.com/dalance/nb) – [Ichiro Hara (dalance)](https://github.com/dalance)
- [debian/dpkg](https://salsa.debian.org/dpkg-team/dpkg) – [Debian/Ubuntu maintainers](https://www.debian.org/)
- [denisidoro/navi](https://github.com/denisidoro/navi) – [Denis Idoro](https://github.com/denisidoro)
- [DevToysApp/DevToys](https://github.com/DevToysApp/DevToys) – [DevToys team](https://github.com/DevToysApp)
- [discord.com](https://discord.com/) – [Discord, Inc.](https://discord.com/)
- [docker/compose](https://github.com/docker/compose) – [Docker contributors](https://github.com/docker/compose)
- [dotnet/core](https://github.com/dotnet/core) – [Microsoft](https://github.com/dotnet)
- [Doom Emacs](https://github.com/hlissner/doom-emacs) – [Henrik Lissner](https://github.com/hlissner)
- [DuckDB](https://github.com/duckdb/duckdb) – [DuckDB Labs](https://github.com/duckdb)
- [EarthPro](https://www.google.com/earth/versions/#earth-pro) – [Google Inc](https://www.google.com/)
- [Emacs](https://github.com/emacs-mirror/emacs) – [FSF (Richard Stallman et al)](https://www.gnu.org/software/emacs/)
- [Epic Games Launcher](https://epicgames.com/store/en-US/download/epic-games-launcher) – [Epic Games Inc.](https://www.epicgames.com/)
- [eza-community/eza](https://github.com/eza-community/eza) – [eza community](https://github.com/eza-community)
- [Exifaudio](https://github.com/Spotlight0xff/exifaudio) – [Spotlight0xff](https://github.com/Spotlight0xff)
- [Fastfetch](https://github.com/fastfetch-cli/fastfetch) – [fastfetch-cli contributors](https://github.com/fastfetch-cli)
- [fd](https://github.com/sharkdp/fd) – [David Peter](https://github.com/sharkdp)
- [Flow-Launcher/Flow.Launcher](https://github.com/Flow-Launcher/Flow.Launcher) – [Flow-Launcher contributors](https://github.com/Flow-Launcher)
- [Fuzzel](https://github.com/fuzzel-project/fuzzel) – [Christian M. Aagesen](https://github.com/fuzzel-project)
- [genymobile/scrcpy](https://github.com/Genymobile/scrcpy) – [Genymobile](https://github.com/Genymobile)
- [GOGcom/galaxy-integrations-python-api](https://github.com/GOGcom/galaxy-integrations-python-api) – [GOG.com](https://www.gog.com/)
- [godotengine/godot](https://github.com/godotengine/godot) – [Godot Team](https://github.com/godotengine)
- [GNU Bash](https://www.gnu.org/software/bash/) – [Brian Fox and the GNU Project](https://www.gnu.org/software/bash/)
- [gwsw/less](https://github.com/gwsw/less) – [Mark Nudelman](https://github.com/gwsw)
- [hasleo.com/efibooteditor](https://www.hasleo.com/efibooteditor.html) – [Hasleo Software](https://www.hasleo.com/)
- [helix-editor/helix](https://github.com/helix-editor/helix) – [Kiro Risk, contributors](https://github.com/helix-editor)
- [Homebrew/brew](https://github.com/Homebrew/brew) – [Homebrew contributors](https://github.com/Homebrew)
- [Hyprland](https://github.com/hyprwm/Hyprland) – [Vaxry](https://github.com/hyprwm)
- [hyprwm/hypridle](https://github.com/hyprwm/hypridle) – [Hypridle contributors](https://github.com/hyprwm)
- [hyprwm/hyprpicker](https://github.com/hyprwm/hyprpicker) – [Hyprpicker contributors](https://github.com/hyprwm)
- [hyprwm/hyprplugins](https://github.com/hyprwm/hyprplugins) – [Hyprplugins contributors](https://github.com/hyprwm)
- [hyprwm/hyprshot](https://github.com/hyprwm/hyprshot) – [Hyprshot contributors](https://github.com/hyprwm)
- [JesseDuffield/lazygit](https://github.com/JesseDuffield/lazygit) – [Jesse Duffield](https://github.com/JesseDuffield)
- [JustArchiNET/ArchiSteamFarm](https://github.com/JustArchiNET/ArchiSteamFarm) – [JustArchi](https://github.com/JustArchiNET)
- [Kakoune](https://github.com/mawww/kakoune) – [Martin Tournoij, contributors](https://github.com/mawww)
- [kovidgoyal/kitty](https://github.com/kovidgoyal/kitty) – [Kovid Goyal](https://github.com/kovidgoyal)
- [LGFae/swww](https://github.com/LGFae/swww) – [LG Fae](https://github.com/LGFae)
- [Man-db](https://gitlab.com/man-db/man-db) – [Colin Watson](https://gitlab.com/man-db)
- [mborgerson/xemu](https://github.com/mborgerson/xemu) – [mborgerson](https://github.com/mborgerson)
- [MicaForEveryone/MicaForEveryone](https://github.com/MicaForEveryone/MicaForEveryone) – [MicaForEveryone team](https://github.com/MicaForEveryone)
- [Microsoft](https://microsoft.com) – [Microsoft](https://microsoft.com)
- [nano-editor/nano](https://github.com/nano-editor/nano) – [Chris Allegretta et al](https://github.com/nano-editor)
- [neovim/neovim](https://github.com/neovim/neovim) – [neovim team](https://github.com/neovim)
- [Nilesoft.Shell](https://nilesoft.org/shell/) – [Nilesoft](https://nilesoft.org/)
- [NixOS/nix](https://github.com/NixOS/nix) – [Domen Kožar et al](https://github.com/NixOS)
- [npm/cli](https://github.com/npm/cli) – [npm community](https://github.com/npm)
- [nvi/nvi](https://github.com/nvi-editor/nvi) – [nvi contributors](https://github.com/nvi-editor)
- [ogham/exa](https://github.com/ogham/exa) – [Benjamin Sago](https://github.com/ogham)
- [Oh My Posh](https://github.com/JanDeDobbeleer/oh-my-posh) – [Jan De Dobbeleer](https://github.com/JanDeDobbeleer)
- [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) – [Robby Russell et al](https://github.com/ohmyzsh)
- [OpenDoas](https://github.com/Duncaen/OpenDoas) – [Ted Unangst](https://github.com/Duncaen)
- [OpenRGB](https://github.com/AdamHonse/OpenRGB) – [Adam Honse](https://github.com/AdamHonse)
- [ouch-org/ouch](https://github.com/ouch-org/ouch) – [Ouch contributors](https://github.com/ouch-org)
- [Pacman](https://gitlab.archlinux.org/pacman/pacman) – [Arch Linux Team](https://archlinux.org/)
- [pipxproject/pipx](https://github.com/pipxproject/pipx) – [pipx contributors](https://github.com/pipxproject)
- [Playnite](https://github.com/JosefNemec/Playnite) – [Josef Nemec](https://github.com/JosefNemec)
- [Playerctl](https://github.com/acrisci/playerctl) – [Alec A. Criscuolo](https://github.com/acrisci)
- [PowerShell/PowerShell](https://github.com/PowerShell/PowerShell) – [Microsoft](https://github.com/PowerShell)
- [PrismLauncher/PrismLauncher](https://github.com/PrismLauncher/PrismLauncher) – [Prism Launcher Team](https://github.com/PrismLauncher)
- [pygments/pygments](https://github.com/pygments/pygments) – [Pygments Team](https://github.com/pygments)
- [pypa/pip](https://github.com/pypa/pip) – [PyPA](https://github.com/pypa)
- [pypa/pipenv](https://github.com/pypa/pipenv) – [PyPA](https://github.com/pypa)
- [rainmeter.net](https://www.rainmeter.net/) – [Rainmeter team](https://www.rainmeter.net/)
- [ramensoftware/windhawk](https://github.com/ramensoftware/windhawk) – [Roman Lebedev](https://github.com/ramensoftware)
- [Ranger](https://github.com/ranger/ranger) – [Roman Zimbelmann](https://github.com/ranger)
- [Reflector](https://github.com/Xyne/reflector) – [Xyne](https://github.com/Xyne)
- [ripgrep](https://github.com/BurntSushi/ripgrep) – [Andrew Gallant](https://github.com/BurntSushi)
- [rmpc](https://github.com/mierak/rmpc) – [mierak](https://github.com/mierak)
- [rust-lang/cargo](https://github.com/rust-lang/cargo) – [Rust Team](https://github.com/rust-lang)
- [scoop.sh](https://scoop.sh) – [Scoop contributors](https://github.com/ScoopInstaller)
- [sxyazi/yazi](https://github.com/sxyazi/yazi) – [YaZi contributors](https://github.com/sxyazi)
- [stedolan/jq](https://github.com/stedolan/jq) – [Stephen Dolan](https://github.com/stedolan)
- [Steam for Linux](https://github.com/ValveSoftware/steam-for-linux) – [Valve](https://github.com/ValveSoftware)
- [Taskbar mods (Windhawk)](https://github.com/ramensoftware/windhawk) – [Roman Lebedev](https://github.com/ramensoftware)
- [Telegram](https://telegram.org/) – [Telegram Messenger LLP](https://telegram.org/)
- [TheZoraiz/ascii-image-converter](https://github.com/TheZoraiz/ascii-image-converter) – [TheZoraiz](https://github.com/TheZoraiz)
- [tmux/tmux](https://github.com/tmux/tmux) – [Nicholas Marriott](https://github.com/tmux)
- [tmuxinator/tmuxinator](https://github.com/tmuxinator/tmuxinator) – [Gabriel Sobrinho, team](https://github.com/tmuxinator)
- [Tree](https://github.com/Old-Man-Programmer/tree) – [Steve Baker, Old-Man-Programmer](https://github.com/Old-Man-Programmer)
- [ValveSoftware/steam-for-linux](https://github.com/ValveSoftware/steam-for-linux) – [Valve](https://github.com/ValveSoftware)
- [ventoy/Ventoy](https://github.com/ventoy/Ventoy) – [longpanda](https://github.com/ventoy)
- [VSCodium/vscodium](https://github.com/VSCodium/vscodium) – [VSCodium community](https://github.com/VSCodium)
- [Win11 File Explorer Styler (Windhawk)](https://github.com/ramensoftware/windhawk) – [Roman Lebedev](https://github.com/ramensoftware)
- [Winaero Tweaker](https://winaero.com) – [Sergey Tkachenko](https://winaero.com)
- [WiseUncle/WiseToys](https://github.com/WiseUncle/WiseToys) – [WiseToys Team](https://github.com/WiseUncle)
- [wiztree](https://github.com/AntibodySoftware/WizTree) – [Antibody Software](https://github.com/AntibodySoftware)
- [Xyne/reflector](https://github.com/Xyne/reflector) – [Xyne](https://github.com/Xyne)
- [yt-dlp/yt-dlp](https://github.com/yt-dlp/yt-dlp) – [yt-dlp contributors](https://github.com/yt-dlp)
- [zsh-users/zsh](https://github.com/zsh-users/zsh) – [Paul Falstad and contributors](https://github.com/zsh-users)
- [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions) – [zsh-users](https://github.com/zsh-users)
- [8GadgetPack](https://8gadgetpack.net/) – [Helmut Buhler](https://8gadgetpack.net/)
- [Adobe Creative Cloud](https://www.adobe.com/creativecloud.html) – [Adobe](https://www.adobe.com/)
- [ASIO4ALL](https://www.asio4all.org/) – [Michael Tippach](https://www.asio4all.org/)
- [Cava](https://github.com/karlstav/cava) – [Karl Stavestrand](https://github.com/karlstav)
- [Discord](https://discord.com/) – [Discord, Inc.](https://discord.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) – [Docker, Inc.](https://www.docker.com/)
- [EA Desktop](https://www.ea.com/ea-app) – [Electronic Arts](https://www.ea.com/)
- [EFI Boot Editor](https://www.hasleo.com/efibooteditor.html) – [Hasleo Software](https://www.hasleo.com/)
- [Everything](https://www.voidtools.com/) – [David Carpenter](https://www.voidtools.com/)
- [FFmpeg](https://ffmpeg.org/) – [FFmpeg Team](https://ffmpeg.org/)
- [Fzf](https://github.com/junegunn/fzf) – [Junegunn Choi](https://github.com/junegunn)
- [Github CLI](https://cli.github.com/) – [GitHub](https://github.com/cli)
- [Git Extensions](https://gitextensions.github.io/) – [Git Extensions Team](https://github.com/gitextensions/gitextensions)
- [Google Android Studio](https://developer.android.com/studio) – [Google](https://developer.android.com/)
- [Google Drive](https://www.google.com/drive/) – [Google](https://www.google.com/)
- [HWiNFO](https://www.hwinfo.com/) – [REALiX](https://www.hwinfo.com/)
- [JamesDSP](https://github.com/Audio4Linux/JDSP4Linux) – [Audio4Linux team](https://github.com/Audio4Linux)
- [Kwinrc](https://invent.kde.org/plasma/kwin) – [KDE Community](https://kde.org/)
- [Link Shell Extension](https://schinagl.priv.at/nt/hardlinkshellext/linkshellextension.html) – [Hermann Schinagl](https://schinagl.priv.at/)
- [MacPorts](https://www.macports.org/) – [MacPorts Team](https://github.com/macports/macports-base)
- [Microsoft Edge Redirect](https://rcmaehl.github.io/MSEdgeRedirect/) – [Robert Maehl](https://github.com/rcmaehl)
- [Microsoft NuGet](https://www.nuget.org/) – [Microsoft](https://www.nuget.org/profiles/Microsoft)
- [Microsoft OneDrive](https://onedrive.live.com/) – [Microsoft](https://microsoft.com)
- [Microsoft PowerToys](https://github.com/microsoft/PowerToys) – [Microsoft](https://github.com/microsoft)
- [MSI Afterburner](https://www.msi.com/Landing/afterburner/graphics-cards) – [MSI](https://www.msi.com/)
- [Nb-preview](https://github.com/dalance/nb) – [Ichiro Hara (dalance)](https://github.com/dalance)
- [Obsidian](https://obsidian.md/) – [Obsidian.md](https://obsidian.md/)
- [Oh My Zsh](https://ohmyz.sh/) – [Robby Russell et al](https://github.com/ohmyzsh/ohmyzsh)
- [OneDrive (abraunegg)](https://github.com/abraunegg/onedrive) – [abraunegg](https://github.com/abraunegg)
- [Playnite](https://playnite.link/) – [Josef Nemec](https://github.com/JosefNemec)
- [Podman](https://podman.io/) – [Podman contributors](https://github.com/containers/podman)
- [PowerShell](https://github.com/PowerShell/PowerShell) – [Microsoft](https://github.com/PowerShell)
- [PreMiD](https://github.com/Timeraa/PreMiD) – [Timeraa et al](https://github.com/Timeraa)
- [Prism Launcher](https://prismlauncher.org/) – [Prism Launcher Team](https://github.com/PrismLauncher)
- [Proot](https://proot-me.github.io/) – [proot-me](https://github.com/proot-me)
- [ProtonVPN](https://protonvpn.com/) – [Proton AG](https://protonvpn.com/)
- [Qbittorrent](https://www.qbittorrent.org/) – [qBittorrent Team](https://github.com/qbittorrent/qBittorrent)
- [Qt5ct](https://github.com/qt5ct/qt5ct) – [Maksim Sosnovskiy](https://github.com/qt5ct)
- [Rainmeter](https://www.rainmeter.net/) – [Rainmeter team](https://www.rainmeter.net/)
- [RetroArch](https://www.retroarch.com/) – [Libretro Team](https://github.com/libretro/RetroArch)
- [Scrcpy](https://github.com/Genymobile/scrcpy) – [Genymobile](https://github.com/Genymobile)
- [Snapd](https://github.com/snapcore/snapd) – [Canonical](https://github.com/snapcore)
- [Spicetify](https://github.com/spicetify/spicetify-cli) – [Khanhas](https://github.com/khanhas)
- [Spotify](https://www.spotify.com/) – [Spotify AB](https://www.spotify.com/)
- [Steam](https://store.steampowered.com/) – [Valve](https://store.steampowered.com/)
- [Swww](https://github.com/LGFae/swww) – [LG Fae](https://github.com/LGFae)
- [Telegram](https://telegram.org/) – [Telegram Messenger LLP](https://telegram.org/)
- [Termux-API](https://wiki.termux.com/wiki/Termux:API) – [Termux contributors](https://github.com/termux/termux-api)
- [VSCodium](https://vscodium.com/) – [VSCodium community](https://github.com/VSCodium)
- [Wayland/Weston](https://wayland.freedesktop.org/) – [Wayland/Weston contributors](https://gitlab.freedesktop.org/wayland/weston)
- [Windows Terminal](https://github.com/microsoft/terminal) – [Microsoft](https://github.com/microsoft)
- [WiseToys](https://wisetoys.app/) – [WiseToys Team](https://github.com/WiseUncle)
- [Wireplumber](https://pipewire.pages.freedesktop.org/wireplumber/) – [PipeWire Project](https://gitlab.freedesktop.org/pipewire/wireplumber)
- [WizTree](https://wiztreefree.com/) – [Antibody Software](https://github.com/AntibodySoftware)
- [Zen Browser](https://github.com/zenbrowser/zenbrowser) – [zenbrowser](https://github.com/zenbrowser)
- [saumyajyoti/omp.yazi](https://github.com/saumyajyoti/omp.yazi) – [Saumyajyoti Mukherjee](https://github.com/saumyajyoti)
- [ndtoan96/ouch.yazi](https://github.com/ndtoan96/ouch.yazi) – [ndtoan96](https://github.com/ndtoan96)
- [boydaihungst/restore.yazi](https://github.com/boydaihungst/restore.yazi) – [boydaihungst](https://github.com/boydaihungst)
- [kirasok/torrent-preview.yazi](https://github.com/kirasok/torrent-preview.yazi) – [kirasok](https://github.com/kirasok)
- [AnirudhG07/rich-preview.yazi](https://github.com/AnirudhG07/rich-preview.yazi) – [AnirudhG07](https://github.com/AnirudhG07)
- [yazi-rs/plugins:smart-filter](https://github.com/yazi-rs/plugins/tree/main/smart-filter.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:smart-enter](https://github.com/yazi-rs/plugins/tree/main/smart-enter.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:nbpreview](https://github.com/AnirudhG07/nbpreview.yazi) – AnirudhG07
- [yazi-rs/plugins:mount](https://github.com/yazi-rs/plugins/tree/main/mount.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:full-border](https://github.com/yazi-rs/plugins/tree/main/full-border.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:diff](https://github.com/yazi-rs/plugins/tree/main/diff.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:chmod](https://github.com/yazi-rs/plugins/tree/main/chmod.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:hide-preview](https://github.com/yazi-rs/plugins/tree/main/hide-preview.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:jump-to-char](https://github.com/yazi-rs/plugins/tree/main/jump-to-char.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:hexyl](https://github.com/yazi-rs/plugins/tree/main/hexyl.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:glow](https://github.com/yazi-rs/plugins/tree/main/glow.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:eza-preview](https://github.com/yazi-rs/plugins/tree/main/eza-preview.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:git](https://github.com/yazi-rs/plugins/tree/main/git.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:lazygit](https://github.com/yazi-rs/plugins/tree/main/lazygit.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:miller](https://github.com/yazi-rs/plugins/tree/main/miller.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:mediainfo](https://github.com/yazi-rs/plugins/tree/main/mediainfo.yazi) – [yazi-rs contributors](https://github.com/yazi-rs/plugins/graphs/contributors/)
- [yazi-rs/plugins:duckdb](https://github.com/wylie102/duckdb.yazi) – [wylie102](https://github.com/wylie102)
- [yazi-rs/plugins:exifaudio](https://github.com/Sonico98/exifaudio.yazi) – [Sonico98](https://github.com/Sonico98)
- [Microsoft Learn](https://learn.microsoft.com/) - Microsoft documentation used in Windows configs
- [Windows Answer File Generator](https://schneegans.de/windows/unattend-generator/) - Christian Schneegans
- [MajorGeeks](https://www.majorgeeks.com/) - Windows utility scripts and Group Policy Editor enablement
- [Perplexity AI](https://www.perplexity.ai/) - Initial README.md content generation
- [Neovim Theme: Tokyo Night](https://github.com/folke/tokyonight.nvim) - Folke Lemaitre
- [Zen Browser Theme Authors](https://github.com/zenbrowser/zenbrowser) - Various contributors including lenzfliker, paasito, ToBinio, shldk, rsiebertdev, Kaedriz, Felkazz, ocean-mars, HliasOuzounis, ch4og, danm36, n7itro, KiKaraage, DaitiDay, AmirhBeigi, Dinno-DEV, TheBigWazz, RobotoSkunk, Uiniel, Nimit1705
- [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - [Zsh-users](https://github.com/zsh-users) - Zsh syntax highlighting implementation
- [zsh-users/zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) - [Zsh-users](https://github.com/zsh-users) - History search functionality
- [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - [Zsh-users](https://github.com/zsh-users) - Auto-suggestions implementation
- [Aloxaf/fzf-tab](https://github.com/Aloxaf/fzf-tab) - [Aloxaf](https://github.com/Aloxaf) - Fuzzy completion framework
- [djui/alias-tips](https://github.com/djui/alias-tips) - [Djui](https://github.com/djui) - Alias tips implementation
- [LazyVim/LazyVim](https://github.com/LazyVim/LazyVim) - [LazyVim](https://github.com/LazyVim) - Neovim configuration patterns and plugins structure
- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - [Folke](https://github.com/folke) - Plugin management patterns for Neovim

_If you are the author of any tool/config/snip used here and wish a correction or further explicit attribution, please [open an issue or pull request](https://github.com/sametaor/sametaor_CLIconfig/issues) and you will be credited transparently. This repository is a personal reference implementation, not a redistribution, and does not claim ownership over any listed tool or script._
