local theme = {
  fill = { fg = "#E6EDF3", bg = "#1B1D2B" },
  -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
  head = { fg = "#E6EDF3", bg = "#619D3D", style = "italic" },
  current_tab = { fg = "#0077C2", bg = "#FBFBFB", style = "bold" },
  tab = { fg = "#FBFBFB", bg = "#0077C2" },
  win = { fg = "#000000", bg = "#7700FF" },
  tail = { fg = "#E6EDF3", bg = "#0F4A74" },
}

return {
  "nanozuki/tabby.nvim",
  -- event = 'VimEnter', -- if you want lazy load, see below
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("tabby").setup({
      line = function(line)
        return {
          {
            { "  ", hl = theme.head },
            line.sep("┄", theme.head, theme.fill),
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.tab
            return {
              line.sep("", hl, theme.fill),
              tab.is_current() and "" or "󱃲",
              tab.number(),
              "",
              tab.name(),
              "",
              tab.close_btn("󰖭"),
              line.sep("┄", hl, theme.fill),
              hl = hl,
              margin = " ",
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
              line.sep("", theme.win, theme.fill),
              win.is_current() and "󰋁" or "󰂵",
              "",
              win.buf_name(),
              line.sep("", theme.win, theme.fill),
              hl = theme.win,
              margin = " ",
            }
          end),
          {
            line.sep("", theme.tail, theme.fill),
            { "  ", hl = theme.tail },
          },
          hl = theme.fill,
        }
      end,
      option = {
        buf_name = {
          mode = "relative",
        },
      }, -- setup modules' option,
    })
  end,
}
