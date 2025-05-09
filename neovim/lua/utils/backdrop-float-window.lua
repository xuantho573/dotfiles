---@class Opts
---@field name? string
---@field pattern? string | string[]
---@field blend? number
---@field zindex? number
---@field manual_close? boolean

---@type Opts
local default_opts = {
  blend = 60,
  name = 'Default',
  zindex = 2,
}

---@param backdrops { bufs: number[], wins: number[] }
local function remove_backdrops (backdrops)
  for _, winnr in ipairs(backdrops.wins) do
    if vim.api.nvim_win_is_valid(winnr) then vim.api.nvim_win_close(winnr, true) end
  end
  for _, bufnr in ipairs(backdrops.bufs) do
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
  backdrops.bufs = {}
  backdrops.wins = {}
end

return {
---@param opts Opts
  add_backdrop_for_float_window = function (opts)
    ---@type Opts
    opts = vim.tbl_extend("force", default_opts, opts)

    local backdrops = {
      bufs = {},
      wins = {},
    }

    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      pattern = opts.pattern,
      callback = function(ctx)
        local backdrop_name = opts.name .. "Backdrop"

        local bufnr = vim.api.nvim_create_buf(false, true)

        local winnr = vim.api.nvim_open_win(bufnr, false, {
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

        table.insert(backdrops.wins, winnr)
        table.insert(backdrops.bufs, bufnr)

        vim.api.nvim_set_hl(0, backdrop_name, { bg = "#000000", default = true })
        vim.wo[winnr].winhighlight = "Normal:" .. backdrop_name
        vim.wo[winnr].winblend = opts.blend
        vim.bo[bufnr].buftype = "nofile"

        if opts.manual_close then return end
        -- close backdrop when the reference buffer and the window is closed
        vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
          once = true,
          buffer = ctx.buf,
          callback = function()
            if vim.api.nvim_win_is_valid(winnr) then vim.api.nvim_win_close(winnr, true) end
            if vim.api.nvim_buf_is_valid(bufnr) then
              vim.api.nvim_buf_delete(bufnr, { force = true })
            end
          end,
        })
      end,
    })

    if opts.manual_close then
      return function () remove_backdrops(backdrops) end
    end
  end
}
