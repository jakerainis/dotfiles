return {
  -- "rose-pine/neovim",
  -- "tokyonight.nvim",
  -- "ellisonleao/gruvbox.nvim",
  -- "neanias/everforest-nvim",
  -- "sainnhe/everforest",
  -- "nordic.nvim",
  -- "sainnhe/sonokai",
  -- "rebelot/kanagawa.nvim",
  -- "EdenEast/nightfox.nvim",
  -- "olimorris/onedarkpro.nvim",
  -- "ribru17/bamboo.nvim",
  "tokyonight.nvim",
  lazy = true,
  priority = 1000,
  opts = function()
    return {
      colorscheme = 'tokyonight',
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    }
  end,
}