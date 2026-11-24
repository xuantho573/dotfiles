return {
  keys = {
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
  },
  ---@class snacks.lazygit.Config: snacks.terminal.Opts
  opts = {
    configure = true,
    config = {
      os = { editPreset = "nvim-remote" },
      gui = { nerdFontsVersion = "3" },
    },
    theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
    theme = {
      [241] = { fg = "Special" },
      activeBorderColor = { fg = "CatppuccinFgSky", bold = true },
      cherryPickedCommitBgColor = { fg = "CatppuccinFgSurface1" },
      cherryPickedCommitFgColor = { fg = "CatppuccinFgSky" },
      defaultFgColor = { fg = "CatppuccinFgText" },
      inactiveBorderColor = { fg = "CatppuccinFgSubtext0" },
      optionsTextColor = { fg = "CatppuccinFgBlue" },
      searchingActiveBorderColor = { fg = "CatppuccinFgYellow" },
      selectedLineBgColor = { bg = "CatppuccinBgSurface0" },
      unstagedChangesColor = { fg = "CatppuccinFgRed" },
    },
    win = {
      style = "lazygit",
      backdrop = false,
      -- Pass C-h/j/k/l/\ through to lazygit instead of triggering vim-tmux-navigator
      keys = {
        nav_h = { "<c-h>", "<c-h>", mode = "t", expr = true },
        nav_j = { "<c-j>", "<c-j>", mode = "t", expr = true },
        nav_k = { "<c-k>", "<c-k>", mode = "t", expr = true },
        nav_l = { "<c-l>", "<c-l>", mode = "t", expr = true },
        nav_prev = { "<c-\\>", "<c-\\>", mode = "t", expr = true },
      },
    },
  },
}
