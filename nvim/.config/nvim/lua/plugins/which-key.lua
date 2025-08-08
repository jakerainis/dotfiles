-- Extend which-key with custom groups
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>a", group = "avante", icon = { icon = "🤖 ", color = "blue" } },
      },
    },
  },
}
