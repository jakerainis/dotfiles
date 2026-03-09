return {
  cmd = { "emmet-language-server", "--stdio" },
  filetypes = {
    "css",
    "elixir",
    "heex",
    "html",
    "javascript",
    "javascriptreact",
    "typescriptreact",
  },
  root_markers = { ".git", "package.json" },
  init_options = {
    includeLanguages = {
      elixir = "html",
      heex = "html",
    },
    showExpandedAbbreviation = "always",
    showAbbreviationSuggestions = true,
    showSuggestionsAsSnippets = false,
  },
}
