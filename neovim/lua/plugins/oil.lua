require("utils.add-backdrop-float-window")({
  name = "Oil",
  pattern = "oil://*",
  zindex = 45,
})

return {
  {
    "stevearc/oil.nvim",
    version = "2.15.0",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "echasnovski/mini.icons",
    },
    lazy = false,
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    keys = {
      { "<leader>e", "<cmd>Oil --float<cr>", desc = "Oil" },
    },
    ---@module "oil"
    ---@type oil.SetupOpts
    opts = {
      delete_to_trash = true,
      default_file_explorer = false,
      float = {
        preview_split = "right",
        max_width = 0.8,
        max_height = 0.8,
      },
      win_options = {
        signcolumn = "yes:2",
      },
      keymaps = {
        ["q"] = { "actions.close", mode = "n" },
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
      },
    },
  },
  {
    "refractalize/oil-git-status.nvim",
    commit = "4b5cf53",
    dependencies = {
      "stevearc/oil.nvim",
    },
    config = true,
  },
}
