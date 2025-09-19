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
--vim.keymap.set("i", "<Tab>", "<C-o>>>", { noremap = true })

-- Shift+Tab unindents current line
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true })
--vim.keymap.set("i", "<S-Tab>", "<C-o><<", { noremap = true })

-- Line/word deletion (cmd/alt+backspace)
vim.keymap.set({ "i", "n", "v" }, "<A-BS>", "<C-w>", { desc = "Delete preceding word" })
vim.keymap.set({ "i", "n", "v" }, "<D-BS>", "<C-u>", { desc = "Delete to beginning of line" })

-- Save file (cmd+s)
vim.keymap.set({ "n", "i", "v" }, "<D-s>", "<Esc>:w<CR>", { desc = "Save file" })

-- Copy relative path of current buffer
vim.api.nvim_set_keymap(
  "n",
  "<leader>r",
  ':let @+=expand("%:.")<CR>',
  { noremap = true, silent = true, desc = "Copy relative path" }
)

-- local map = LazyVim.safe_keymap_set
--
-- -- Format the current buffer as JSON
-- map("n", "<leader>cj", function()
--   local cursor_pos = vim.fn.getcurpos()
--   vim.cmd(":%!jq .")
--   vim.fn.setpos(".", cursor_pos)
-- end, { desc = "Format JSON with jq" })
--
-- map("n", "<leader>cx", function()
--   local cursor_pos = vim.fn.getcurpos()
--   vim.cmd(":%!xmllint --format -")
--   vim.fn.setpos(".", cursor_pos)
-- end, { desc = "Format XML with xmllint" })
--
-- -- Custom directory search
-- map("n", "<leader>sf", function()
--   local dir = vim.fn.input("Search in directory: ", vim.fn.getcwd() .. "/", "dir")
--   if dir ~= "" then
--     LazyVim.pick("grep", { cwd = dir })()
--   end
-- end, { desc = "Grep (Custom Dir)" })
