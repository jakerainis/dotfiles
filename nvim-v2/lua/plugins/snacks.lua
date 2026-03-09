local explorer_ignore = {
  ".claude",
  ".devcontainer",
  ".DS_Store",
  ".elixir_ls",
  ".expert",
  ".git",
  "_build",
}

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    dashboard = {
      enabled = true,
      preset = {
        header = table.concat({
          [[                                       u            @88>                      ]],
          [[   u.    u.                     u.    88Nu.   u.    %8P      ..    .     :     ]],
          [[ x@88k u@88c.      .u     ...ue888b  '88888.o888c    .     .888: x888  x888.  ]],
          [[^"8888""8888"   ud8888.   888R Y888r  ^8888  8888  .@88u  ~`8888~'888X`?888f` ]],
          [[  8888  888R  :888'8888.  888R I888>   8888  8888 ''888E`   X888  888X '888>   ]],
          [[  8888  888R  d888 '88%"  888R I888>   8888  8888   888E    X888  888X '888>   ]],
          [[  8888  888R  8888.+"     888R I888>   8888  8888   888E    X888  888X '888>   ]],
          [[  8888  888R  8888L      u8888cJ888   .8888b.888P   888E    X888  888X '888>   ]],
          [[ "*88*" 8888" '8888c. .+  "*888*P"     ^Y8888*""    888&   "*88%""*88" '888!`  ]],
          [[   ""   'Y"    "88888%      'Y"          `Y"        R888"    `~    "    `"`    ]],
          [[                 "YP'                                ""                       ]],
        }, "\n"),
        keys = {
          { icon = " ", key = "f", desc = "Find File",    action = ":lua Snacks.picker.files()" },
          { icon = " ", key = "n", desc = "New File",     action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text",    action = ":lua Snacks.picker.grep()" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })",
          },
          { icon = " ", key = "s", desc = "Restore Session", action = ":lua MiniSessions.select()" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys",   gap = 1, padding = 1 },
        { section = "startup" },
      },
    },

    ---------------------------------------------------------------------------
    -- PICKER
    -- Fuzzy finder with preview for files, grep, buffers, etc.
    -- Replaces mini.pick with side-by-side preview support
    ---------------------------------------------------------------------------
    picker = {
      enabled = true,
      sources = {
        files = {
          hidden = true,
        },
        grep = {
          hidden = true,
        },
        buffers = {
          -- Current buffer at top, sorted by recency
          current = true,
        },
        explorer = {
          exclude = explorer_ignore,
          hidden = true,
          ignored = true,
        },
      },
    },

    ---------------------------------------------------------------------------
    -- EXPLORER
    -- Sidebar file tree (like VS Code), separate from mini.files
    ---------------------------------------------------------------------------
    explorer = { enabled = true },

    -- Floating input prompts
    input = { enabled = true },

    -- Smooth scrolling
    scroll = { enabled = true },

    -- Disable other snacks features (we're using mini for these)
    bigfile = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
  },

  ---------------------------------------------------------------------------
  -- KEYMAPS
  ---------------------------------------------------------------------------
  keys = {
    -- Quick access
    {
      "<leader><leader>",
      function() Snacks.picker.files() end,
      desc = "Find files"
    },
    {
      "<leader>/",
      function() Snacks.picker.grep() end,
      desc = "Grep"
    },
    {
      "<leader>,",
      function()
        if not pcall(Snacks.picker.resume, { source = "buffers" }) then
          Snacks.picker
              .buffers()
        end
      end,
      desc = "Switch buffer (resume)",
    },

    -- Find (leader+f)
    {
      "<leader>fd",
      function() Snacks.picker.diagnostics() end,
      desc = "Diagnostics"
    },
    {
      "<leader>fk",
      function() Snacks.picker.keymaps() end,
      desc = "Keymaps"
    },
    {
      "<leader>f:",
      function() Snacks.picker.commands() end,
      desc = "Commands",
    },
    {
      "<leader>fm",
      function() Snacks.picker.marks() end,
      desc = "Marks",
    },

    -- Search (leader+s)
    { "<leader>s/", function() Snacks.picker.lines() end, desc = "Search buffer lines" },
    {
      "<leader>ss",
      function() Snacks.picker.lsp_symbols() end,
      desc = "Document symbols",
    },
    {
      "<leader>sG",
      function()
        local glob = vim.fn.input("Glob pattern: ")
        if glob ~= "" then Snacks.picker.grep({ glob = glob }) end
      end,
      desc = "Grep (glob filter)",
    },
    {
      "<leader>sd",
      function()
        local file_dir = vim.fn.expand("%:p:h")
        local default_dir = vim.fn.fnamemodify(file_dir, ":.")
        if default_dir == "" or default_dir == file_dir then default_dir = "." end
        Snacks.input({
          prompt = "Search in directory",
          default = default_dir .. "/",
        }, function(dir)
          if dir and dir ~= "" then
            local abs = vim.fn.fnamemodify(dir, ":p")
            Snacks.picker.grep({ cwd = abs })
          end
        end)
      end,
      desc = "Grep (custom dir)",
    },

    -- Git
    { "<leader>gg", function() Snacks.lazygit() end, desc = "LazyGit" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "LazyGit file history" },

    -- Explorer (sidebar file tree)
    {
      "<leader>p",
      function() Snacks.explorer() end,
      desc = "Explorer (current file)",
    },
    {
      "<leader>P",
      function() Snacks.explorer({ cwd = vim.fn.getcwd() }) end,
      desc = "Explorer (cwd)",
    },
  },
}
