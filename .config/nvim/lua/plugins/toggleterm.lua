return {
  "akinsho/toggleterm.nvim",
  version = "2.13.0",
  config = function()
    local Terminal = require("toggleterm.terminal").Terminal

    local floatTerminal = Terminal:new({
      direction = "float",
      hidden = true,
      float_opts = {
        border = "rounded",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
    })
    function _toggle_float_terminal()
      floatTerminal:toggle()
    end

    require("which-key").add({
      mode = { "n" },
      {
        "<leader>tf",
        "<cmd>lua _toggle_float_terminal()<CR>",
        desc = "Float Terminal",
      },
    })
  end,
}
