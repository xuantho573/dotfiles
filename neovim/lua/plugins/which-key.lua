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
        { plugin = "nvim-tree.lua", icon = "󰙅", hl = "CatppuccinFgGreen" },
      },
    },
    spec = {
      { "<leader>e", group = "explorer", mode = "n", icon = { icon = "󰙅", hl = "CatppuccinFgGreen" } },
    },
  },
}
