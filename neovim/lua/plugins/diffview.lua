return {
  "sindrets/diffview.nvim",
  commit = "4516612",
  keys = {
    { "<leader>dq", "<cmd>DiffviewClose<cr>", desc = "Quit Diff View" },
    { "<leader>do", "<cmd>DiffviewOpen<cr>", desc = "Open Diff View" },
    { "<leader>dm", "<cmd>DiffviewOpen origin/HEAD..HEAD<cr>", desc = "Compare with Main Branch" },
    {
      "<leader>dt",
      function()
        local cmd_output = vim.system({ "git", "tag" }, { text = true }):wait()["stdout"]

        if cmd_output == "" then
          vim.notify("No tag found", vim.log.levels.WARN)
          return
        end

        if cmd_output == nil then
          vim.notify("An error happened when listing tags", vim.log.levels.ERROR)
          return
        end

        local tags = vim.split(cmd_output, "\n")
        vim.ui.select(tags, {}, function(tag)
          vim.cmd("DiffviewOpen " .. tag .. "..HEAD")
        end)
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
