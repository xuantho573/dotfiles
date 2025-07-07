vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

vim.diagnostic.config({
  float = { border = "rounded" },
  virtual_text = true,
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

local function get_lsp_filenames()
  -- Find all .lua files in the identified 'lsp' directories
  local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
  local lsp_files = vim.fs.find(function(name)
    return name:match(".*%.lua$")
  end, {
    path = lsp_dir,
    type = "file",
    limit = math.huge, -- No limit on number of files
  })

  local filenames = {}
  -- Extract the filename without the extension
  for _, file_path in ipairs(lsp_files) do
    table.insert(filenames, vim.fn.fnamemodify(file_path, ":t:r"))
  end

  return filenames
end

vim.lsp.enable(get_lsp_filenames())

local opt = vim.opt

opt.number = true -- Show current line number
opt.relativenumber = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.expandtab = true -- Use spaces instead of tabs
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
