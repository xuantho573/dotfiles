return {
  "catppuccin/nvim",
  version = "1.10.0",
  lazy = false,
  priority = 1000,
  name = "catppuccin",
  config = function()
    require("catppuccin").setup({
      flavour = "auto", -- latte, frappe, macchiato, mocha
      transparent_background = false,
      background = { -- :h background
        light = "latte",
        dark = "macchiato",
      },
      term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
      integrations = {
        blink_cmp = true,
        cmp = true,
        diffview = true,
        gitsigns = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        noice = true,
        notify = false,
        nvimtree = true,
        rainbow_delimiters = true,
        snacks = true,
        treesitter = true,
        which_key = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    })

    vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
      callback = function()
        local palette
        if vim.o.bg == "light" then
          palette = require("catppuccin.palettes").get_palette("latte")
        else
          palette = require("catppuccin.palettes").get_palette("macchiato")
        end

        for name, hex in pairs(palette) do
          local capitalizedName = name:gsub("^%l", string.upper)
          vim.api.nvim_set_hl(0, "CatppuccinFg" .. capitalizedName, { fg = hex })
          vim.api.nvim_set_hl(0, "CatppuccinBg" .. capitalizedName, { bg = hex })
        end

        vim.api.nvim_set_hl(0, "TabLineSel", { bg = palette.sky })
      end,
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
