-- Keymaps
local map = vim.keymap.set
local fn = require("config.functions")

--------------------------------------------------------------------------------
-- GENERAL
--------------------------------------------------------------------------------

map("n", "<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
map("n", "<leader>qq", "<cmd>qa<CR>", { desc = "Quit all" })
map("n", "<leader>l", "<cmd>Lazy<CR>", { desc = "Lazy" })
map({ "n", "i", "v" }, "<D-s>", "<Esc>:w<CR>", { desc = "Save file" })

--------------------------------------------------------------------------------
-- NAVIGATION
--------------------------------------------------------------------------------

map("n", "<C-d>", "<C-d>", { desc = "Scroll down" })
map("n", "<C-u>", "<C-u>", { desc = "Scroll up" })
map("n", "n", "'Nn'[v:searchforward].'zzzv'", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward].'zzzv'", { expr = true, desc = "Prev search result" })

--------------------------------------------------------------------------------
-- WINDOWS
--------------------------------------------------------------------------------

map("n", "<leader>wr", fn.resize_mode, { desc = "Resize mode (h/j/k/l)" })
map("n", "<leader>w=", "<C-w>=", { desc = "Equal window sizes" })
map("n", "<leader>w|", "<C-w>|", { desc = "Max width" })
map("n", "<leader>w_", "<C-w>_", { desc = "Max height" })
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Horizontal split" })
map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Vertical split" })

--------------------------------------------------------------------------------
-- TERMINAL
--------------------------------------------------------------------------------

map("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window" })
map("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to lower window" })
map("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to upper window" })
map("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window" })
map({ "n", "t" }, "<C-/>", fn.toggle_terminal, { desc = "Toggle terminal" })
map({ "n", "t" }, "<C-_>", fn.toggle_terminal, { desc = "Toggle terminal" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
map("t", "gf", "<C-\\><C-n>gf", { desc = "Open file under cursor" })

--------------------------------------------------------------------------------
-- BUFFERS
--------------------------------------------------------------------------------

map("n", "<leader>bb", "<cmd>e #<CR>", { desc = "Switch to other buffer" })
map("n", "<leader>bD", "<cmd>bdelete<CR><cmd>close<CR>", { desc = "Delete buffer and window" })
map("n", "<leader>bo", fn.delete_other_buffers, { desc = "Delete other buffers" })
map("n", "<leader>fn", "<cmd>enew<CR>", { desc = "New buffer" })

--------------------------------------------------------------------------------
-- EDITING
--------------------------------------------------------------------------------

map("n", "<Tab>", ">>", { noremap = true, desc = "Indent line" })
map("v", "<Tab>", ">gv", { noremap = true, desc = "Indent selection" })
map("n", "<S-Tab>", "<<", { noremap = true, desc = "Unindent line" })
map("v", "<S-Tab>", "<gv", { noremap = true, desc = "Unindent selection" })
map({ "n", "v" }, "<D-A>", ":sort<CR>", { desc = "Sort lines" })
map({ "i", "n", "v" }, "<A-BS>", "<C-w>", { desc = "Delete preceding word" })
map({ "i", "n", "v" }, "<D-BS>", "<C-u>", { desc = "Delete to beginning of line" })
map({ "n", "v" }, "<D-/>", "gcc", { desc = "Toggle comment", remap = true })

--------------------------------------------------------------------------------
-- CODE UTILITIES
--------------------------------------------------------------------------------

map("n", "<leader>cj", fn.format_with("jq ."), { desc = "Format JSON with jq" })
map("n", "<leader>cx", fn.format_with("xmllint --format -"), { desc = "Format XML with xmllint" })

--------------------------------------------------------------------------------
-- YANK / CLIPBOARD
--------------------------------------------------------------------------------

map({ "n", "v" }, "d", '"_d', { noremap = true, desc = "Delete without yanking" })
map({ "n", "v" }, "D", '"_D', { noremap = true, desc = "Delete to EOL without yanking" })
map({ "n", "v" }, "c", '"_c', { noremap = true, desc = "Change without yanking" })
map({ "n", "v" }, "C", '"_C', { noremap = true, desc = "Change to EOL without yanking" })
map("x", "p", [["_dP]], { desc = "Paste without overwriting register" })

map({ "n", "v" }, "<leader>yf", fn.copy_path, { noremap = true, silent = true, desc = "Copy file path" })
map(
  { "n", "v" },
  "<leader>yl",
  fn.copy_path_with_lines,
  { noremap = true, silent = true, desc = "Copy path with line numbers" }
)
map(
  { "n", "v" },
  "<leader>r",
  fn.copy_path_with_lines,
  { noremap = true, silent = true, desc = "Copy path with line numbers" }
)
map("n", "<leader>ya", "<cmd>%y+<CR>", { desc = "Yank entire file" })
map("n", "<leader>yp", fn.open_from_clipboard, { desc = "Open file:line from clipboard" })
