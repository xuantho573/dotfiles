return {
  filetypes = { "lua" },
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = { globals = { "vim" } },
      completion = { callSnippet = "Replace" },
    },
  },
}
