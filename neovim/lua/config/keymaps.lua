local set = vim.keymap.set

set({ "i", "n", "x", "s" }, "<c-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

set({ "i", "n", "t" }, "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to Left Window", remap = false })
set({ "i", "n", "t" }, "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to Bottom Window", remap = false })
set({ "i", "n", "t" }, "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to Top Window", remap = false })
set({ "i", "n", "t" }, "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to Right Window", remap = false })

set("t", "<esc>", "<C-\\><C-n>", { remap = false })

set("n", "<esc>", ":noh<cr>", { remap = false, silent = true })
