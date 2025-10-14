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
    "loctvl842/monokai-pro.nvim",
    name = "monokai-pro",
    priority = 1000,
    opts = {
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
    "folke/tokyonight.nvim",
    name = "tokyonight",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
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
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "everforest",
    },
  },
}
