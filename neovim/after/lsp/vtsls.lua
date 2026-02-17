local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vim.fs.joinpath(os.getenv("NIX_PROFILE"), "lib/language-tools/packages/language-server"),
  languages = { "vue" },
  configNamespace = "typescript",
}

return {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
      enableMoveToFileCodeAction = true,
    },
  },
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
}
