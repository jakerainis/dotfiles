return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
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
      background = "hard",
      transparent_background_level = 0.95,
      italics = true,
      disable_italic_comments = false,
      sign_column_background = "none",
      ui_contrast = "high",
      dim_inactive_windows = false,
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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
