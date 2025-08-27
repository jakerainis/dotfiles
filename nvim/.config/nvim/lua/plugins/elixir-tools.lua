return {
  "elixir-tools/elixir-tools.nvim",
  version = "*",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local elixir = require("elixir")
    local elixirls = require("elixir.elixirls")

    elixir.setup({
      nextls = { enable = false },
      elixirls = {
        enable = true,
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/elixir-ls" },
        settings = elixirls.settings({
          dialyzerEnabled = false,
          enableTestLenses = false,
        }),
        on_attach = function(client, bufnr)
          -- Elixir-specific keymaps
          -- vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
          -- vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
          -- vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
          -- General LSP keymaps
          -- local opts = { buffer = bufnr, noremap = true, silent = true }
          -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          -- vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          -- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          -- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          -- vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        end,
      },
      projectionist = {
        enable = true,
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
