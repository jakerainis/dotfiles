return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▁" },
      topdelete = { text = "▔" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "▁" },
      topdelete = { text = "▔" },
      changedelete = { text = "▎" },
    },
  },
  config = function(_, opts)
    require("gitsigns").setup(opts)

    -- Link to standard groups so colors follow the colorscheme
    vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChange" })
    vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "GitSignsTopdelete", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { link = "DiffChange" })
    vim.api.nvim_set_hl(0, "GitSignsUntracked", { link = "DiagnosticHint" })

    -- Inline diff colors (for toggle_deleted and toggle_word_diff)
    vim.api.nvim_set_hl(0, "GitSignsDeleteVirtLn", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "GitSignsAddInline", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "GitSignsDeleteInline", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "GitSignsChangeInline", { link = "DiffChange" })
  end,
  keys = {
    {
      "<leader>gT",
      function()
        local gs = require("gitsigns")
        -- Toggle all three together for a full inline diff view
        gs.toggle_deleted()
        gs.toggle_linehl()
        gs.toggle_word_diff()
      end,
      desc = "Toggle inline diff",
    },
  },
}
