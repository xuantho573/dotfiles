return {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
  cmd = { "typescript-language-server", "--stdio" },
  init_options = {
    preferences = { disableSuggestions = true },
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = require("utils.lsp").get_node_module_lib("@vue/language-server"),
        languages = { "vue" },
      },
    },
  },
}
