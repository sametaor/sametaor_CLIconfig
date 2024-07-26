return {
  "nvim-neorg/neorg",
  lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
  version = "*", -- Pin Neorg to the latest stable release
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.completion"] = { config = { engine = "nvim-cmp" } },
        ["core.concealer"] = {
          config = {
            folds = true,
            icon_preset = "varied",
            init_open_folds = "auto",
          },
        },
        ["core.dirman"] = {
          config = {
            workspaces = {
              neotes = "~/notes",
              neorticles = "~/articles",
            },
            index = "index.norg",
          },
        },
        ["core.export"] = { config = { export_dir = "~/neorgdir" } },
        ["core.export.markdown"] = {
          config = {
            extensions = "all",
          },
        },
        ["core.latex.renderer"] = {},
        ["core.presenter"] = {
          config = {
            zen_mode = "zen-mode",
          },
        },
        ["core.summary"] = {},
        ["core.text-objects"] = {},
        ["core.autocommands"] = {},
        ["core.clipboard"] = {},
        ["core.dirman.utils"] = {},
        ["core.fs"] = {},
        ["core.highlights"] = {},
        ["core.integrations.nvim-cmp"] = {},
        ["core.integrations.treesitter"] = {
          config = {
            configure_parsers = true,
            install_parsers = true,
          },
        },
        ["core.neorgcmd"] = {},
        ["core.storage"] = {},
        ["core.syntax"] = {},
        ["core.tempus"] = {},
      },
    })
  end,
}
