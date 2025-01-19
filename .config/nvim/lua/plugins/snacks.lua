return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below

    terminal = {},

    -- bigfile = { enabled = true },
    -- dashboard = { enabled = true },
    -- indent = { enabled = true },
    -- input = { enabled = true },
    -- notifier = { enabled = true },
    -- quickfile = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    -- words = { enabled = true },
    -- lazygit = {
    --   -- theme_path = vim.fs.normalize("/home/xuantho573/.config/lazygit/config.yml"),
    --   enabled = false,
    --   theme = {
    --     [241] = { fg = "Red" },
    --     activeBorderColor = { fg = "MatchParen", bold = true },
    --     cherryPickedCommitBgColor = { fg = "Identifier" },
    --     cherryPickedCommitFgColor = { fg = "Function" },
    --     defaultFgColor = { fg = "Normal" },
    --     inactiveBorderColor = { fg = "FloatBorder" },
    --     optionsTextColor = { fg = "Function" },
    --     searchingActiveBorderColor = { fg = "MatchParen", bold = true },
    --     selectedLineBgColor = { bg = "Visual" }, -- set to `default` to have no background colour
    --     unstagedChangesColor = { fg = "DiagnosticError" },
    --   },
    -- },
  },
  keys = {
    {
      "<leader>qt",
      function()
        Snacks.terminal("echo 1", {})
      end,
    },
  },
}
