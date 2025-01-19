return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "bash",
      "lua",
      "javascript",
      "typescript",
      "tsx",
      "json",
      "yaml",
      "http",
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
