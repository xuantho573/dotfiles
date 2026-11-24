local ensure_installed = {
  "bash",
  "lua",
  "nix",
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
  "svelte",
  "markdown",
  "markdown_inline",
  "query",
  "rust",
  "python",
  "kitty",
  "regex",
  "jinja",
  "just",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    commit = "2497714", -- July 19, 2026
    opts = {},
    config = function(_, opts)
      local treesitter = require("nvim-treesitter")

      treesitter.setup(opts)
      treesitter.install(ensure_installed)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "898ee30", -- July 19, 2026
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
}
