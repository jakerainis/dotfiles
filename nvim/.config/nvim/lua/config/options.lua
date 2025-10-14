-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.root_spec = { "cwd" } -- Set root directory to current working directory
vim.opt.autoread = true
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable virtual text for diagnostics
-- vim.diagnostic.config({
--   virtual_text = true,
-- })

vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "FocusGained" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})
