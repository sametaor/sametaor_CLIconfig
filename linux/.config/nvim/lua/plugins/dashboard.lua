return {
  "nvimdev/dashboard-nvim",
  opts = {
    theme = "hyper",
    disable_move = true, --  default is false disable move keymap for hyper
    shortcut_type = "number", --  shorcut type 'letter' or 'number'
    buffer_name = "SaVim",
    shuffle_letter = false, --  default is true, shortcut 'letter' will be randomize, set to false to have ordered letter.
    change_to_vcs_root = false, -- default is false,for open file in hyper mru. it will change to the root of vcs
    config = {
      shortcut = {
        { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
        { desc = " New", group = "Label", action = "ene | startinsert", key = "n" },
        {
          desc = "  Config",
          group = "Constant",
          action = "lua LazyVim.pick.config_files()()",
          key = "c",
        },
        {
          desc = "󰁯 Resume",
          group = "@comment.info",
          action = 'lua require("persistence").load()',
          key = "s",
        },
        { desc = "󰒲  Lazy", group = "@character.special", action = "Lazy", key = "l" },
        { desc = "  Mason", group = "@comment.warning", action = "Mason", key = "m" },
        { desc = "󰿅 Quit", group = "@comment.error", action = "qa", key = "q" },
      },
      header = {
        [[▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄]],
        [[█ / __ \ \__/ / __ \ \__/ / __ \ \__/ / __ \ \__/ / __ \ \__/ / █]],
        [[█/ /  \ \____/ /  \ \____/ /  \ \____/  \ \____/ /  \ \____/ /█]],
        [[█\ \__/███████████/ __ █████/ __ \██/ / __ \ \__/ / __ \ \█]],
        [[█ \___███  \████ /  \ █████/ \ \____/ /  \ \____/ /  \ \ █]],
        [[█ / _████__/ /   \█████████████ ███ \ ███████████/ / █]],
        [[█/ / ███████████ ██_██████████ █████ ██████████████_/ /█]],
        [[█\ \__/ / __██████__ █████████ █████ █████ ████ █████ \ \█]],
        [[█ \████/  ██████  \█████████ █████ █████ ████ █████ \ █]],
        [[█ /███████████/████████████████ █████ █████ ████ ██████/ █]],
        [[█/ /  \ \____/ /  \ \____/ /  \ \____/ /  \ \____/ /  \ \____/ /█]],
        [[▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀]],
        [[                                                                 ]],
        " " .. os.date("%A, %d-%m-%y | %H:%M"),
        [[                                                                 ]],
        [[╭╼━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 󰫃 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╾╮]],
        [[]],
      },
      week_header = { enable = false },
      packages = { enable = true }, -- show how many plugins neovim loaded
      project = { enable = true, limit = 5, icon = " ", label = "Projects", action = "Telescope find_files cwd=" },
      mru = { limit = 10, icon = " ", label = "Recently Opened", cwd_only = false },
      footer = {
        [[]],
        [[Powered by  NeoVim]],
        [[]],
        [[╰╼━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 󰫆 ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╾╯]],
      },
    },
    hide = {
      statusline = false, -- hide statusline default is true
      tabline = true, -- hide the tabline
      winbar = true, -- hide winbar
    },
  },
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
