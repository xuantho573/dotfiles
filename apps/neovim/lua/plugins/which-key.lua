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
        { pattern = "hunk", icon = "󰊢 ", hl = "CatppuccinFgPeach" },
      },
    },
    spec = {
      { "<leader>b", group = "buffer", icon = { icon = "󰈔 ", hl = "CatppuccinFgTeal" } },
      { "<leader>c", group = "code", icon = { icon = " ", hl = "CatppuccinFgPeach" } },
      { "<leader>d", group = "diff", icon = { icon = " ", hl = "CatppuccinFgGreen" } },
      { "<leader>g", group = "git", icon = { icon = "󰊢 ", hl = "CatppuccinFgPeach" } },
      { "<leader>k", group = "rest", icon = { icon = "󰏚 ", hl = "CatppuccinFgSubtext0" } },
      { "<leader>t", group = "toggle", icon = { icon = " ", hl = "CatppuccinFgYellow" } },
    },
  },
}
