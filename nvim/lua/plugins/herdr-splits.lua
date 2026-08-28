-- Ctrl+HJKL navigation between Neovim splits and herdr panes.
--
-- Only loads inside a herdr-managed pane (HERDR_ENV=1). Outside herdr, the
-- existing vim-tmux-navigator handles the same chords, so this coexists with
-- the tmux fallback without duplicate keymaps fighting each other.
return {
  "lmilojevicc/herdr-splits.nvim",
  cond = vim.env.HERDR_ENV == "1",
  event = "VeryLazy",
  opts = {
    at_edge = "stop",
    nav_at_edge = "stop",
  },
  keys = {
    -- Terminal mode too — otherwise Ctrl+HJKL falls through to the shell in
    -- nvim's :terminal buffers.
    { "<C-h>", function() require("herdr-splits").move_cursor_left() end, mode = { "n", "t" }, desc = "Move to left pane" },
    { "<C-j>", function() require("herdr-splits").move_cursor_down() end, mode = { "n", "t" }, desc = "Move to lower pane" },
    { "<C-k>", function() require("herdr-splits").move_cursor_up() end, mode = { "n", "t" }, desc = "Move to upper pane" },
    { "<C-l>", function() require("herdr-splits").move_cursor_right() end, mode = { "n", "t" }, desc = "Move to right pane" },

    { "<M-h>", function() require("herdr-splits").resize_left() end,  desc = "Resize pane left" },
    { "<M-j>", function() require("herdr-splits").resize_down() end,  desc = "Resize pane down" },
    { "<M-k>", function() require("herdr-splits").resize_up() end,    desc = "Resize pane up" },
    { "<M-l>", function() require("herdr-splits").resize_right() end, desc = "Resize pane right" },
  },
}
