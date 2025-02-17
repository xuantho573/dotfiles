return {
  "folke/snacks.nvim",
  version = "2.20.0",
  ---@type snacks.Config
  opts = {
    ---@class snacks.lazygit.Config: snacks.terminal.Opts
    ---@field args? string[]
    ---@field theme? snacks.lazygit.Theme
    lazygit = {
      configure = true,
      config = {
        os = { editPreset = "nvim-remote" },
        gui = { nerdFontsVersion = "3" },
      },
      theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
      theme = {
        [241]                      = { fg = "Special" },
        activeBorderColor          = { fg = "CatppuccinFgSky", bold = true },
        cherryPickedCommitBgColor  = { fg = "CatppuccinFgSurface1" },
        cherryPickedCommitFgColor  = { fg = "CatppuccinFgSky" },
        defaultFgColor             = { fg = "CatppuccinFgText" },
        inactiveBorderColor        = { fg = "CatppuccinFgSubtext0" },
        optionsTextColor           = { fg = "CatppuccinFgBlue" },
        searchingActiveBorderColor = { fg = "CatppuccinFgYellow" },
        selectedLineBgColor        = { bg = "CatppuccinBgSurface0" },
        unstagedChangesColor       = { fg = "CatppuccinFgRed" },
      },
      win = { style = "lazygit" },
    },
  },
}
