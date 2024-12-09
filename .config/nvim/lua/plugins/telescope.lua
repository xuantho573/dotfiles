return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
    "folke/todo-comments.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local telescope_actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = telescope_actions.move_selection_previous,
            ["<C-k>"] = telescope_actions.move_selection_next,
          },
        },
      },
    })

    telescope.load_extension("fzf")

    -- set keymaps
    require("which-key").add({
      mode = { "n" },
      { "<leader>ff", "<cmd>Telescope find_files find_command=fd,-H<cr>", desc = "Find Files" },
    })

    -- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files find_command=fd,-H<cr>", { desc = "Find files" })
    -- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    -- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    -- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    -- keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
  end,
}
