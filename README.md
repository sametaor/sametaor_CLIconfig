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
├── .gitignore
├── LICENSE
├── README.md
├── linux
│   ├── .bashrc
│   └── .config
│       ├── btop
│       ├── doom
│       ├── fastfetch
│       ├── ghostty
│       ├── hypr
│       ├── jamesdsp
│       ├── kitty
│       ├── kwinrc
│       ├── nvim
│       ├── rmpc
│       ├── systemd
│       ├── tmux
│       ├── yazi
│       └── zsh
├── misc
│   ├── Deus_Ex_Mankind_Divided_Background_Titan_Wave.jpg
│   ├── HyprBibataModernClassicSVG.tar.gz
│   ├── Scripts
│   │   ├── DynWalls
│   │   └── Utils
│   ├── Windows_3D_Emoji_14+15.ttf
│   ├── ascii-neovim-logos.txt
│   ├── cava.sh
│   ├── sametaor.omp.json
│   ├── spicetify_lucid_theme_settings.json
│   ├── titan_aug.mp4
│   └── zen-themes-export.json
└── windows
    ├── HyperV_on_HomeEdition.bat
    ├── Microsoft.PowerShell_profile.ps1
    ├── Virt_machines
    │   └── VMWare
    ├── Windhawk mod configs
    │   ├── Slick_Window_Arrangement.yaml
    │   ├── Taskbar_Button_Scroll.yaml
    │   ├── Taskbar_Clock_Customization.yaml
    │   ├── Taskbar_Volume_Control.yaml
    │   ├── Taskbar_Wheel_Cycle.yaml
    │   ├── Taskbar_tray_icon_spacing_and_grid.yaml
    │   ├── Translucent_Windows.yaml
    │   ├── Win11_File_Explorer_Styler.yaml
    │   ├── Windows_11_Notification_Center_Styler.yaml
    │   ├── Windows_11_Start_Menu_Styler.yaml
    │   └── Windows_11_Taskbar_Styler.yaml
    ├── Windows_7x11.png
    ├── Windows_7x11ALT.png
    ├── Windows_7x11ALT_lockscr.png
    ├── autounattend.xml
    ├── post_install_steps.ps1
    ├── regconfig.reg
    ├── startlayout.json
    ├── unattend.iso
    ├── wingetinstall.json
    └── winutilconfig.json
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
