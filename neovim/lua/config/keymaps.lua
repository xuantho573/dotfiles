local set = vim.keymap.set

set({ "i", "n", "x", "s" }, "<c-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete Buffer" })
