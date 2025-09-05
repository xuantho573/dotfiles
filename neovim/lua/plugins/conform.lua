return {
  {
    "stevearc/conform.nvim",
    version = "9.0.0",
    opts = {
      formatters_by_ft = {
        nix = { "nixfmt" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        lua = { "stylua" },
        javascript = { "eslint_d" },
      },
      format_on_save = function(bufnr)
        if vim.g.conform_disable_auto_format and vim.b[bufnr].conform_disable_auto_format then
          return
        end

        return {
          timeout_ms = 1000,
          lsp_format = "fallback",
        }
      end,
    },
  },
  {
    "conform.nvim",
    opts = function()
      Snacks.toggle({
        name = "Auto Format (Buffer)",
        get = function()
          local bufnr = vim.api.nvim_get_current_buf()
          return not vim.b[bufnr].conform_disable_auto_format
        end,
        set = function(state)
          local bufnr = vim.api.nvim_get_current_buf()
          vim.b[bufnr].conform_disable_auto_format = not state
        end,
      }):map("<leader>tF")

      Snacks.toggle({
        name = "Auto Format (Global)",
        get = function()
          return not vim.g.conform_disable_auto_format
        end,
        set = function(state)
          vim.g.conform_disable_auto_format = not state
        end,
      }):map("<leader>tf")
    end,
  },
}
