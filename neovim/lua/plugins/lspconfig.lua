---@param lib string
---@return string
local function get_node_module_lib(lib)
  return vim.fs.joinpath(os.getenv("NIX_PROFILE"), "lib/node_modules", lib)
end

return {
  "neovim/nvim-lspconfig",
  version = "2.1.0",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "antosha417/nvim-lsp-file-operations",
      config = true,
      dependencies = "nvim-lua/plenary.nvim",
    },
  },
  config = function()
    local lspconfig = require("lspconfig")

    vim
      .iter({
        "cssls",
        "tailwindcss",
      })
      :each(function(server)
        lspconfig[server].setup({})
      end)

    lspconfig["nixd"].setup({
      cmd = { "nixd" },
      settings = {
        nixd = {
          nixpkgs = { expr = "import <nixpkgs> { }" },
          formatting = { command = { "nixfmt" } },
          options = {
            home_manager = {
              expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations.'
                .. os.getenv("USER")
                .. ".options",
            },
          },
        },
      },
    })

    lspconfig["ts_ls"].setup({
      init_options = {
        plugins = {
          {
            name = "@vue/typescript-plugin",
            location = get_node_module_lib("@vue/language-server"),
            languages = { "vue" },
          },
        },
      },
      filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
    })

    lspconfig["volar"].setup({
      init_options = {
        vue = { hybridMode = true },
        typescript = { tsdk = get_node_module_lib("typescript/lib") },
      },
    })

    lspconfig["bashls"].setup({ filetypes = { "bash", "sh", "zsh" } })

    lspconfig["lua_ls"].setup({
      settings = {
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = { globals = { "vim" } },
          completion = { callSnippet = "Replace" },
        },
      },
    })
  end,
}
