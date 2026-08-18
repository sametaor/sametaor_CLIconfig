-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.number = true

vim.opt.relativenumber = true

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.signcolumn = "yes"

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 250

vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.inccommand = "split"

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.o.showtabline = 2

vim.opt.sessionoptions = "curdir,folds,globals,help,tabpages,terminal,winsize"

vim.opt.hlsearch = true
