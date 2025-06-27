return {
  filetypes = { "vue" },
  cmd = { "vue-language-server", "--stdio" },
  init_options = {
    vue = { hybridMode = true },
    typescript = { tsdk = require("utils.lsp").get_node_module_lib("typescript/lib") },
  },
}
