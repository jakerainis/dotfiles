-- Options
local opt = vim.opt
local g = vim.g

-- Disable netrw (we use mini.files instead)
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10 -- Max items in completion popup

-- Files
opt.autoread = true  -- Auto-reload files changed outside vim
opt.backup = false   -- Don't create backup files
opt.swapfile = false -- Don't create swap files
opt.undodir = vim.fn.stdpath("state") .. "/undo"
opt.undofile = true  -- Persist undo history to disk

-- Folding (native treesitter)
opt.foldenable = true
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldlevel = 99 -- Start with all folds open
opt.foldlevelstart = 99
opt.foldmethod = "expr"

-- Indentation
opt.expandtab = true   -- Use spaces instead of tabs
opt.shiftwidth = 2     -- Indent by 2 spaces when using >> or <<
opt.tabstop = 2        -- A tab character displays as 2 spaces
opt.softtabstop = 2    -- Insert 2 spaces when pressing Tab
opt.smartindent = true -- Auto-indent new lines based on syntax

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Search
opt.hlsearch = true   -- Highlight all search matches
opt.ignorecase = true -- Ignore case when searching...
opt.incsearch = true  -- Show matches as you type
opt.smartcase = true  -- ...unless search contains uppercase

-- UI
opt.cmdheight = 0         -- Hide command line when not in use
opt.cursorline = true     -- Highlight the current line
opt.laststatus = 3        -- Global statusline (single bar for all windows)
opt.ruler = false         -- Hide the default ruler (line,col) - statusline shows this
opt.scrolloff = 8         -- Keep 8 lines visible above/below cursor
opt.showmode = false      -- Don't show mode (statusline will handle it)
opt.sidescrolloff = 8     -- Keep 8 columns visible left/right of cursor
opt.signcolumn = "yes"    -- Always show sign column (for git/diagnostics)
opt.splitbelow = true     -- New horizontal splits open below
opt.splitright = true     -- New vertical splits open to the right
opt.termguicolors = true  -- Enable 24-bit RGB colors
opt.winborder = "rounded" -- Default border for all floating windows (hover, etc.)
opt.wrap = false          -- Don't wrap long lines

-- Misc
opt.breakindent = true        -- Wrapped lines preserve indentation
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.confirm = true            -- Prompt to save before quitting
opt.fillchars = { eob = " " } -- Hide ~ on empty lines
opt.hidden = true             -- Allow switching buffers without saving
opt.inccommand = "split"      -- Preview substitutions in split window
opt.list = true               -- Show invisible characters
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.mouse = "a"               -- Enable mouse in all modes
opt.timeoutlen = 300          -- Time to wait for mapped sequence (ms)
opt.updatetime = 250          -- Faster CursorHold events (default 4000ms)
