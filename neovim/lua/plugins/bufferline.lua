return {
  "akinsho/bufferline.nvim",
  version = "4.9.1",
  opts = {
    options = {
      indicator = { style = "underline" },
      show_buffer_close_icons = false,
      separator_style = "slant",
    },
  },
  config = function(_, opts)
    if (vim.g.colors_name or ""):find("catppuccin") then
      opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
    end
    require("bufferline").setup(opts)
  end,
}
