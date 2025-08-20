-- Extend which-key with custom groups
return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>o", group = "opencode", icon = { icon = "🤖 ", color = "blue" } },
      },
    },
  },
}
