return {
  "MeanderingProgrammer/render-markdown.nvim",
  version = "8.2.0",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  ft = { "markdown", "Avante" },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    bullet = {
      icons = { "", "", "✦", "✧" },
    },
    sign = { enabled = false },
    dash = { icon = "━" },
    heading = {
      icons = { "󰎥 ", "󰎨 ", "󰎫 ", "󰎲 ", "󰎯 ", "󰎴 " },
      width = "block",
      left_pad = 2,
      right_pad = 4,
    },
    pipe_table = { preset = "round" },
    file_types = { "markdown", "Avante" },
    latex = { enabled = false },
    completions = { blink = { enabled = true } },
  },
}
