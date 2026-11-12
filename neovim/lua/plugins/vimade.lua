return {
  "TaDaa/vimade",
  version = "2.5.0",
  opts = {
    recipe = { "minimalist", { animate = false } },
    ncmode = "buffers",
    fadelevel = 0.2,
    tint = function()
      local hl = vim.api.nvim_get_hl(0, { name = "Visual" })
      local color_utils = require("utils.color")

      return {
        bg = {
          rgb = color_utils.hex_to_rgb(color_utils.highlight_to_hex(hl.bg)),
          intensity = 0.8,
        },
      }
    end,
    blocklist = {
      non_float = function(win, current)
        if (win.win_config["relative"] == "") and (current and current.win_config["relative"] ~= "") then
          return false
        end
        return true
      end,
    },
    checkinterval = 500,
  },
}
