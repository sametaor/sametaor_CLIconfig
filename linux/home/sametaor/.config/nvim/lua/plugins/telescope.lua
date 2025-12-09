return {
  "nvim-telescope/telescope.nvim",
  config = function()
    require("telescope").setup({
      extensions = {
        media_files = {
          -- filetypes whitelist
          -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
          filetypes = { "png", "webp", "jpg", "jpeg" },
          -- find command (defaults to `fd`)
          find_cmd = "rg",
        },
      },
      pickers = {
        colorscheme = {
          enable_preview = true,
        },
      },
    })
  end,
}
