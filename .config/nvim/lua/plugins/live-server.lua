return {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServer", "LiveServerStop", "LiveServerStart" },
  config = function()
    require("live-server").setup()
  end,
}
