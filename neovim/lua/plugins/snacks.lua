return {
  "folke/snacks.nvim",
  version = "2.20.0",
  ---@type snacks.Config
  opts = {
    dashboard = require("plugins.snacks.dashboard"),
    lazygit = require("plugins.snacks.lazygit"),
  },
}
