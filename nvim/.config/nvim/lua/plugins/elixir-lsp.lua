return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        lexical = {
          -- Elixir Expert (official Elixir language server)
          -- https://github.com/elixir-lang/expert
          -- Note: Expert uses 'lexical' as its lspconfig name
          -- Mason package name: 'expert' (not 'lexical')
          --
          -- Filetypes covered:
          --   - elixir: .ex, .exs files
          --   - eelixir: .eex files (Embedded Elixir)
          --   - heex: .heex files (HEEx templates)

          mason = false,
          cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/expert") },
          root_dir = require("lspconfig").util.root_pattern("mix.exs", ".git"),
          filetypes = { "elixir", "eelixir", "heex" },
          settings = {},
        },
      },
    },
  },
}
