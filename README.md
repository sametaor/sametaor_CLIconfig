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
├── linux/                    # Linux-specific dotfiles, shell scripts, and setup instructions
│   ├── .bashrc            # Shell and application configuration files
│   ├── .config          # Bash shell configuration
│   │   ├── zsh           # Zsh shell configuration
│   │   ├── nvim           # Vim editor configuration
│   │   ├── tmux       # Tmux terminal multiplexer config
│   │   └── 
├── windows/                 # PowerShell scripts, Windows terminal configs, VMWare profiles
│   ├── dotfiles/            # Windows configuration files
│   │   ├── Microsoft.PowerShell_profile.ps1  # PowerShell profile
│   │   ├── settings.json    # Windows Terminal settings
│   │   └── .gitconfig       # Git configuration for Windows
│   ├── scripts/             # PowerShell automation scripts
│   │   ├── Setup.ps1        # Main Windows setup script
│   │   ├── Install-Tools.ps1 # Package installation via winget/choco
│   │   └── Backup-Config.ps1 # Configuration backup utility
│   └── configs/             # Application configurations
│       ├── vscode/          # Visual Studio Code settings
│       ├── wsl/             # Windows Subsystem for Linux configs
│       └── terminal/        # Windows Terminal themes and profiles
├── misc/                    # Cross-platform tools, scripts, or configs not specific to one OS
│   ├── themes/              # Color schemes and visual themes
│   │   ├── dracula/         # Dracula theme variants
│   │   ├── gruvbox/         # Gruvbox theme variants
│   │   └── nord/            # Nord theme variants
│   ├── fonts/               # Programming fonts and configurations
│   │   ├── nerd-fonts/      # Patched fonts with icons
│   │   └── install-fonts.sh # Font installation script
│   └── common/              # Shared configuration snippets
│       ├── aliases.txt      # Common shell aliases
│       ├── functions.txt    # Reusable shell functions
│       └── exports.txt      # Environment variable exports
├── LICENSE
├── README.md                # (this file)
└── .gitignore
```

## General Concepts
- **Dotfiles**—Hidden configuration files (`.bashrc`, `.zshrc`, etc.) that control the behavior of your shell, editors, and CLI environments.
- **Portable scripts**—Reusable scripts for automating setup, installation, and environment bootstrapping.
- **Consistency and extensibility**—Create a base experience that you can further tweak per-device or future OS additions.

## Getting Started

## Prerequisites
Below is a categorized, collapsible "cheat sheet" of every essential tool, covering **all major Linux distros** and **Windows/Android** platforms. If a distro or platform doesn't offer the tool, it is marked "Manual" or "Not applicable". Every line includes a description for quick scanning.

<details>
<summary><strong>🔧 System Tools & Shells</strong></summary>

| Tool                                                  | Description                                           | Arch (Pacman/yay)                                                           | Ubuntu/Debian (apt)                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Fedora/RHEL (dnf5/dnf/yum)                                                                                                                                                                                                                                                                                      | openSUSE (zypper)                                                                                                                                                                                                         | Alpine (apk)                                                                                          | NixOS (nix-env)                                                                                                                        | Gentoo (emerge)                                                                                                                                                                               | Windows (winget/scoop/choco)                                                                                           | Android/Termux                                                                                                   | Flatpak                                      | Void Linux (Xbps)                                                                                                |
|-------------------------------------------------------|-------------------------------------------------------|-----------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|----------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| Bash                                                  | Unix shell                                            | `sudo pacman -S bash`/`yay -S bash-git`                                     | `sudo apt install bash`                                                                                                                                                                                                                                                                                                                                                                                                                                                      | `sudo dnf5 install bash`                                                                                                                                                                                                                                                                                        | `sudo zypper install bash`                                                                                                                                                                                                | `apk add bash`                                                                                        | `nix-env -iA nixpkgs.bash`                                                                                                             | `emerge -a app-shells/bash`                                                                                                                                                                   | Default/MSYS2/`winget install MSYS2.MSYS2; pacman -S bash`                                                             | `pkg install bash`                                                                                               | N/A                                          | `sudo xbps-install bash`                                                                                         |
</details>
