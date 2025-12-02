-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Use vim.keymap.set to create the keymaps (LazyVim style)

-- GENERAL BINDINGS
-- Disable arrow keys
vim.keymap.set({ "i", "n", "v" }, "<Up>", "<Cmd>echo 'Use k instead'<CR>", { desc = "Disable Up Arrow" })
vim.keymap.set({ "i", "n", "v" }, "<Down>", "<Cmd>echo 'Use j instead'<CR>", { desc = "Disable Down Arrow" })
vim.keymap.set({ "i", "n", "v" }, "<Left>", "<Cmd>echo 'Use h instead'<CR>", { desc = "Disable Left Arrow" })
vim.keymap.set({ "i", "n", "v" }, "<Right>", "<Cmd>echo 'Use l instead'<CR>", { desc = "Disable Right Arrow" })

-- Comments (cmd+/)
vim.keymap.set({ "n", "v" }, "<D-/>", "gcc", { desc = "Toggle comment", remap = true })

-- Multicusor (cmd+d)
vim.keymap.set({ "n", "v" }, "<D-d>", "<C-n>", { desc = "Multi-cursor select next", remap = true })

-- Sort lines (cmd+shift+a)
vim.keymap.set({ "n", "v" }, "<D-A>", ":sort<CR>", { desc = "Sort lines", remap = true })

-- Tab indents current line
vim.keymap.set("n", "<Tab>", ">>", { noremap = true })
vim.keymap.set("v", "<Tab>", ">gv", { noremap = true })

-- Shift+Tab unindents current line
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true })

-- Line/word deletion (cmd/alt+backspace)
vim.keymap.set({ "i", "n", "v" }, "<A-BS>", "<C-w>", { desc = "Delete preceding word" })
vim.keymap.set({ "i", "n", "v" }, "<D-BS>", "<C-u>", { desc = "Delete to beginning of line" })

-- Save file (cmd+s)
vim.keymap.set({ "n", "i", "v" }, "<D-s>", "<Esc>:w<CR>", { desc = "Save file" })

-- Copy relative path of current buffer with line numbers
local function copy_path_with_lines()
  local relative_path = vim.fn.expand("%:.")
  local mode = vim.api.nvim_get_mode().mode

  local result
  if mode == "v" or mode == "V" or mode == "\22" then -- visual, visual-line, or visual-block
    local start_line = vim.fn.line("v")
    local end_line = vim.fn.line(".")
    -- Ensure start_line <= end_line
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end

    if start_line == end_line then
      result = string.format("%s:%d", relative_path, start_line)
    else
      result = string.format("%s:%d-%d", relative_path, start_line, end_line)
    end
  else -- normal mode
    local current_line = vim.fn.line(".")
    result = string.format("%s:%d", relative_path, current_line)
  end

  vim.fn.setreg("+", result)
  vim.notify("Copied: " .. result, vim.log.levels.INFO)
end

vim.keymap.set({ "n", "v" }, "<leader>r", copy_path_with_lines, {
  noremap = true,
  silent = true,
  desc = "Copy relative path with line numbers",
})

-- Custom directory search
LazyVim.safe_keymap_set("n", "<leader>sf", function()
  local dir = vim.fn.input("Search in directory: ", vim.fn.getcwd() .. "/", "dir")
  if dir ~= "" then
    LazyVim.pick("grep", { cwd = dir })()
  end
end, { desc = "Grep (Custom Dir)" })
