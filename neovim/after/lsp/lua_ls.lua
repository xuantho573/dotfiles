return {
  settings = {
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = { globals = { "vim" } },
      completion = { callSnippet = "Replace" },
    },
  },
  on_init = function(client)
    local root = client.root_dir and vim.uv.fs_realpath(client.root_dir)
    if root ~= vim.uv.fs_realpath(vim.fn.stdpath("config")) then
      return
    end

    -- Make the server aware of Neovim runtime files
    client.settings = vim.tbl_deep_extend("force", client.settings or {}, {
      Lua = {
        runtime = { version = "LuaJIT" },
        workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
      },
    })
  end,
}
