local submodules = require("utils.load-submodules")("snacks")

local function get_keys(_, submodule)
  return submodule.keys
end

local function get_opts(submodule_name, submodule)
  return { [submodule_name] = submodule.opts }
end

local function merge_opts(...)
  return vim.tbl_extend("force", ...)
end

return {
  "folke/snacks.nvim",
  version = "2.22.0",
  priority = 1000,
  lazy = false,
  keys = vim.iter(vim.iter(submodules):map(get_keys):totable()):flatten():totable(),
  opts = vim.iter(submodules):map(get_opts):fold({}, merge_opts),
}
