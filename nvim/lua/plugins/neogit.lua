return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gG", "<cmd>Neogit<cr>", desc = "Neogit" },
  },
  opts = {},
}
