return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "emmet-language-server")
      end,
    },
  },
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers["emmet_language_server"] = {
      filetypes = {
        "css",
        "elixir",
        "ex",
        "heex",
        "html",
        "javascript",
        "javascriptreact",
        "phoenix-heex",
        "typescriptreact",
      },
      init_options = {
        includeLanguages = {
          elixir = "html",
          ex = "html",
          heex = "html",
          ["phoenix-heex"] = "html",
        },
        showExpandedAbbreviation = "always",
        showAbbreviationSuggestions = true,
        showSuggestionsAsSnippets = false,
      },
    }
  end,
}
