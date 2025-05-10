return {
  "stevearc/conform.nvim",
  version = "9.0.0",
  opts = {
    formatters_by_ft = {
      nix = { "nixfmt" },
      sh = { "shfmt" },
      zsh = { "shfmt" },
      lua = { "stylua" },
    },
  },
}
