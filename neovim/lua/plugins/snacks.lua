local dashboard = require("plugins.snacks.dashboard")
local indent = require("plugins.snacks.indent")
local lazygit = require("plugins.snacks.lazygit")
local notifier = require("plugins.snacks.notifier")
local picker = require("plugins.snacks.picker")

local modules = {
  dashboard = dashboard,
  indent = indent,
  lazygit = lazygit,
  notifier = notifier,
  picker = picker,
  scroll = { opts = {} },
  statuscolumn = { opts = {} },
}

local function get_keys(_, module)
  return module.keys
end

local function get_opts(module_name, module)
  return { [module_name] = module.opts }
end

local function merge_opts(...)
  return vim.tbl_extend("force", ...)
end

return {
  "folke/snacks.nvim",
  version = "2.20.0",
  priority = 1000,
  lazy = false,
  keys = vim.iter(vim.iter(modules):map(get_keys):totable()):flatten():totable(),
  opts = vim.iter(modules):map(get_opts):fold({}, merge_opts),
}
