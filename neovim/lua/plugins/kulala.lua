return {
  "mistweaverco/kulala.nvim",
  opts = {
    -- Display mode, possible values: "split", "float"
    display_mode = "split",

    -- default_view, body or headers or headers_body
    default_view = "body",

    -- dev, test, prod, can be anything
    -- see: https://learn.microsoft.com/en-us/aspnet/core/test/http-files?view=aspnetcore-8.0#environment-files
    default_env = "dev",
    show_icons = "on_request",
    icons = {
      inlay = {
        loading = "⏳",
        done = "✅",
        error = "❌",
      },
      lualine = "🐼",
    },

    -- additional cURL options
    -- see: https://curl.se/docs/manpage.html
    additional_curl_options = {},

    -- scratchpad default contents
    scratchpad_default_contents = {
      "@MY_TOKEN_NAME=my_token_value",
      "",
      "# @name scratchpad",
      "POST https://httpbin.org/post HTTP/1.1",
      "accept: application/json",
      "content-type: application/json",
      "",
      "{",
      '  "foo": "bar"',
      "}",
    },

    -- enable winbar
    winbar = false,

    -- Specify the panes to be displayed by default
    -- Current available pane contains { "body", "headers", "headers_body", "script_output", "stats" },
    default_winbar_panes = { "body", "headers", "headers_body" },

    -- enable reading vscode rest client environment variables
    vscode_rest_client_environmentvars = false,

    -- disable the vim.print output of the scripts
    -- they will be still written to disk, but not printed immediately
    disable_script_print_output = false,

    -- set scope for environment and request variables
    -- possible values: b = buffer, g = global
    environment_scope = "b",

    -- certificates
    certificates = {},
  },
  config = function(_, opts)
    vim.filetype.add({
      extension = {
        ["http"] = "http",
      },
    })
    require("kulala").setup(opts)
    require("which-key").add({
      mode = { "n" },
      { "<leader>k", group = "rest", icon = { icon = "󰏚 ", color = "black" } },
      { "<leader>kb", "<cmd>lua require('kulala').scratchpad()<cr>", desc = "Open scratchpad" },
      { "<leader>kc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL" },
      { "<leader>kC", "<cmd>lua require('kulala').from_curl()<cr>", desc = "Paste from curl" },
      {
        "<leader>kg",
        "<cmd>lua require('kulala').download_graphql_schema()<cr>",
        desc = "Download GraphQL schema",
      },
      { "<leader>ki", "<cmd>lua require('kulala').inspect()<cr>", desc = "Inspect current request" },
      { "<leader>kn", "<cmd>lua require('kulala').jump_next()<cr>", desc = "Jump to next request" },
      { "<leader>kp", "<cmd>lua require('kulala').jump_prev()<cr>", desc = "Jump to previous request" },
      { "<leader>kq", "<cmd>lua require('kulala').close()<cr>", desc = "Close window" },
      { "<leader>kr", "<cmd>lua require('kulala').replay()<cr>", desc = "Replay the last request" },
      { "<leader>ks", "<cmd>lua require('kulala').run()<cr>", desc = "Send the request" },
      { "<leader>kS", "<cmd>lua require('kulala').show_stats()<cr>", desc = "Show stats" },
      { "<leader>kt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
    })
  end,
}
