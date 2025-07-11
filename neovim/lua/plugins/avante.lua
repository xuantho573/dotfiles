return {
  "yetone/avante.nvim",
  version = "0.0.25",
  event = "VeryLazy",
  lazy = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    { "stevearc/dressing.nvim", version = "3.1.1" },
    "folke/snacks.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
    "nvim-tree/nvim-web-devicons",
    "echasnovski/mini.icons",
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      version = "0.6.0",
      lazy = true,
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
    providers = {
      gemini = {
        api_key_name = "GEMINI_API_KEY",
        endpoint = "https://generativelanguage.googleapis.com/v1beta/models",
        model = "gemini-2.5-flash-preview-05-20",
      },
    },
    windows = { width = 30 },
  },
  build = "make",
}
