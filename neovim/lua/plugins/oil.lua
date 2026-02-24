local view_detail = false

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
        ["yn"] = {
          "actions.yank_entry",
          desc = "Yank the name of the entry under the cursor",
          mode = "n",
          opts = { modify = ":t" },
        },
        ["yP"] = {
          "actions.yank_entry",
          desc = "Yank the absolute filepath of the entry under the cursor",
          mode = "n",
        },
        ["yp"] = {
          "actions.yank_entry",
          desc = "Yank the relative filepath of the entry under the cursor",
          mode = "n",
          opts = { modify = ":." },
        },
        ["<C-s>"] = false,
        ["<C-h>"] = false,
        ["<C-t>"] = false,
        ["gd"] = {
          desc = "Toggle file detail view",
          callback = function()
            view_detail = not view_detail
            if view_detail then
              require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
            else
              require("oil").set_columns({ "icon" })
            end
          end,
        },
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
