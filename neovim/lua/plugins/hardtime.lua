return {
  {
    "m4xshen/hardtime.nvim",
    version = "1.2.0",
    lazy = false,
    dependencies = "MunifTanjim/nui.nvim",
    opts = {
      disable_mouse = false,
      disabled_filetypes = {
        snacks_picker_input = true,
      },
    },
  },
  {
    "hardtime.nvim",
    opts = function()
      Snacks.toggle({
        name = "Hardtime",
        get = function()
          return require("hardtime").is_plugin_enabled
        end,
        set = function()
          vim.cmd("Hardtime toggle")
        end,
      }):map("<leader>th")
    end,
  },
}
