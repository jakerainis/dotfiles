return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "frappe", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true, -- disables setting the background color.
    },
  },
  {
    "loctvl842/monokai-pro.nvim",
    name = "monokai-pro",
    priority = 1000,
    opts = {
      transparent_background = true, -- disables setting the background color.
    },
  },
  { "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      variant = "moon", -- auto, main, moon, or dawn
      styles = {
        transparency = true, 
      },
    }
},
  {"folke/tokyonight.nvim",
    name = "tokyonight",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    }
},
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}