return {
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile",
  },
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
  },
  config = function()
    vim.g.lazygit_floating_window_winblend = 1
    vim.g.lazygit_use_custom_config_file_path = 1
    if vim.o.bg == "light" then
      vim.g.lazygit_config_file_path = {
        "/home/xuantho573/.config/lazygit/config.yml",
        "/home/xuantho573/.config/lazygit/catppuccin-latte-sky.yml",
      }
    else
      vim.g.lazygit_config_file_path = {
        "/home/xuantho573/.config/lazygit/config.yml",
        "/home/xuantho573/.config/lazygit/catppuccin-macchiato-sky.yml",
      }
    end
  end,
}
