return {
  {
    "lewis6991/gitsigns.nvim",
    version = "1.0.2",
    lazy = false,
    keys = {
      { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
      { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame current line" },
      { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage/Unstage current hunk" },
      { "[h", "<cmd>Gitsigns nav_hunk prev<cr>", desc = "Previous hunk" },
      { "]h", "<cmd>Gitsigns nav_hunk next<cr>", desc = "Next hunk" },
      { "[H", "<cmd>Gitsigns nav_hunk first<cr>", desc = "First hunk" },
      { "]H", "<cmd>Gitsigns nav_hunk last<cr>", desc = "Last hunk" },
    },
    opts = {
      current_line_blame_opts = { delay = 500 },
      current_line_blame_formatter = "<abbrev_sha> - <author>, <author_time:%R> - <summary>",
    },
  },
  {
    "gitsigns.nvim",
    opts = function()
      Snacks.toggle({
        name = "Line Blame",
        get = function()
          return require("gitsigns.config").config.current_line_blame
        end,
        set = require("gitsigns").toggle_current_line_blame,
      }):map("<leader>tb")
    end,
  },
}
