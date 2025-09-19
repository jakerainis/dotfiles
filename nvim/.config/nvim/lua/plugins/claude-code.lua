return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  config = function()
    require("claude-code").setup({
      enter_insert = true, -- Automatically enter insert mode
      window = {
        position = "vertical",
        split_ratio = 0.3, -- 30% of screen width
      },
    })
  end,
}

