return {
  "sindrets/diffview.nvim",
  commit = "4516612",
  keys = {
    { "<leader>dq", "<cmd>DiffviewClose<cr>", desc = "Quit Diff View" },
    { "<leader>dm", "<cmd>DiffviewOpen origin/HEAD..HEAD<cr>", desc = "Compare with Main Branch" },
    {
      "<leader>dt",
      function()
        local tag = vim.fn.input("Git tag to compare", "", "custom,CustomCompletionGitTags")
        if string.len(tag) > 0 then
          vim.cmd("DiffviewOpen " .. tag .. "..HEAD")
        end
      end,
      desc = "Compare with Tag",
    },
  },
  opts = {
    default_args = {
      DiffviewOpen = { "--imply-local" },
    },
  },
}
