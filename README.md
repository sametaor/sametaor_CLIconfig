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

</details>

<details>
<summary><strong>🪟 Windows-specific Tools</strong></summary>

| Tool                  | Description                        | winget                                    | scoop                       | choco                        | Manual                    |
|-----------------------|------------------------------------|--------------------------------------------|-----------------------------|------------------------------|---------------------------|
| PowerShell            | Modern Microsoft shell             | `winget install Microsoft.Powershell`      | `scoop install pwsh`        | `choco install powershell`   | N/A                       |
| Windows Terminal      | Modern terminal with tabs          | `winget install Microsoft.WindowsTerminal` | `scoop install windows-terminal` | `choco install microsoft-windows-terminal` | N/A       |
| Terminal-Icons        | Shell icons for PowerShell         | N/A                                       | N/A                        | N/A                         | `Install-Module -Name Terminal-Icons -Repository PSGallery` (PowerShell) |
| 7zip                  | File archiver                      | `winget install 7zip.7zip`                | `scoop install 7zip`        | `choco install 7zip`         | N/A                       |
| GitHub CLI            | Official GitHub CLI tool           | `winget install GitHub.cli`               | `scoop install gh`          | `choco install gh`           | [GitHub MSI](https://github.com/cli/cli/releases)  |
| Git Extensions        | Git GUI                            | `winget install GitExtensionsTeam.GitExtensions` | N/A                   | `choco install gitextensions`| N/A                       |
| Docker Desktop        | Docker containers GUI              | `winget install Docker.DockerDesktop`      | `scoop install docker`      | `choco install docker-desktop`| N/A                      |
| Fzf                   | Fuzzy finder CLI                   | `winget install fzf`                       | `scoop install fzf`         | `choco install fzf`          | N/A                       |
| Fastfetch             | System info tool                   | `winget install Fastfetch.Fastfetch`       | `scoop install fastfetch`   | `choco install fastfetch`    | [GitHub MSI](https://github.com/fastfetch-cli/fastfetch/releases) |
| Oh-my-posh            | Terminal theming                   | `winget install JanDeDobbeleer.OhMyPosh`   | `scoop install oh-my-posh`  | `choco install oh-my-posh`   | N/A                       |
| Gpg4win               | Encryption/signing suite           | `winget install Gpg4win.Gpg4win`           | N/A                        | `choco install gpg4win`      | N/A                       |
| Spicetify             | Spotify theming                    | `winget install Spicetify.SpicetifyCli`    | `scoop install spicetify-cli`| `choco install spicetify-cli`| [GitHub](https://github.com/spicetify/spicetify-cli/releases) |
| Neovim                | Modern Vim-based editor            | `winget install Neovim.Neovim`             | `scoop install neovim`      | `choco install neovim`       | N/A                       |
| Eza                   | Modern ls replacement              | `winget install eza-community.eza`         | `scoop install eza`         | `choco install eza`          | N/A                       |
| Pip (Python)          | Python package manager             | `winget install Python.Python.3.14`        | `scoop install python`      | `choco install python`       | N/A                       |
| Git                   | Version control                    | `winget install Git.Git`                   | `scoop install git`         | `choco install git`          | N/A                       |
| Visual Studio Code    | Editor                             | `winget install Microsoft.VisualStudioCode` | `scoop install vscode`      | `choco install vscode`       | N/A                       |
| Rainmeter             | Desktop customization              | `winget install Rainmeter.Rainmeter`        | `scoop install rainmeter`   | `choco install rainmeter`    | N/A                       |
| Qbittorrent           | Torrent client                     | `winget install qBittorrent.qBittorrent`    | `scoop install qbittorrent` | `choco install qbittorrent`  | N/A                       |
| Everything Search     | Fast desktop search                | `winget install voidtools.Everything`       | `scoop install everything`  | `choco install everything`   | N/A                       |
| RetroArch             | Emulator suite                     | `winget install libretro.RetroArch`         | `scoop install retroarch`   | `choco install retroarch`    | N/A                       |
| Flow Launcher         | App launcher                       | `winget install Flow-Launcher.Flow-Launcher`| N/A                        | `choco install flow-launcher`| N/A                       |
| Bulk Crap Uninstaller | Debloat/uninstall tool             | `winget install Klocman.BulkCrapUninstaller`| `scoop install bcuninstaller`| `choco install bulk-crap-uninstaller`| N/A              |
| Discord               | Messaging/VoIP client              | `winget install Discord.Discord`            | `scoop install discord`     | `choco install discord`      | N/A                       |
| Telegram              | Messaging app                      | `winget install Telegram.TelegramDesktop`   | `scoop install telegram`    | `choco install telegram`     | N/A                       |
| OneDrive              | Cloud sync                         | `winget install Microsoft.OneDrive`         | N/A                        | N/A                         | Built-in                  |
| ProtonVPN             | VPN provider                       | `winget install ProtonTechnologies.ProtonVPN`| N/A                       | `choco install protonvpn`    | N/A                       |
| EA Desktop            | EA/Origin game launcher            | `winget install ElectronicArts.EADesktop`   | N/A                        | `choco install eadesktop`    | N/A                       |
| FFmpeg                | Video convert/tools                | `winget install Gyan.FFmpeg`                | `scoop install ffmpeg`      | `choco install ffmpeg`       | N/A                       |
| Steam                 | PC gaming/distribution             | `winget install Valve.Steam`                | `scoop install steam`       | `choco install steam`        | N/A                       |
| Epic Games Launcher   | PC gaming/distribution             | `winget install EpicGames.EpicGamesLauncher` | `scoop install epicgames`*  | `choco install epicgameslauncher`| N/A                   |
| Obsidian              | Markdown knowledge base            | `winget install Obsidian.Obsidian`          | `scoop install obsidian`    | `choco install obsidian`     | N/A                       |
| Xemu                  | Xbox emulator                      | `winget install Xemu.Xemu`                  | `scoop install xemu`*       | `choco install xemu`         | N/A                       |
| Microsoft Edge        | Default browser                    | `winget install Microsoft.Edge`             | `scoop install microsoft-edge`*| `choco install microsoft-edge`| N/A                   |
| MS Edge Redirect      | Edge handler for Windows           | `winget install RC114.MSEdgeRedirect`       | N/A                        | `choco install msedgeredirect`| N/A                     |
| Devtoys               | Dev utility toolbox                | `winget install DevToys.DevToys`            | `scoop install devtoys`*    | `choco install devtoys`      | N/A                       |
| HWiNFO                | Hardware information               | `winget install REALiX.HWiNFO`              | `scoop install hwinfo`*     | `choco install hwinfo`       | N/A                       |
| WiseToys              | Utility launcher                   | `winget install WiseToys.WiseToys`          | N/A                        | `choco install wisetoys`     | N/A                       |
| File Converter        | File format conversion             | `winget install AdrienAllard.FileConverter` | N/A                        | N/A                         | N/A                       |
| Link Shell Extension  | Advanced symlink/shell tool        | `winget install Schinagl.LinkShellExtension`| N/A                        | `choco install linkshellextension`| N/A                   |
| Playnite              | All-in-one game launcher           | `winget install Playnite.Playnite`          | `scoop install playnite`    | `choco install playnite`     | N/A                       |
| Prism Launcher        | Minecraft launcher                 | `winget install PrismLauncher.PrismLauncher`| N/A                        | N/A                         | N/A                       |
| Nilesoft Shell        | Context menu utility               | `winget install Nilesoft.Shell`             | N/A                        | N/A                         | N/A                       |
| Mica For Everyone     | Acrylic/mica effect for Windows    | `winget install MicaForEveryone.MicaForEveryone`| N/A                     | N/A                         | N/A                       |
| Powertoys             | Poweruser utilities                | `winget install Microsoft.PowerToys`        | `scoop install powertoys`*  | `choco install powertoys`    | N/A                       |
| Skype                 | Messaging app                      | `winget install Microsoft.Skype`            | N/A                        | `choco install skype`        | N/A                       |
| NuGet                 | .NET package manager               | `winget install Microsoft.NuGet`            | N/A                        | `choco install nuget.commandline` | VS includes NuGet tools|
| EarthPro              | Google Earth Pro                   | `winget install Google.EarthPro`            | N/A                        | `choco install googleearthpro`| N/A                      |
| 8 Gadget Pack         | Classic gadget sidebar             | `winget install HelmutBuhler.8GadgetPack`   | N/A                        | `choco install 8gadgetpack`  | [Download](https://8gadgetpack.net/) |
| Ventoy                | Multiboot USB builder              | `winget install Ventoy.Ventoy`              | N/A                        | N/A                         | [Download](https://www.ventoy.net/) |
| Android Studio        | Android dev IDE                    | `winget install Google.AndroidStudio`       | N/A                        | `choco install androidstudio`| N/A                       |
| MSI Afterburner       | GPU overclock monitor              | `winget install Guru3D.Afterburner`         | N/A                        | `choco install msiafterburner`| [Download](https://www.msi.com/Landing/afterburner/graphics-cards) |
| ASIO4ALL              | Audio driver                       | `winget install MichaelTippach.ASIO4ALL`    | N/A                        | `choco install asio4all`     | [Manual Install](https://asio4all.org/) |
| Creative Cloud        | Adobe suite                        | `winget install Adobe.CreativeCloud`        | N/A                        | `choco install adobecreativecloud`| [Download](https://creativecloud.adobe.com/) |
| Windhawk            | Custom Windows mods                      | N/A                               | N/A                            | N/A                          | [https://windhawk.net/](https://windhawk.net/)   |
| WizTree             | Disk space analyzer                       | `winget install AntibodySoftware.WizTree` | `scoop install wiztree`        | `choco install wiztree`      | [wiztreefree.com](https://wiztreefree.com/)  |
| PreMiD              | Rich presence for web media/streaming    | N/A                               | `scoop install premid` (`extras` bucket) | N/A                          | [https://premid.app/](https://premid.app/)     |
| ArchiSteamFarm      | Steam idle/cards bot                     | N/A                               | `scoop install archisteamfarm` (`extras`) | `choco install archisteamfarm` | [GitHub](https://github.com/JustArchiNET/ArchiSteamFarm) |
| Zen Browser         | Firefox fork                     | `winget install Zen-Team.Zen-Browser`                               | N/A                            | N/A                          | [Official download/manual](https://github.com/zen-browser/desktop/releases/latest/download/zen.installer.exe)|
| PhysX               | NVIDIA physics system libs               | N/A                               | N/A                            | `choco install nvidia-physx` | Nvidia site/manual        |
| NVCleanstall        | Nvidia GPU driver customizer             | `winget install TechPowerUp.NVCleanstall` | N/A                            | `choco install nvcleanstall` | [TechPowerUp]            |
| Windhawk            | Community Windows mods loader            | N/A                               | N/A                            | N/A                          | [windhawk.net](https://windhawk.net) |
| UI Xaml 2.7 / 2.8   | Windows UI dependencies                  | N/A                               | N/A                            | N/A                          | installed with apps, not user-facing |
| VCLibs Desktop 14   | App run dependency                       | N/A                               | N/A                            | N/A                          | installed with apps, not user-facing |
| EFI Boot Editor     | EFI boot entry editor                    | N/A                               | N/A                            | N/A                          | [Manual](https://efieditor.com/) |
| Spotify             | Streaming app                            | `winget install Spotify.Spotify`   | `scoop install spotify`         | `choco install spotify`      | [Manual](https://download.scdn.co/SpotifySetup.exe)                            |
| Oracle JDK 17       | Java Development Kit                     | `winget install Oracle.JavaRuntimeEnvironment.17` | N/A | `choco install oraclejdk`       |                             |
| Google Drive        | Desktop sync                              | `winget install Google.Drive`      | N/A                            | `choco install googledrive`  |                             |
| AppInstaller        | MSIX app installer core                  | `winget install Microsoft.AppInstaller` (usually preinstalled) | N/A | N/A                   | Preinstalled/Windows Update |
| Ollama              | Desktop LLM inference (new)              | `winget install Ollama.Ollama`     | N/A                            | N/A                          | [https://ollama.com/download](https://ollama.com/download) |

\*Some packages are in extras or unofficial buckets; install with `scoop bucket add extras` or as documented.
</details>

<details>
<summary><strong>📱 Android & Termux-specific Tools</strong></summary>

| Tool         | Description                                | Termux/Android Install            | Linux (main)                | Windows                    | Notes                                         |
|--------------|--------------------------------------------|-----------------------------------|-----------------------------|----------------------------|-----------------------------------------------|
| Termux       | Terminal & Linux environment for Android   | Install via F-Droid or Play Store | N/A                         | N/A                        | [termux.com](https://termux.com)              |
| Pkg          | Termux package manager                     | Preinstalled (Termux only)        | N/A                         | N/A                        | Wrapper for APT on Termux                     |
| Curl         | Data transfer utility                      | `pkg install curl`                | Yes                         | Yes                        |                                               |
| Git          | Version control                            | `pkg install git`                 | Yes                         | Yes                        |                                               |
| Coreutils    | GNU/core utilities                         | `pkg install coreutils`           | Yes (builtin)               | Scoop/WSL/MSYS2            |                                               |
| Zsh          | Shell (zsh)                                | `pkg install zsh`                 | Yes                         | Yes                        |                                               |
| Bash         | Shell (bash)                               | `pkg install bash`                | Yes                         | Yes                        |                                               |
| Nano         | Terminal editor                            | `pkg install nano`                | Yes                         | Yes                        |                                               |
| Vim          | Terminal editor                            | `pkg install vim`                 | Yes                         | Yes                        |                                               |
| Neovim       | Modern terminal editor                     | `pkg install neovim`              | Yes                         | Yes                        |                                               |
| Tmux         | Terminal multiplexer                       | `pkg install tmux`                | Yes                         | Yes                        |                                               |
| Fzf          | Fuzzy finder                              | `pkg install fzf`                 | Yes                         | Yes                        |                                               |
| Ripgrep      | Modern grep                                | `pkg install ripgrep`             | Yes                         | Yes                        |                                               |
| Bat          | Cat with syntax highlighting               | `pkg install bat`                 | Yes                         | Yes                        |                                               |
| Fd           | Modern find                                | `pkg install fd`                  | Yes                         | Yes                        |                                               |
| Tree         | Directory visualizer                       | `pkg install tree`                | Yes                         | Yes                        |                                               |
| Less         | Pager utility                              | `pkg install less`                | Yes                         | Yes                        |                                               |
| Wget         | Download utility                           | `pkg install wget`                | Yes                         | Yes                        |                                               |
| Python3      | Python runtime                             | `pkg install python`              | Yes                         | Yes                        |                                               |
| Pip          | Python package mgr (already in python pkg) | `pkg install python`              | Yes                         | Yes                        | Use `pip install <pkg>` to add Python apps    |
| Pipx         | Run Python apps in isolation               | `pip install pipx`                | Yes                         | Yes                        |                                               |
| Gcc          | C compiler                                 | `pkg install clang`               | Yes                         | WSL/MinGW/MSYS2            | Termux uses clang, not GCC directly           |
| Clang        | C/LLVM compiler                            | `pkg install clang`               | Yes                         | WSL/MinGW/MSYS2            |                                               |
| Make         | Build automation                           | `pkg install make`                | Yes                         | WSL/MinGW/MSYS2            |                                               |
| CMake        | Build system                               | `pkg install cmake`               | Yes                         | WSL/MinGW/MSYS2            |                                               |
| Nodejs       | Node.js (& npm)                            | `pkg install nodejs`              | Yes                         | Yes                        | Installs npm as well                          |
| Yarn         | Node.js package mgr                        | `npm install -g yarn`             | Yes                         | Yes                        |                                               |
| Pnpm         | Node.js package mgr                        | `npm install -g pnpm`             | Yes                         | Yes                        |                                               |
| Ruby         | Ruby language & gem installer              | `pkg install ruby`                | Yes                         | Yes                        |                                               |
| Go           | Go language                               | `pkg install golang`              | Yes                         | Yes                        |                                               |
| Rust         | Rust language                              | `pkg install rust`                | Yes                         | Yes                        |                                               |
| Cargo        | Rust package manager                       | `pkg install rust`                | Yes                         | Yes                        |                                               |
| Htop         | Interactive process viewer                 | `pkg install htop`                | Yes                         | Yes                        |                                               |
| Proot        | Userspace chroot tool                      | `pkg install proot`               | N/A                         | N/A                        | Needed for some Linux-in-Termux scenarios     |
| Openssh      | SSH client/server                          | `pkg install openssh`             | Yes                         | Yes                        |                                               |
| Rsync        | Sync utility                               | `pkg install rsync`               | Yes                         | Yes                        |                                               |
| Yazi       | Terminal file manager                      | `pkg install yazi`              | Yes                         | Yes                        |                                               |
| Fastfetch    | System info (neofetch alt)                 | `pkg install fastfetch`           | Yes                         | Yes                        |                                               |
| Zoxide       | Directory jumper                           | `pkg install zoxide`              | Yes                         | Yes                        |                                               |
| Oh-my-posh     | Prompt theming                             | `brew install jandedobbeleer/oh-my-posh`            | Yes                         | Yes                        |                                               |
| Glow         | Markdown TUI viewer                        | `pkg install glow`                | Yes                         | Yes                        |                                               |
| Eza          | Modern ls replacement                      | `pkg install eza`                 | Yes                         | Yes                        |                                               |
| Jq           | JSON CLI processor                         | `pkg install jq`                  | Yes                         | Yes                        |                                               |
| Ffmpeg       | Multimedia encoder/decoder                 | `pkg install ffmpeg`              | Yes                         | Yes                        |                                               |
| Termux-api   | Phone sensors and API interface            | `pkg install termux-api`          | N/A                         | N/A                        | Exposes Android APIs to Termux                |
| Termux-exec  | Native shebang support in Termux           | `pkg install termux-exec`         | N/A                         | N/A                        |                                               |

</details>

> **Note:**  
> Some tools are only available through secondary means such as `pip`, `cargo`, `gem`, or manual download from their official website or GitHub releases. If a tool is not available through your platform’s main package manager, refer to the corresponding “Manual”, “GitHub”, or language-specific package column, or check the official project documentation for installation instructions. Some Windows utilities (like Windhawk, Zen Browser, EFI Boot Editor, etc.) require manual installation. Platform-specific or feature-only tools may also require dedicated setup outside package management systems.

## Credits

_All software, scripts, and config seeds referenced in this repository are the intellectual property of their respective authors and maintainers. Their generosity and effort enable this repo's cross-platform CLI and customization curation._

### Core System, Editor & Shell Tools

- **Bash** – Brian Fox and the GNU Project – [GNU Bash](https://www.gnu.org/software/bash/)
- **Zsh** – Paul Falstad and contributors – [zsh-users/zsh](https://github.com/zsh-users/zsh)
- **Zsh-completions** – [zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions)
- **Oh My Zsh** – Robby Russell et al – [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh)
- **Oh My Posh** – Jan De Dobbeleer – [JanDeDobbeleer/oh-my-posh](https://github.com/JanDeDobbeleer/oh-my-posh)
- **Tmux** – Nicholas Marriott – [tmux/tmux](https://github.com/tmux/tmux)
- **Tmuxinator** – Gabriel Sobrinho, team – [tmuxinator/tmuxinator](https://github.com/tmuxinator/tmuxinator)
- **Neovim** – neovim team – [neovim/neovim](https://github.com/neovim/neovim)
- **Lazygit** – Jesse Duffield – [JesseDuffield/lazygit](https://github.com/JesseDuffield/lazygit)
- **Doom Emacs** – Henrik Lissner – [hlissner/doom-emacs](https://github.com/hlissner/doom-emacs)
- **Emacs** – FSF (Richard Stallman et al) – [emacs-mirror/emacs](https://github.com/emacs-mirror/emacs)
- **VSCodium** – VSCodium community – [VSCodium/vscodium](https://github.com/VSCodium/vscodium)
- **Nano** – Chris Allegretta et al – [nano-editor/nano](https://github.com/nano-editor/nano)
- **Helix** – Kiro Risk, contributors – [helix-editor/helix](https://github.com/helix-editor/helix)
- **Kakoune** – Martin Tournoij, contributors – [mawww/kakoune](https://github.com/mawww/kakoune)
- **Glow** – Charmbracelet – [charmbracelet/glow](https://github.com/charmbracelet/glow)
- **Micro** – Zachary Yedidia – [zyedidia/micro](https://github.com/zyedidia/micro)
- **nb (nb-preview/nbterm)** – Ichiro Hara (dalance) – [dalance/nb](https://github.com/dalance/nb)

### Package Managers & Build Tools

- **Pacman** – Arch Linux Team – [archlinux/pacman](https://gitlab.archlinux.org/pacman/pacman)
- **Yay** – Jguer – [Jguer/yay](https://github.com/Jguer/yay)
- **Apt, Dpkg** – Debian/Ubuntu maintainers – [debian/dpkg](https://salsa.debian.org/dpkg-team/dpkg)
- **Dnf / Yum** – Fedora, Red Hat – [rpm-software-management/dnf](https://github.com/rpm-software-management/dnf)
- **Zypper** – openSUSE Team – [openSUSE/zypper](https://github.com/openSUSE/zypper)
- **Apk** – Alpine Team – [alpinelinux/apk-tools](https://gitlab.alpinelinux.org/alpine/apk-tools)
- **Flatpak** – Alex Larsson/Red Hat – [flatpak/flatpak](https://github.com/flatpak/flatpak)
- **Snapd** – Canonical – [snapcore/snapd](https://github.com/snapcore/snapd)
- **Nix** – Domen Kožar et al – [NixOS/nix](https://github.com/NixOS/nix)
- **Homebrew** – Homebrew contributors – [Homebrew/brew](https://github.com/Homebrew/brew)
- **Macports** – MacPorts Team – [macports/macports-base](https://github.com/macports/macports-base)
- **Pip / Pipx / Pipenv** – PyPA – [pypa/pip](https://github.com/pypa/pip), [pipxproject/pipx](https://github.com/pipxproject/pipx), [pypa/pipenv](https://github.com/pypa/pipenv)
- **Cargo** – Rust Team – [rust-lang/cargo](https://github.com/rust-lang/cargo)
- **Gem** – Ruby community – [rubygems/rubygems](https://github.com/rubygems/rubygems)
- **Npm / Pnpm** – npm community – [npm/cli](https://github.com/npm/cli), [pnpm/pnpm](https://github.com/pnpm/pnpm)
- **Docker / Podman / Docker Compose** – [docker/compose](https://github.com/docker/compose), [containers/podman](https://github.com/containers/podman)
- **Dotnet** – Microsoft – [dotnet/core](https://github.com/dotnet/core)
- **GitHub CLI** – GitHub – [cli/cli](https://github.com/cli/cli)
- **Anaconda/Miniconda** – Continuum – [ContinuumIO/anaconda-issues](https://github.com/ContinuumIO/anaconda-issues)

### Utility, Network, Scripting, Data Tools

- **Btop** – Aristocratos – [aristocratos/btop](https://github.com/aristocratos/btop)
- **Fastfetch** – fastfetch-cli contributors – [fastfetch-cli/fastfetch](https://github.com/fastfetch-cli/fastfetch)
- **Ripgrep** – Andrew Gallant – [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)
- **Fd** – David Peter – [sharkdp/fd](https://github.com/sharkdp/fd)
- **Exa/Eza** – Benjamin Sago, eza community – [ogham/exa](https://github.com/ogham/exa), [eza-community/eza](https://github.com/eza-community/eza)
- **Bat** – David Peter – [sharkdp/bat](https://github.com/sharkdp/bat)
- **Hexyl** – David Peter – [sharkdp/hexyl](https://github.com/sharkdp/hexyl)
- **Less** – Mark Nudelman – [gwsw/less](https://github.com/gwsw/less)
- **Tree** – Steve Baker, Old-Man-Programmer – [Old-Man-Programmer/tree](https://github.com/Old-Man-Programmer/tree)
- **Ranger** – Roman Zimbelmann – [ranger/ranger](https://github.com/ranger/ranger)
- **Yazi** – YaZi contributors – [sxyazi/yazi](https://github.com/sxyazi/yazi)
- **Navi** – Denis Idoro – [denisidoro/navi](https://github.com/denisidoro/navi)
- **Pkgtop** – Aryan Saini – [AryanSaini121/pkgtop](https://github.com/AryanSaini121/pkgtop)
- **Reflector** – Xyne – [Xyne/reflector](https://github.com/Xyne/reflector)
- **Opendoas (Doas)** – Ted Unangst – [tedu/opendoas](https://github.com/Duncaen/OpenDoas)
- **Tmatrix** – Abishek Vashok – [abishekvashok/tmatrix](https://github.com/abishekvashok/tmatrix)
- **Lolcat** – Ruby community – [busyloop/lolcat](https://github.com/busyloop/lolcat)
- **Man-db** – Colin Watson – [man-db/man-db](https://gitlab.com/man-db/man-db)
- **Rmpc** – mierak – [mierak/rmpc](https://github.com/mierak/rmpc)
- **Yt-dlp** – yt-dlp contributors – [yt-dlp/yt-dlp](https://github.com/yt-dlp/yt-dlp)
- **Pygmentize** – Pygments Team – [pygments/pygments](https://github.com/pygments/pygments)
- **Ascii-image-converter** – TheZoraiz – [TheZoraiz/ascii-image-converter](https://github.com/TheZoraiz/ascii-image-converter)

### Wayland, Compositor & Desktop Tools

- **Hyprland** – Vaxry – [hyprwm/Hyprland](https://github.com/hyprwm/Hyprland)
- **Hypridle** – [hyprwm/hypridle](https://github.com/hyprwm/hypridle)
- **Hyprpicker** – [hyprwm/hyprpicker](https://github.com/hyprwm/hyprpicker)
- **Hyprplugins** – [hyprwm/hyprplugins](https://github.com/hyprwm/hyprplugins)
- **Hyprshot** – [hyprwm/hyprshot](https://github.com/hyprwm/hyprshot)
- **Fuzzel** – Christian M. Aagesen – [fuzzel-project/fuzzel](https://github.com/fuzzel-project/fuzzel)
- **Cliphist** – sentriz – [sentriz/cliphist](https://github.com/sentriz/cliphist)
- **wl-clipboard** – Aleksey Bugaev – [bugaevc/wl-clipboard](https://github.com/bugaevc/wl-clipboard)
- **Swww** – LG Fae – [LGFae/swww](https://github.com/LGFae/swww)
- **Ghostty** – Mitchell Hashimoto – [mitchellh/ghostty](https://github.com/mitchellh/ghostty)
- **Kitty** – Kovid Goyal – [kovidgoyal/kitty](https://github.com/kovidgoyal/kitty)
- **Playerctl** – Alec A. Criscuolo – [acrisci/playerctl](https://github.com/acrisci/playerctl)
- **JamesDSP** – Audio4Linux team – [Audio4Linux/JDSP4Linux](https://github.com/Audio4Linux/JDSP4Linux)
- **Dino** – Dino contributors – [dino/dino](https://github.com/dino/dino)
- **Rclone** – Nick Craig-Wood – [rclone/rclone](https://github.com/rclone/rclone)
- **Steam** – Valve – [ValveSoftware/steam-for-linux](https://github.com/ValveSoftware/steam-for-linux)
- **Exifaudio** – Spotlight0xff – [Spotlight0xff/exifaudio](https://github.com/Spotlight0xff/exifaudio)
- **Ouch** – Ouch contributors – [ouch-org/ouch](https://github.com/ouch-org/ouch)
- **DuckDB** – DuckDB Labs – [duckdb/duckdb](https://github.com/duckdb/duckdb)

### Windows, Cross-Platform & GUI Utilities

- **Chris Titus Tech's WinUtil** – Chris Titus – [ChrisTitusTech/winutil](https://github.com/ChrisTitusTech/winutil)
- **PowerShell** – Microsoft – [PowerShell/PowerShell](https://github.com/powershell/powershell)
- **Windhawk** – Roman Lebedev – [ramensoftware/windhawk](https://github.com/ramensoftware/windhawk)
- **Winaero Tweaker** – Sergey Tkachenko – [Winaero Tweaker](https://winaero.com)
- **WizTree** – Antibody Software – [AntibodySoftware/WizTree](https://github.com/AntibodySoftware/WizTree)
- **Zen Browser** – zenbrowser – [zenbrowser/zenbrowser](https://github.com/zenbrowser/zenbrowser)
- **NVCleanstall** – TechPowerUp – [techpowerup.com/download/techpowerup-nvcleanstall/](https://www.techpowerup.com/download/techpowerup-nvcleanstall/)
- **Playnite** – Josef Nemec – [JosefNemec/Playnite](https://github.com/JosefNemec/Playnite)
- **Epic Games Launcher** – Epic Games Inc. – [epicgames.com/store/en-US/download/epic-games-launcher](https://epicgames.com/store/en-US/download/epic-games-launcher)
- **GOG Galaxy** – GOG.com – [GOGcom/galaxy-integrations-python-api](https://github.com/GOGcom/galaxy-integrations-python-api)
- **ArchiSteamFarm** – JustArchi – [JustArchiNET/ArchiSteamFarm](https://github.com/JustArchiNET/ArchiSteamFarm)
- **Premid** – Timeraa et al – [Timeraa/PreMiD](https://github.com/Timeraa/PreMiD)
- **Rainmeter** – Rainmeter team – [rainmeter.net](https://www.rainmeter.net/)
- **Mica For Everyone** – MicaForEveryone team – [MicaForEveryone/MicaForEveryone](https://github.com/MicaForEveryone/MicaForEveryone)
- **Bitwarden** – Bitwarden Inc – [bitwarden/clients](https://github.com/bitwarden/clients)
- **MS Teams, Visual Studio, VSCode, Chocolatey, Scoop, OneDrive** – Microsoft, [microsoft.com](https://microsoft.com), [chocolatey.org](https://chocolatey.org), [scoop.sh](https://scoop.sh)
- **Ollama** – Ollama contributors – [ollama/ollama](https://github.com/ollama/ollama)
- **Xemu** – [mborgerson/xemu](https://github.com/mborgerson/xemu)
- **File Converter** – Adrien Allard – [AdrienAllard/FileConverter](https://github.com/AdrienAllard/FileConverter)
- **Bulk Crap Uninstaller** – Klocman – [Klocman/Bulk-Crap-Uninstaller](https://github.com/Klocman/Bulk-Crap-Uninstaller)
- **Flow Launcher** – Flow-Launcher contributors – [Flow-Launcher/Flow.Launcher](https://github.com/Flow-Launcher/Flow.Launcher)
- **WiseToys** – WiseToys Team – [WiseUncle/WiseToys](https://github.com/WiseUncle/WiseToys)
- **EarthPro** – Google Inc – [EarthPro](https://www.google.com/earth/versions/#earth-pro)
- **Scrcpy** – Genymobile – [Genymobile/scrcpy](https://github.com/Genymobile/scrcpy)
- **OpenRGB** – Adam Honse – [AdamHonse/OpenRGB](https://github.com/AdamHonse/OpenRGB)
- **DevToys** – DevToys team – [DevToysApp/DevToys](https://github.com/DevToysApp/DevToys)
- **Godot Engine** – Godot Team – [godotengine/godot](https://github.com/godotengine/godot)
- **Prism Launcher** – Prism Launcher Team – [PrismLauncher/PrismLauncher](https://github.com/PrismLauncher/PrismLauncher)
- **Ventoy** – longpanda – [ventoy/Ventoy](https://github.com/ventoy/Ventoy)
- **Discord** – Discord, Inc. – [discord.com](https://discord.com/)
- **Telegram** – Telegram Messenger LLP – [telegram.org](https://telegram.org/)
- **Spotify** – Spotify AB – [spotify.com](https://www.spotify.com/)
- **Jq** – Stephen Dolan – [stedolan/jq](https://github.com/stedolan/jq)

---

_If you are the author of any tool/config/snip used here and wish a correction or further explicit attribution, please [open an issue or pull request](https://github.com/sametaor/sametaor_CLIconfig/issues) and you will be credited transparently. This repository is a personal reference implementation, not a redistribution, and does not claim ownership over any listed tool or script._
