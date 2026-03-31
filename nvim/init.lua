-- Set leader key before anything else
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load configuration modules
require("config.options")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.lsp")
