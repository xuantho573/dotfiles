return {
  "catgoose/nvim-colorizer.lua",
  commit = "81e676d",
  event = "BufReadPre",
  opts = {
    filetypes = {
      "*", -- Highlight all files, but customize some others.
      "!lazy", -- Exclude lazy from highlighting.
      -- Exclusion Only makes sense if '*' is specified first!
    },
    user_default_options = {
      names = false,
      css = true,
      css_fn = true,
      tailwind = "both",
    },
  },
}
