local highlight = {}

local ctp_mocha_mappings = {
  { name = "Rosewater", color = "#f4dbd6" },
  { name = "Flamingo", color = "#f0c6c6" },
  { name = "Pink", color = "#f5bde6" },
  { name = "Mauve", color = "#c6a0f6" },
  { name = "Red", color = "#ed8796" },
  { name = "Maroon", color = "#ee99a0" },
  { name = "Peach", color = "#f5a97f" },
  { name = "Yellow", color = "#eed49f" },
  { name = "Green", color = "#a6da95" },
  { name = "Teal", color = "#8bd5ca" },
  { name = "Sky", color = "#91d7e3" },
  { name = "Sapphire", color = "#7dc4e4" },
  { name = "Blue", color = "#8aadf4" },
  { name = "Lavender", color = "#b7bdf8" },
}

for idx, val in ipairs(ctp_mocha_mappings) do
  highlight[idx] = "Rainbow" .. val.name
end

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  for _, val in ipairs(ctp_mocha_mappings) do
    vim.api.nvim_set_hl(0, "Rainbow" .. val.name, { fg = val.color })
  end
end)

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    require("ibl").setup({
      indent = { highlight = highlight, char = "│" },
    })
  end,
}
