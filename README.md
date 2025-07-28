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

### 📋 Essential Requirements

#### ✅ Core System Tools

| Tool             | Linux (Distro-specific)                 | Windows                          | Android/Termux                  |
|------------------|-----------------------------------------|----------------------------------|----------------------------------|
| Git              | `apt/yum/pacman`                        | Git for Windows, Chocolatey      | `pkg install git`                |
| Terminal Emulator| GNOME Terminal, Konsole, Alacritty, etc | Windows Terminal, PowerShell     | Native Termux / Termux:API       |
| Text Editor      | Neovim, Nano, Emacs, VSCode             | VSCode, Notepad++, Nano          | Vim, Neovim                      |

### 🐧 Linux-Specific Prerequisites

#### Distro Subclassifications

**Arch Linux**
- Zsh: `sudo pacman -S zsh`
- bat: `sudo pacman -S bat`
- exa: `sudo pacman -S exa`
- fd: `sudo pacman -S fd`
- ripgrep: `sudo pacman -S ripgrep`
- fzf: `sudo pacman -S fzf`
- tmux: `sudo pacman -S tmux`
- Others: htop, neofetch, kitty, yazi, nvim, doom-emacs, ghostty, cava, fastfetch (`sudo pacman -S <tool>` or AUR as needed)

**Ubuntu/Debian**
- Zsh: `sudo apt install zsh`
- bat: `sudo apt install bat` *(might be batcat)*
- exa: `sudo apt install exa` (22.04+) or Github
- fd-find: `sudo apt install fd-find` *(alias fd='fdfind')*
- ripgrep: `sudo apt install ripgrep`
- fzf: `sudo apt install fzf`
- tmux: `sudo apt install tmux`
- Others as above (`sudo apt install <tool>` when available)

**Fedora**
- Use `dnf install` for above tools.

**NixOS**
- Use `nix-env -iA nixos.<toolname>` for above.

#### General:
- bash (default almost everywhere)
- zsh + Oh My Zsh: (`sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`)
- tree, curl/wget, nodejs, python3, yazi (AUR), doom-emacs (manual), hyprland (AUR or manual)
- Systemd, tmux, neovim, kitty, ghostty, jamesdsp (AUR), fastfetch

### 🪟 Windows-Specific Prerequisites

- PowerShell 7+ (winget or Chocolatey)
- Windows Terminal (Store or package managers)
- Chocolatey/winget for package management
- WSL (optional)
- Registry tweaks: regconfig.reg
- UI customization: Windhawk, .json mod files
- VMware VM configs for legacy Windows (optional)
- Utility scripts: post_install_steps.ps1, HyperV_on_HomeEdition.bat, winutilconfig.json, startlayout.json
- Package installations: (bat, fd, fzf, ripgrep, nodejs, python, yazi, nvim, etc) see wingetinstall.json and use `winget` or `choco`
- Python3, Node.js, Yazi: All via package manager
- Neovim and Doom Emacs: via Scoop or manual
- Spicetify: via `winget install spicetify-cli` or manual

### 🤖 Android/Termux-compatible Tools

| Tool        | Termux/Android CLI Equivalent                |
|-------------|---------------------------------------------|
| git         | `pkg install git`                            |
| bash        | Native (default)                             |
| zsh         | `pkg install zsh`                            |
| oh-my-zsh   | Manual install via curl                      |
| vim         | `pkg install vim`                            |
| neovim      | `pkg install neovim`                         |
| fd          | `pkg install fd`                             |
| ripgrep     | `pkg install ripgrep`                        |
| fzf         | `pkg install fzf`                            |
| bat         | `pkg install bat`                            |
| htop        | `pkg install htop`                           |
| tree        | `pkg install tree`                           |
| tmux        | `pkg install tmux`                           |
| exa/eza     | **Not available** (lsd may be but not eza)   |
| zoxide      | `pkg install zoxide`                         |
| fastfetch   | `pkg install fastfetch`                      |
| neofetch    | `pkg install neofetch`                       |
| **Not Supported:** GUI/Wayland/desktop, btop, ghostty, hyprland, yazi, doom-emacs, jamesdsp, cava, spicetify (unsupported platform) |

*Note: Only standard CLI tools are usable in Termux/Android. Anything needing Linux kernel features, X11/Wayland, systemd, or desktop-level dependencies won't work.*

## Credits

This configuration draws on and credits the following projects, repositories, and communities. If you use or contribute, please check upstream licenses and attributions.

- **btop config:** Based on [aristocratos/btop](https://github.com/aristocratos/btop) (MIT License)
- **Doom Emacs config:** Inspired by [hlissner/doom-emacs](https://github.com/hlissner/doom-emacs), as well as other public dotfiles like [danilevy1212/doom](https://github.com/danilevy1212/doom)
- **Hyprland configs:** Built referencing [hyprland-community/awesome-hyprland](https://github.com/hyprland-community/awesome-hyprland), dotfiles like [JaKooLit/Hyprland-Dots](https://github.com/JaKooLit/Hyprland-Dots)
- **Neovim config:** Inspired by [jdhao/nvim-config](https://github.com/jdhao/nvim-config), [chadcat/chad.nvim](https://github.com/chadcat/chad.nvim)
- **Kitty config:** Derived from [kovidgoyal/kitty](https://github.com/kovidgoyal/kitty) and community inspiration
- **Tmux config:** Modeled after [tmux/tmux](https://github.com/tmux/tmux) and open dotfile best practices
- **Zsh + Oh My Zsh:** Built atop [ohmyzsh/ohmyzsh](https://github.com/ohmyzsh/ohmyzsh); plugin credits to their authors
- **Cava configs:** Based on [karlstav/cava](https://github.com/karlstav/cava)
- **Spicetify configs:** Credits to [spicetify/spicetify-cli](https://github.com/spicetify/spicetify-cli), [Daksh777/SpotifyNoPremium](https://github.com/Daksh777/SpotifyNoPremium)
- **Dynamic wallpaper scripts:** Custom, but design aligns with common Hyprland/Swaybar ecosystem patterns
- **Arch update script:** Aggregates logic from ArchWiki and AUR helper documentation
- **PowerShell macros/profile:** Includes elements based on [janDeDobbeleer/oh-my-posh](https://github.com/janDeDobbeleer/oh-my-posh), and various community functions/aliases (see profile headers for specific notes)
- **Windows tuning/configs:** Windhawk mod configs reference [RamenSoftware/Windhawk](https://github.com/RamenSoftware/Windhawk), and utilize open-source snippets and schemas from the Windows community
- **Spotify/Spicetify skins:** Draw on preset community themes/skins
- **General**: Many settings and snippets inspired by open dotfiles shared in the Linux, Windows, and developer communities

For further credit needs or missing attribution, please open an issue or PR.
