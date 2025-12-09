return {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
        {"nvim-lua/plenary.nvim"},
        -- optional picker via telescope
        {"nvim-telescope/telescope.nvim"},
        -- optional picker via fzf-lua
        {"ibhagwan/fzf-lua"},
        -- .. or via snacks
        {
          "folke/snacks.nvim",
          opts = {
            terminal = {},
          }
        }
    },
    event = "LspAttach",
    opts = {
        -- available backends: vim, delta (install dandavison/delta), difftastic, diffsofancy
        backend = "vim",
        -- available pickers: telescope, snacks, select (fzf-lua), buffer
        picker = "buffer",
            opts = {
                hotkeys = true,
                hotkeys_mode = "text_diff_based",
                auto_preview = true,
                auto_accept = false,
                position = "cursor",
                winborder = "rounded",
                custom_keys = {
                    { key = 'm', pattern = 'Fill match arms' },
                    { key = 'r', pattern = 'Rename.*' },
                    { key = 'e', pattern = 'Extract Method' },
                }
            },
        signs = {
            quickfix = { "", { link = "DiagnosticWarning" } },
            others = { "", { link = "DiagnosticWarning" } },
            refactor = { "", { link = "DiagnosticInfo" } },
            ["refactor.move"] = { "󰪹", { link = "DiagnosticInfo" } },
            ["refactor.extract"] = { "", { link = "DiagnosticError" } },
            ["source.organizeImports"] = { "", { link = "DiagnosticWarning" } },
            ["source.fixAll"] = { "󰃢", { link = "DiagnosticError" } },
            ["source"] = { "", { link = "DiagnosticError" } },
            ["rename"] = { "󰑕", { link = "DiagnosticWarning" } },
            ["codeAction"] = { "", { link = "DiagnosticWarning" } },
        },
    },
}