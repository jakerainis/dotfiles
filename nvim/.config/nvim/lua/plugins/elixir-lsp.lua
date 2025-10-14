return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        elixir = {
          -- Use the expert LSP from Mason
          cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/expert") },

          -- Optimize for umbrella apps
          settings = {
            elixir = {
              -- Disable automatic compilation to avoid blocking
              autoBuild = false,

              -- Increase timeouts for large umbrella projects
              dialyzer = {
                enabled = false, -- Disable dialyzer for faster responses
              },

              -- Enable incremental compilation
              incrementalDialyzer = false,

              -- Optimize for umbrella apps
              projectDir = ".",
              mixEnv = "dev",
              mixTarget = "host",

              -- Reduce memory usage
              signatureHelp = {
                enabled = true,
              },

              -- Enable suggestions but don't auto-fetch
              suggest = {
                enabled = true,
              },
            },
          },

          -- Optimize LSP client flags
          flags = {
            debounce_text_changes = 500, -- Wait 500ms before sending changes
            allow_incremental_sync = true,
          },

          -- Root directory detection for umbrella apps
          root_dir = function(fname)
            local util = require("lspconfig.util")
            -- Look for mix.exs in parent directories (umbrella root)
            return util.root_pattern("mix.exs", ".git")(fname)
          end,

          on_attach = function(client, bufnr)
            -- Disable semantic tokens for better performance
            client.server_capabilities.semanticTokensProvider = nil

            -- Optional: Add keybindings or custom logic here
          end,
        },
      },
    },
  },
}
