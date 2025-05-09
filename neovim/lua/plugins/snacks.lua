local dashboard = require("plugins.snacks.dashboard")
local indent = require('plugins.snacks.indent')
local lazygit = require("plugins.snacks.lazygit")
local picker = require('plugins.snacks.picker')

return {
  "folke/snacks.nvim",
  version = "2.20.0",
  keys = picker.keys,
  ---@type snacks.Config
  opts = {
    dashboard = dashboard.opts,
    indent = indent.opts,
    lazygit = lazygit.opts,
  },
}
