return {
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "28d480e",
    opts = {
      ensure_installed = {
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
        "markdown",
        "markdown_inline",
      },
      ignore_install = {},
      highlight = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    commit = "0e3be38",
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
}
