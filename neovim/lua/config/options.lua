vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

vim.diagnostic.config({
  float = { border = "rounded" },
})

vim
  .iter({
    Error = " ",
    Warn = " ",
    Hint = "󰠠 ",
    Info = " ",
  })
  :each(function(type, icon)
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end)

local opt = vim.opt

opt.number = true -- Show current line number
opt.relativenumber = true
opt.shiftwidth = 2
opt.tabstop = 2
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
opt.pumheight = 15 -- Maximum number of entries in a popup
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
