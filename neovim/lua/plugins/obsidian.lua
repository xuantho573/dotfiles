local env = require("config.env")

local TEMPLATE_DIR = env.get("OBSIDIAN_TEMPLATE_DIR")
local DAILY_NOTE_DIR = env.get("OBSIDIAN_DAILY_NOTE_DIR")
local VAULT_ROOT = env.get("OBSIDIAN_VAULT_ROOT")
local OBSIDIAN_TEMPLATE_NOTE_DIR_MAP = env.get("OBSIDIAN_TEMPLATE_NOTE_DIR_MAP")

local template_notes_subdir_map = {}

---@param title string
---@return string
local function slugify_title(title)
  return require("obsidian.builtin").title_to_slug(title)
end

for _, value in ipairs(vim.fn.split(OBSIDIAN_TEMPLATE_NOTE_DIR_MAP, ",")) do
  local template_subdir_pair = vim.fn.split(value, ":")

  template_notes_subdir_map[template_subdir_pair[1]] = {
    notes_subdir = template_subdir_pair[2],
    note_id_func = slugify_title,
  }
end

-- Skip swap files for vault notes and pick up writes
-- from other instances instead of raising the swap-file
-- prompt to allow editing them in multiple Neovim instances.
local vault_group = vim.api.nvim_create_augroup("obsidian_vault_sync", { clear = true })

vim.api.nvim_create_autocmd("BufReadPre", {
  group = vault_group,
  pattern = VAULT_ROOT .. "/*",
  callback = function()
    vim.opt_local.swapfile = false
    vim.opt_local.autoread = true
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "CursorHold" }, {
  group = vault_group,
  pattern = VAULT_ROOT .. "/*",
  callback = function(args)
    if vim.bo[args.buf].buftype == "" then
      vim.cmd("silent! checktime " .. args.buf)
    end
  end,
})

--- Toggle a note in a floating window (usable from anywhere).
--- @param win snacks.win?
--- @param note obsidian.Note
--- @param float_title string
--- @return snacks.win | nil
local function toggle_note_float(win, note, float_title)
  if win and win:valid() then
    win:close()
    return nil
  end

  if not note:exists() then
    note:write()
  end

  local buf = vim.fn.bufadd(tostring(note.path))
  vim.fn.bufload(buf)
  vim.bo[buf].buflisted = true

  local float_win = Snacks.win({
    buf = buf,
    width = 120,
    height = 0.8,
    border = "rounded",
    title = float_title,
    title_pos = "center",
    wo = { wrap = true, spell = false, number = true, relativenumber = true },
    ft = "md",
  })

  -- On close (via toggle, :q, or anything else): save so other instances see the
  -- edits, then drop the buffer so it doesn't linger in the buffer list.
  vim.api.nvim_create_autocmd("WinClosed", {
    group = vault_group,
    pattern = tostring(float_win.win),
    once = true,
    callback = function()
      if not vim.api.nvim_buf_is_valid(buf) then
        return
      end
      if vim.bo[buf].modified then
        vim.api.nvim_buf_call(buf, function()
          vim.cmd("silent! update")
        end)
      end
      -- Defer until the window is actually gone; keep the buffer if it is still
      -- shown elsewhere or the save failed (no force, so unsaved edits survive).
      vim.schedule(function()
        if vim.api.nvim_buf_is_valid(buf) and #vim.fn.win_findbuf(buf) == 0 then
          pcall(vim.api.nvim_buf_delete, buf, {})
        end
      end)
    end,
  })

  return float_win
end

---@type snacks.win?
local today_win
---@type snacks.win?
local yesterday_win
---@type snacks.win?
local tomorrow_win

local function toggle_today_float()
  local day_note = require("obsidian.daily").today()
  -- `id` for daily notes is date now, but may change
  today_win = toggle_note_float(today_win, day_note, string.format("Today's note (%s)", day_note.id))
end

local function toggle_yesterday_float()
  local day_note = require("obsidian.daily").yesterday()
  -- `id` for daily notes is date now, but may change
  today_win = toggle_note_float(yesterday_win, day_note, string.format("Yesterday's note (%s)", day_note.id))
end

local function toggle_tomorrow_float()
  local day_note = require("obsidian.daily").tomorrow()
  -- `id` for daily notes is date now, but may change
  today_win = toggle_note_float(tomorrow_win, day_note, string.format("Tomorrow's note (%s)", day_note.id))
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "3.16.1",
  -- lazy-load on `:Obsidian` so `nvim +'Obsidian today'` works (tmux popup)
  cmd = "Obsidian",
  keys = {
    { "<leader>of", "", desc = "Toggle Obsidian Float Note" },
    { "<leader>ofd", toggle_today_float, desc = "Today's Note (Float)" },
    { "<leader>ofy", toggle_yesterday_float, desc = "Yesterday's Note (Float)" },
    { "<leader>oft", toggle_tomorrow_float, desc = "Tomorrow's Note (Float)" },
  },
  event = {
    "BufReadPre " .. VAULT_ROOT .. "/*",
    "BufNewFile " .. VAULT_ROOT .. "/*",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    callbacks = {
      post_setup = function()
        vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian today<cr>", { desc = "Open Today's Note" })
        vim.keymap.set("n", "<leader>oy", "<cmd>Obsidian yesterday<cr>", { desc = "Open Yesterday's Note" })
        vim.keymap.set(
          "n",
          "<leader>ont",
          "<cmd>Obsidian new_from_template<cr>",
          { desc = "Create New Note from Template" }
        )
      end,
    },
    workspaces = {
      {
        name = "personal",
        path = VAULT_ROOT,
      },
    },
    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 2,
      create_new = true,
    },
    daily_notes = {
      folder = DAILY_NOTE_DIR,
      workdays_only = false,
      template = "daily",
    },
    link = {
      style = "markdown",
    },
    picker = {
      name = "snacks.pick",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },
    ui = {
      enable = false,
    },
    templates = {
      folder = TEMPLATE_DIR,
      date_format = "%Y-%m-%d %a",
      time_format = "%H:%M",
      customizations = template_notes_subdir_map,
    },
  },
}
