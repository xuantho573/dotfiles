return {
  "folke/which-key.nvim",
  version = "3.17.0",
  event = "VeryLazy",
  opts = {
    preset = "classic",
    win = {
      border = "rounded",
    },
    icons = {
      rules = {
        { plugin = "oil.nvim", icon = "󰏇 ", hl = "CatppuccinFgFlamingo" },
      },
    },
    spec = {
      { "<leader>k", group = "rest", icon = { icon = "󰏚 ", hl = "CatppuccinFgSubtext0" } },
    },
  },
}
