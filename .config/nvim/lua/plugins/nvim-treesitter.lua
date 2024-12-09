return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "yaml",
      "html",
      "css",
      "scss",
      "vue",
    },
    ignore_install = {},
    highlight = {
      enable = true,
    },
  },
  -- config = function()
  --   local treesitter = require("nvim-treesitter")
  -- end,
}
