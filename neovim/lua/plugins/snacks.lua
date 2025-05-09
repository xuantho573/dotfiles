local dashboard = require("plugins.snacks.dashboard")
local lazygit = require("plugins.snacks.lazygit")

return {
  "folke/snacks.nvim",
  version = "2.20.0",
  ---@type snacks.Config
  opts = {
    dashboard = dashboard.opts,
    lazygit = lazygit.opts,
  },
}
