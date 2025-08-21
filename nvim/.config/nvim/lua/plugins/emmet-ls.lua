return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "emmet-language-server")
      end,
    },
  },
  opts = function(_, opts)
    opts.servers = opts.servers or {}
    opts.servers["emmet_language_server"] = {
      filetypes = { "html", "css", "javascript", "javascriptreact", "typescriptreact", "heex" },
      init_options = {
        includeLanguages = {
          heex = "html",
        },
        showExpandedAbbreviation = "always",
        showAbbreviationSuggestions = true,
        showSuggestionsAsSnippets = false,
      },
    }
  end,
}
