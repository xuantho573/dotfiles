---@class Opts
---@field name? string
---@field pattern? string | string[]
---@field blend? number
---@field zindex? number

---@type Opts
local default_opts = {
  blend = 60,
  name = "Default",
  zindex = 2,
}

---@param winnr number|nil
---@param bufnr number|nil
local function close_win_buf_if_valid(winnr, bufnr)
  if winnr and vim.api.nvim_win_is_valid(winnr) then
    vim.api.nvim_win_close(winnr, true)
  end
  if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
end

return
---@param opts Opts
function(opts)
  ---@type Opts
  opts = vim.tbl_extend("force", default_opts, opts)

  local winnr = nil
  local bufnr = nil

  vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = opts.pattern,
    callback = function(ctx)
      local backdrop_name = opts.name .. "Backdrop"

      close_win_buf_if_valid(winnr, bufnr)

      bufnr = vim.api.nvim_create_buf(false, true)

      winnr = vim.api.nvim_open_win(bufnr, false, {
        relative = "editor",
        border = "none",
        row = 0,
        col = 0,
        width = vim.o.columns,
        height = vim.o.lines,
        focusable = false,
        style = "minimal",
        zindex = opts.zindex - 1,
      })

      vim.api.nvim_set_hl(0, backdrop_name, { bg = "#000000", default = true })
      vim.wo[winnr].winhighlight = "Normal:" .. backdrop_name
      vim.wo[winnr].winblend = opts.blend
      vim.bo[bufnr].buftype = "nofile"

      vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
        -- once = true,
        buffer = ctx.buf,
        callback = function()
          close_win_buf_if_valid(winnr, bufnr)
        end,
      })
    end,
  })
end
