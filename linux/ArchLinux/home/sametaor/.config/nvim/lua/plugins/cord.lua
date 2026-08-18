return {
  "vyfor/cord.nvim",
  build = ":Cord update",
  editor = {
    client = "neovim",
    tooltip = "I use Neovim, btw",
  },
  display = {
    theme = "catpuccin",
    flavor = "dark",
    view = "auto",
  },
  timestamp = {
    reset_on_idle = true,
    reset_on_change = true,
    shared = true,
  },
  idle = {
    tooltip = "His ahh is NOT programming",
  },
  buttons = {
    {
      label = function(opts)
        return opts.repo_url and "View Repo" or "Website"
      end,
      url = function(opts)
        return opts.repo_url or "https://sametaor.vercel.app"
      end,
    },
  },
}
