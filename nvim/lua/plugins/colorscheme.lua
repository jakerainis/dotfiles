return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "macchiato", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    opts = {
      variant = "moon", -- auto, main, moon, or dawn
      styles = {
        transparency = true,
      },
    },
  },
  {
    "neanias/everforest-nvim",
    name = "everforest",
    version = false,
    lazy = false,
    priority = 1000,
    opts = {
      background = "medium", -- hard, medium, soft
      transparent_background_level = 0.95,
      italics = true,
      dim_inactive_windows = true,
      disable_italic_comments = false,
      sign_column_background = "none",
      ui_contrast = "high",
      diagnostic_text_highlight = true,
      diagnostic_virtual_text = "coloured",
      on_highlights = function(hl, palette)
        -- Make hidden/gitignored files in snacks explorer more visible
        hl.SnacksPickerPathHidden = { fg = palette.grey0, italic = true }
        hl.SnacksPickerPathIgnored = { fg = palette.grey0, italic = true }
      end,
    },
  },

  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true, -- do not set background color
      dimInactive = true, -- dim inactive window `:h hl-NormalNC`
      theme = "dragon", -- Load "wave" theme
      background = { -- map the value of 'background' option to a theme
        dark = "dragon", -- try "dragon" !
        light = "lotus",
      },
    },
  },
  {
    "thesimonho/kanagawa-paper.nvim",
    name = "kanagawa-paper",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      gutter = false,
      dim_inactive = true,
    },
  },
  {
    "everviolet/nvim",
    lazy = false,
    name = "evergarden",
    priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
    opts = {
      theme = {
        variant = "spring", -- 'winter'|'fall'|'spring'|'summer'
        accent = "green",
      },
      editor = {
        transparent_background = false,
        sign = { color = "none" },
        float = {
          color = "mantle",
          solid_border = false,
        },
        completion = {
          color = "surface0",
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "everforest",
      colorscheme = "evergarden",
      -- colorscheme = "kanagawa",
      -- colorscheme = "kanagawa-paper",
    },
  },
}
