return {
  {
    "nvim-neorg/neorg",
    dependencies = {
      {
        "nvim-neorg/tree-sitter-norg",
        build = {
          "rockspec",
          function()
            local from = vim.fn.stdpath("data") .. "/lazy-rocks/tree-sitter-norg/lib/lua/5.1/parser/norg.so"
            local to = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser/norg.so"
            vim.fn.mkdir(vim.fn.fnamemodify(to, ":p:h"), "p")

            local ok, err, err_name = vim.uv.fs_copyfile(from, to)
            if not ok then
              vim.notify(
                ("copy %s to %s failed for %s %s"):format(from, to, err, err_name),
                vim.log.levels.ERROR,
                { title = "tree-sitter-norg" }
              )
            else
              vim.notify(
                ("copy %s to %s success"):format(from, to),
                vim.log.levels.INFO,
                { title = "tree-sitter-norg" }
              )
            end
          end,
        },
      },
    },
    lazy = false,
    opts = {},
  },
}
