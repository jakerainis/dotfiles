-- Autocmds
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufEnter", "CursorHold", "FocusGained" }, {
  desc = "Check for file changes when focus returns",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

autocmd("BufReadPost", {
  desc = "Return to last edit position",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line_count = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= line_count then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

autocmd("BufWritePre", {
  desc = "Format with LSP before saving",
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

autocmd("FileType", {
  desc = "Close certain filetypes with q",
  pattern = { "help", "man", "qf", "checkhealth", "lazy" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<Cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

autocmd("VimResized", {
  desc = "Auto-resize splits on window resize",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
