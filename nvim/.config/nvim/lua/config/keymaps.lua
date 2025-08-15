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

-- Shift+Tab unindents current line
vim.keymap.set("n", "<S-Tab>", "<<", { noremap = true })
vim.keymap.set("v", "<S-Tab>", "<gv", { noremap = true })
vim.keymap.set("i", "<S-Tab>", "<C-o><<", { noremap = true })

-- MacOS MIRRORS
-- Line/word deletion (cmd/alt+backspace)
vim.keymap.set({ "i", "n", "v" }, "<A-BS>", "<C-w>", { desc = "Delete preceding word" })
vim.keymap.set({ "i", "n", "v" }, "<D-BS>", "<C-u>", { desc = "Delete to beginning of line" })
-- Beginning/end line navigation (cmd+left/right)
vim.keymap.set({ "n", "v" }, "<C-a>", "0", { desc = "Go to beginning of line" })
vim.keymap.set({ "n", "v" }, "<C-e>", "$", { desc = "Go to end of line" })
vim.keymap.set("i", "<C-a>", "<C-o>0", { desc = "Go to beginning of line" })
vim.keymap.set("i", "<C-e>", "<C-o>$", { desc = "Go to end of line" })
-- Beginning/end line selection (shift+cmd+left/right)
vim.keymap.set("n", "<D-S-Left>", "v0", { desc = "Select to beginning of line" })
vim.keymap.set("n", "<D-S-Right>", "v$", { desc = "Select to end of line" })
vim.keymap.set("v", "<D-S-Left>", "0", { desc = "Extend selection to beginning of line" })
vim.keymap.set("v", "<D-S-Right>", "$", { desc = "Extend selection to end of line" })
vim.keymap.set("i", "<D-S-Left>", "<Esc>v0", { desc = "Select to beginning of line" })
vim.keymap.set("i", "<D-S-Right>", "<Esc>v$", { desc = "Select to end of line" })
-- Prev/next word navigation (alt+left/right)
vim.keymap.set({ "n", "v" }, "<M-Left>", "b", { desc = "Go to preceding word" })
vim.keymap.set({ "n", "v" }, "<M-f>", "w", { desc = "Go to next word" }) -- Use M-f instead of M-Right
vim.keymap.set("i", "<M-Left>", "<C-o>b", { desc = "Go to preceding word" })
vim.keymap.set("i", "<M-f>", "<C-o>w", { desc = "Go to next word" })
-- Prev/next word selection (shift+alt+left/right)
vim.keymap.set("n", "<M-S-Left>", "vb", { desc = "Select to preceding word" })
vim.keymap.set("n", "<M-S-Right>", "ve", { desc = "Select to next word end" })
vim.keymap.set("v", "<M-S-Left>", "b", { desc = "Extend selection to preceding word" })
vim.keymap.set("v", "<M-S-Right>", "e", { desc = "Extend selection to next word end" })
vim.keymap.set("i", "<M-S-Left>", "<Esc>vb", { desc = "Select to preceding word" })
vim.keymap.set("i", "<M-S-Right>", "<Esc>ve", { desc = "Select to next word end" })
-- Surround with common pairs
vim.keymap.set("v", '"', 'c""<Esc>P', { desc = "Surround with double quotes", nowait = true })
vim.keymap.set("v", "'", "c''<Esc>P", { desc = "Surround with single quotes", nowait = true })
vim.keymap.set("v", "(", "c()<Esc>P", { desc = "Surround with parentheses", nowait = true })
vim.keymap.set("v", "[", "c[]<Esc>P", { desc = "Surround with brackets", nowait = true })
vim.keymap.set("v", "{", "c{}<Esc>P", { desc = "Surround with braces", nowait = true })
