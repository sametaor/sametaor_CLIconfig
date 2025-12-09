
# Neovim Configuration

This is a Neovim configuration built on top of [LazyVim](https://www.lazyvim.org/).

## Installation

### Prerequisites

1. Install [Neovim](https://github.com/neovim/neovim/releases) (v0.9+)
2. Install [LazyVim](https://www.lazyvim.org/installation)

### Setup This Config

Clone this repository into your Neovim config directory:

```bash
git clone https://www.github.com/sametaor/sametaor_CLIconfig.git ~/prog
cd prog
cp -r ./.config/nvim ~/.config
```

Then start Neovim. Lazy.nvim will automatically install all plugins.

## Plugins

This configuration includes the following plugins (managed by [lazy.nvim](https://github.com/folke/lazy.nvim)):
- roobert/activate.nvim
- Pocco81/auto-save.nvim
- doctorfree/cheatsheet.nvim
- vyfor/cord.nvim
- nvimdev/dashboard-nvim
- Bekaboo/dropbar.nvim
- maxmx03/fluoromachine.nvim
- notomo/gesture.nvim
- barrett-ruth/live-server.nvim
- nvim-lualine/lualine.nvim
- OXY2DEV/markview.nvim
- nvim-mini/mini.animate
- nvim-neo-tree/neo-tree.nvim
- nvim-neorg/neorg
- rose-pine/neovim
- folke/noice.nvim
- hrsh7th/nvim-cmp
- rcarriga/nvim-notify
- petertriho/nvim-scrollbar
- sphamba/smear-cursor.nvim
- nanozuki/tabby.nvim
- nvim-telescope/telescope-media-files.nvim
- LukasPietzschmann/telescope-tabs
- nvim-telescope/telescope.nvim
- rachartier/tiny-code-action.nvim
- TobinPalmer/Tip.nvim
- akinsho/toggleterm.nvim
- folke/tokyonight.nvim
- jiaoshijie/undotree
- wakatime/vim-wakatime
- ragnarok22/whereami.nvim
- mikavilpas/yazi.nvim
- folke/zen-mode.nvim

## Features
- **Editor**: Core editing enhancements
- **LSP**: Language Server Protocol support
- **Completion**: Autocompletion and snippets
- **Treesitter**: Syntax highlighting and parsing
- **Telescope**: Fuzzy finder
- **Git**: Git integration
- **UI**: Interface improvements

> **Note**: For detailed plugin specifications, see `lua/plugins/` directory.

## Configuration

Customize settings in `lua/config/options.lua` and keymaps in `lua/config/keymaps.lua`.