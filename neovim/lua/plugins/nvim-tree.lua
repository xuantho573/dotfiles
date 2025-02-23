local WIDTH_RATIO = 0.3
local HEIGHT_RATIO = 0.9

return {
  "nvim-tree/nvim-tree.lua",
  version = "1.11.0",
  dependencies = "nvim-tree/nvim-web-devicons",
  keys = {
    { "<leader>ee", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer", mode = "n" },
    { "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle file explorer on current file", mode = "n" },
    { "<leader>ec", "<cmd>NvimTreeCollapse<CR>", desc = "Collapse file explorer", mode = "n" },
    { "<leader>er", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer", mode = "n" },
  },
  opts = {
    view = {
      width = function()
        return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
      end,
      float = {
        enable = true,
        open_win_config = function()
          local window_w = vim.opt.columns:get() * WIDTH_RATIO
          local window_h = (vim.opt.lines:get() - vim.opt.cmdheight:get()) * HEIGHT_RATIO
          local window_w_int = math.floor(window_w)
          local window_h_int = math.max(math.floor(window_h), 20)
          local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
          return {
            border = "rounded",
            relative = "editor",
            row = center_y,
            col = 0,
            width = window_w_int,
            height = window_h_int,
          }
        end,
      },
    },
    renderer = {
      indent_markers = { enable = true },
      icons = {
        git_placement = "after",
        show = {
          folder_arrow = false,
          git = true,
        },
      },
    },
    -- disable window_picker for explorer to work well with window splits
    actions = {
      open_file = {
        window_picker = { enable = false },
      },
    },
    filters = {
      custom = { ".DS_Store" },
    },
    git = { ignore = false },
  },
}
