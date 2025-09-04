return {
  "lewis6991/gitsigns.nvim",
  version = "1.0.2",
  lazy = false,
  keys = {
    { "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle line blame" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    { "<leader>gb", "<cmd>Gitsigns blame_line<cr>", desc = "Blame current line" },
    { "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage/Unstage current hunk" },
    { "[h", "<cmd>Gitsigns nav_hunk prev<cr>", desc = "Previous hunk" },
    { "]h", "<cmd>Gitsigns nav_hunk next<cr>", desc = "Next hunk" },
    { "[H", "<cmd>Gitsigns nav_hunk first<cr>", desc = "First hunk" },
    { "]H", "<cmd>Gitsigns nav_hunk last<cr>", desc = "Last hunk" },
  },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = " " },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = " " },
    },
    current_line_blame_opts = {
      delay = 500,
    },
    current_line_blame_formatter = "<abbrev_sha> - <author>, <author_time:%R> - <summary>",
  },
}
