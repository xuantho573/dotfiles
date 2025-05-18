vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

local opt = vim.opt

opt.relativenumber = true
opt.shiftwidth = 2
-- opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.fillchars = {
  foldopen = "󰅀",
  foldclose = "󰅂",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 1000
opt.foldexpr = "v:lua.require'utils.ui'.foldexpr()"
opt.foldmethod = "expr"
opt.foldtext = ""
