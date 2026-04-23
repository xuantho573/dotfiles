local env = require("config.env")

local TEMPLATE_DIR = env.get("OBSIDIAN_TEMPLATE_DIR")
local DAILY_NOTE_DIR = env.get("OBSIDIAN_DAILY_NOTE_DIR")
local VAULT_ROOT = env.get("OBSIDIAN_VAULT_ROOT")

---@param title string
---@return string
local function slugify_title(title)
  return require("obsidian.builtin").title_to_slug(title)
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "3.16.1",
  event = {
    "BufReadPre " .. VAULT_ROOT .. "/*",
    "BufNewFile " .. VAULT_ROOT .. "/*",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
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
  },
}
