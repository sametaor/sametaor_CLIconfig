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
sametaor_CLIconfig
├── .gitignore
├── android
│   └── data
│       └── data
│           └── com.termux
│               └── files
├── CREDITS.md
├── LICENSE
├── linux
│   ├── ArchLinux
│   │   └── home
│   │       └── sametaor
│   │           ├── .bashrc
│   │           ├── .config
│   │           ├── .profile
│   │           └── ble-nightly
│   └── NixOS
│       └── home
│           └── sametaor
│               └── .config
├── macos
│   ├── .DS_Store
│   ├── etc
│   │   ├── zprofile
│   │   ├── zshenv
│   │   └── zshrc
│   ├── README.md
│   └── Users
│       ├── .DS_Store
│       └── sametaor
│           ├── .bashrc
│           ├── .config
│           │   ├── .DS_Store
│           │   ├── apple_terminal
│           │   ├── bash
│           │   ├── btop
│           │   ├── cava
│           │   ├── eza
│           │   ├── fastfetch
│           │   ├── fish
│           │   ├── fzf
│           │   ├── ghostty
│           │   ├── hoard
│           │   ├── lexy
│           │   ├── mpd
│           │   ├── nvim
│           │   ├── ripgrep
│           │   ├── rmpc
│           │   ├── sc-im
│           │   ├── television
│           │   ├── topgrade.toml
│           │   ├── tracker
│           │   ├── xleak
│           │   ├── yazi
│           │   └── zsh
│           ├── .DS_Store
│           ├── .profile
│           └── Library
│               ├── .DS_Store
│               ├── 'Application Support'
│               └── LaunchAgents
├── misc
│   ├── Deus_Ex_Mankind_Divided_Background_Titan_Wave.jpg
│   ├── sametaor.omp.json
│   ├── Scripts
│   │   ├── DynWalls
│   │   │   ├── scripts
│   │   │   │   ├── switchwalla.sh
│   │   │   │   ├── switchwallb.sh
│   │   │   │   ├── switchwallc.sh
│   │   │   │   └── switchwalld.sh
│   │   │   └── walls
│   │   │       ├── Windows_11_Rise_&_Fall_a.jpg
│   │   │       ├── Windows_11_Rise_&_Fall_b.jpg
│   │   │       ├── Windows_11_Rise_&_Fall_c.jpg
│   │   │       └── Windows_11_Rise_&_Fall_d.jpg
│   │   └── Utils
│   │       └── archup.sh
│   └── titan_aug.mp4
└── README.md
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
