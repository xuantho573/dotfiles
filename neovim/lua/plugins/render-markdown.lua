return {
  "MeanderingProgrammer/render-markdown.nvim",
  version = "8.1.1",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "Avante" },
  opts = {
    sign = { enabled = false },
    code = { language_pad = 2 },
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
