return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = function()
    require("claudecode").setup({
      git_repo_cwd = true,
      diff_opts = {
        layout = "vertical",
        open_in_new_tab = false,
        keep_terminal_focus = false,
        hide_terminal_in_new_tab = false,
        on_new_file_reject = "keep_empty",
      },
    })
  end,
  keys = {
    { "<leader>a", nil, desc = "AI/Claude Code" },
    { "<leader>ac", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
    { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = { "v", "n" }, desc = "Send selection/file to Claude" },
    { "<leader>at", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
  },
}
