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
    callbacks = {
      post_setup = function()
        vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian today<cr>", { desc = "Open Today's Note" })
        vim.keymap.set("n", "<leader>oy", "<cmd>Obsidian yesterday<cr>", { desc = "Open Yesterday's Note" })
        vim.keymap.set("n", "<leader>of", "<cmd>Obsidian follow_link<cr>", { desc = "Follow Link" })
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
