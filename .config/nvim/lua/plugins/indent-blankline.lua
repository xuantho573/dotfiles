return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    local palette
    if vim.o.bg == "light" then
      palette = require("catppuccin.palettes").get_palette("latte")
    else
      palette = require("catppuccin.palettes").get_palette("macchiato")
    end

    function check_if_accent(name)
      return not (
        string.find(name, "text")
        or string.find(name, "sur")
        or string.find(name, "over")
        or name == "base"
        or name == "mantle"
        or name == "crust"
      )
    end

    function get_highlight_name(name)
      return "Rainbow" .. name:gsub("^%l", string.upper)
    end

    local highlight = {}
    local idx = 1
    for name, hex in pairs(palette) do
      if check_if_accent(name) then
        highlight[idx] = get_highlight_name(name)
        idx = idx + 1
      end
    end

    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for name, hex in pairs(palette) do
        if check_if_accent(name) then
          vim.api.nvim_set_hl(0, get_highlight_name(name), { fg = hex })
        end
      end
    end)

    require("ibl").setup({
      indent = { highlight = highlight, char = "│" },
      scope = { enabled = false, char = "┃" },
    })
    vim.g.rainbow_delimiters.highlight = highlight
  end,
}
