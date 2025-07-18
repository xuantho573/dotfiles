return {
  "MeanderingProgrammer/render-markdown.nvim",
  version = "8.2.0",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  ft = { "markdown", "Avante" },
  opts = {
    sign = { enabled = false },
    dash = { icon = "━" },
    heading = {
      icons = { "󰎥 ", "󰎨 ", "󰎫 ", "󰎲 ", "󰎯 ", "󰎴 " },
      width = "block",
      left_pad = 2,
      right_pad = 4,
    },
    pipe_table = { preset = "round" },
  },
}
