return {
  ---@class snacks.indent.Config
  opts = {
    enabled = true,
    indent = {
      priority = 1,
      enabled = true, -- enable indent guides
      char = "┃",
      only_scope = false, -- only show indent guides of the scope
      only_current = false, -- only show indent guides in the current window
      hl = {
        "SnacksIndent1",
        "SnacksIndent2",
        "SnacksIndent3",
        "SnacksIndent4",
        "SnacksIndent5",
        "SnacksIndent6",
        "SnacksIndent7",
        "SnacksIndent8",
      },
    },
    ---@class snacks.indent.animate: snacks.animate.Config
    animate = { enabled = false },
    ---@class snacks.indent.Scope.Config: snacks.scope.Config
    scope = { enabled = false },
    chunk = { enabled = false },
    -- filter for buffers to enable indent guides
    filter = function(buf)
      return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
    end,
  }
}
