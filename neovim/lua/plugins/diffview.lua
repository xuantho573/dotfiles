return {
  "sindrets/diffview.nvim",
  commit = "4516612",
  keys = {
    { "<leader>dq", "<cmd>DiffviewClose<cr>", desc = "Quit Diff View" },
    { "<leader>dm", "<cmd>DiffviewOpen origin/HEAD..HEAD<cr>", desc = "Compare with Main Branch" },
  },
  opts = {
    default_args = {
      DiffviewOpen = { "--imply-local" },
    },
  },
}
