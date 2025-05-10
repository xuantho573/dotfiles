return {
  {
    "williamboman/mason.nvim",
    lazy = true,
    config = function()
      local mason = require("mason")

      mason.setup({
        ui = {
          border = "rounded",
          width = 0.8,
          height = 0.8,
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
}
