return {
  "f-person/auto-dark-mode.nvim",
  opts = {
    set_dark_mode = function()
      vim.cmd("set bg=dark")
      vim.cmd("colorscheme catppuccin")
    end,
    set_light_mode = function()
      vim.cmd("set bg=light")
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
