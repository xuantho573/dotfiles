local remove_backdrops

local function wrap_remove_backdrops(func)
  return function()
    remove_backdrops()
    func()
  end
end

return {
  {
    "stevearc/oil.nvim",
    version = "2.15.0",
    -- Optional dependencies
    dependencies = "echasnovski/mini.icons",
    -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
    lazy = false,
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
      keymaps = {},
    },
    config = function(_, opts)
      local oil = require("oil")

      remove_backdrops = require("utils.backdrop-float-window").add_backdrop_for_float_window({
        name = "Oil",
        pattern = "oil://*",
        zindex = 45,
        manual_close = true,
      })

      local wrapped_keymaps = {
        ["<C-c>"] = { wrap_remove_backdrops(oil.close), mode = "n", desc = "Close oil and restore original buffer" },
        ["q"] = { wrap_remove_backdrops(oil.close), mode = "n", desc = "Close oil and restore original buffer" },
        ["<CR>"] = { wrap_remove_backdrops(oil.select), mode = "n", desc = "Open the entry under the cursor" },
      }

      opts.keymaps = vim.tbl_extend("force", opts.keymaps, wrapped_keymaps)
      oil.setup(opts)
    end,
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
