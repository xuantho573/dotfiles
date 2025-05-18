return {
  "yetone/avante.nvim",
  version = "0.0.23",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "folke/snacks.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      version = "0.6.0",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = { insert_mode = true },
        },
      },
    },
  },
  opts = {
    provider = "gemini",
    groq = {
      api_key_name = "GEMINI_API_KEY",
      endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
      model = "gemini-2.0-flash",
    },
    windows = { width = 30 },
  },
  build = "make",
}
