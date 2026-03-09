-- LSP Configuration (Neovim 0.11+ native)
-- Server-specific configs live in nvim-v2/lsp/*.lua
-- Neovim has built-in configs for common servers (cssls, html, jsonls, etc.)

-- Enhance capabilities with blink.cmp if available
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok, blink = pcall(require, "blink.cmp")
if ok then
  capabilities = blink.get_lsp_capabilities(capabilities)
end

-- Default config shared by all servers
vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Enable servers
vim.lsp.enable("cssls")
vim.lsp.enable("emmet_language_server")
vim.lsp.enable("expert")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("lua_ls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("ts_ls")
vim.lsp.enable("yamlls")

-- Keymaps (only active when an LSP is attached to the buffer)
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gr", vim.lsp.buf.references, "Go to references")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "K", vim.lsp.buf.hover, "Hover documentation")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map({ "n", "v" }, "<leader>cf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format code")
  end,
})

-- Diagnostics
vim.diagnostic.config({
  virtual_lines = {
    current_line = true,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
