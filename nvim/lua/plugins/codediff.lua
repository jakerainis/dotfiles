return {
  "esmuellert/codediff.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  cmd = "CodeDiff",
  keys = {
    { "<leader>gd", "<cmd>CodeDiff<cr>", desc = "Open Diff (git status)" },
    { "<leader>gh", "<cmd>CodeDiff file % HEAD<cr>", desc = "File History (vs HEAD)" },
    { "<leader>gD", "<cmd>CodeDiff main<cr>", desc = "Diff vs main" },
  },
  config = function()
    require("codediff").setup({
      diff = {
        disable_inlay_hints = true,
      },
      explorer = {
        position = "left",
        width = 40,
        view_mode = "tree",
        indent_markers = true,
      },
      keymaps = {
        view = {
          quit = "q",
          toggle_explorer = "<leader>b",
          next_hunk = "]c",
          prev_hunk = "[c",
          next_file = "]f",
          prev_file = "[f",
        },
        conflict = {
          accept_incoming = "<leader>ct",
          accept_current = "<leader>co",
          accept_both = "<leader>cb",
          next_conflict = "]x",
          prev_conflict = "[x",
        },
      },
    })
  end,
}
