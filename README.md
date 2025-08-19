# sametaor_CLIconfig

This repository serves as a unified, version-controlled collection of **dotfiles and environment configuration scripts** for a variety of operating systems and platforms. Its primary goal is to **streamline the process of setting up a personalized, consistent, and productivity-focused user shell/CLI experience** across:
- **Linux**
- **Windows**
- (*Future support*) **macOS**
- (*Planned*) **Android**

## Purpose
- **Centralized management:** Keep all sorts of CLI and environment configs in one place for backup, syncing, and migration.
- **Cross-platform productivity:** Port finely-tuned environment, aliases, functions, and tool preferences to any supported OS.
- **Rapid onboarding:** New or freshly-installed systems can be brought up to speed fast, reducing setup friction and human error.

## Table of Contents

- [sametaor_CLIconfig](#sametaor_cliconfig)
- [Purpose](#purpose)
- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Credits](#credits)

## Repository Structure

<details>
<summary><strong> Click here! </strong></summary>

```
sametaor_CLIconfig/
├── .gitignore
├── LICENSE
├── README.md
├── linux
│   ├── .bashrc
│   └── .config
│       ├── btop
│       ├── doom
│       ├── fastfetch
│       ├── ghostty
│       ├── hypr
│       ├── jamesdsp
│       ├── kitty
│       ├── kwinrc
│       ├── nvim
│       ├── rmpc
│       ├── systemd
│       ├── tmux
│       ├── yazi
│       └── zsh
├── misc
│   ├── Deus_Ex_Mankind_Divided_Background_Titan_Wave.jpg
│   ├── HyprBibataModernClassicSVG.tar.gz
│   ├── Scripts
│   │   ├── DynWalls
│   │   └── Utils
│   ├── Windows_3D_Emoji_14+15.ttf
│   ├── ascii-neovim-logos.txt
│   ├── cava.sh
│   ├── sametaor.omp.json
│   ├── spicetify_lucid_theme_settings.json
│   ├── titan_aug.mp4
│   └── zen-themes-export.json
└── windows
    ├── HyperV_on_HomeEdition.bat
    ├── Microsoft.PowerShell_profile.ps1
    ├── Virt_machines
    │   └── VMWare
    ├── Windhawk mod configs
    │   ├── Slick_Window_Arrangement.yaml
    │   ├── Taskbar_Button_Scroll.yaml
    │   ├── Taskbar_Clock_Customization.yaml
    │   ├── Taskbar_Volume_Control.yaml
    │   ├── Taskbar_Wheel_Cycle.yaml
    │   ├── Taskbar_tray_icon_spacing_and_grid.yaml
    │   ├── Translucent_Windows.yaml
    │   ├── Win11_File_Explorer_Styler.yaml
    │   ├── Windows_11_Notification_Center_Styler.yaml
    │   ├── Windows_11_Start_Menu_Styler.yaml
    │   └── Windows_11_Taskbar_Styler.yaml
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
</details>

## Prerequisites
A categorized, collapsible "cheat sheet" of every essential tool, covering **all major Linux distros** and **Windows/Android** platforms is present under the [Prerequisites Wiki Page](https://github.com/sametaor/sametaor_CLIconfig/wiki/Prerequisites). If a distro or platform doesn't offer the tool, it is marked "Manual" or "Not applicable". Every line includes a description for quick scanning.

> **Note:**
> Some tools are only available through secondary means such as `pip`, `cargo`, `gem`, or manual download from their official website or GitHub releases. If a tool is not available through your platform’s main package manager, refer to the corresponding “Manual”, “GitHub”, or language-specific package column, or check the official project documentation for installation instructions. Some Windows utilities (like Windhawk, Zen Browser, EFI Boot Editor, etc.) require manual installation. Platform-specific or feature-only tools may also require dedicated setup outside package management systems.

## Credits

_All software, scripts, and config seeds referenced in this repository are the intellectual property of their respective authors and maintainers. Their generosity and effort enable this repo's cross-platform CLI and customization curation._

_The credits are duly mentioned under the [CREDITS.md](https://github.com/sametaor/sametaor_CLIconfig/blob/master/CREDITS.md) document._

_If you are the author of any tool/config/snip used here and wish a correction or further explicit attribution, please [open an issue or pull request](https://github.com/sametaor/sametaor_CLIconfig/issues) and you will be credited transparently. This repository is a personal reference implementation, not a redistribution, and does not claim ownership over any listed tool or script._
