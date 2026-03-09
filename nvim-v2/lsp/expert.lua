return {
  cmd = { vim.fn.expand("~/.local/share/nvim-v2/mason/bin/expert"), "--stdio" },
  filetypes = { "elixir", "eelixir", "heex", "surface" },
  root_markers = { "mix.exs", ".git" },
}
