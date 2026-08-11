local explorer_ignore = {
  ".claude",
  ".devcontainer",
  ".DS_Store",
  ".elixir_ls",
  ".expert",
  ".git",
  "_build",
}

-- Change this to swap the dashboard splash. Run `:MilliPreview <name>` to try one
-- without committing, or `:lua print(vim.inspect(require("milli").list()))` to list all.
-- local dashboard_splash = "torus"
local dashboard_splash = "torus"

return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  dependencies = { "amansingh-afk/milli.nvim" },
  opts = function()
    local splash = require("milli").load({ splash = dashboard_splash })
    return {
      dashboard = {
        enabled = true,
        preset = {
          header = table.concat(splash.frames[1], "\n"),
          --   keys = {
          --     { icon = " ", key = "f", desc = "Find File",    action = ":lua Snacks.picker.files()" },
          --     { icon = " ", key = "n", desc = "New File",     action = ":ene | startinsert" },
          --     { icon = " ", key = "g", desc = "Find Text",    action = ":lua Snacks.picker.grep()" },
          --     { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
          --     {
          --       icon = " ",
          --       key = "c",
          --       desc = "Config",
          --       action = ":lua Snacks.picker.files({ cwd = vim.fn.stdpath('config') })",
          --     },
          --     { icon = " ", key = "s", desc = "Restore Session", action = ":lua MiniSessions.select()" },
          --     { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          --     { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          --   },
        },
        sections = {
          { section = "header" },
          -- { section = "keys",   gap = 1, padding = 1 },
          -- { section = "startup" },
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

      -- Lazygit integration
      lazygit = {
        configure = true,
      },

      -- Smooth scrolling
      scroll = { enabled = true },

      -- Disable other snacks features (we're using mini for these)
      bigfile = { enabled = false },
      notifier = { enabled = false },
      quickfile = { enabled = false },
      statuscolumn = { enabled = false },
      words = { enabled = false },
    }
  end,

  config = function(_, opts)
    -- We don't use `require("milli").snacks(...)` because its callback relies on
    -- `vim.api.nvim_get_current_buf()` inside a `vim.schedule` — the current
    -- buffer can shift between event-fire and the scheduled callback, and the
    -- event's own `args.buf` isn't always the dashboard either (depends on what
    -- was focused when snacks called `nvim_exec_autocmds`). So we just scan all
    -- buffers for the `snacks_dashboard` filetype and attach there.
    local function find_dashboard_buf()
      for _, b in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_valid(b) and vim.bo[b].filetype == "snacks_dashboard" then
          return b
        end
      end
    end

    vim.api.nvim_create_autocmd("User", {
      group = vim.api.nvim_create_augroup("milli_snacks_dashboard", { clear = true }),
      pattern = { "SnacksDashboardOpened", "SnacksDashboardUpdatePost" },
      callback = function()
        local buf = find_dashboard_buf()
        if buf and not vim.b[buf].milli_playing then
          vim.b[buf].milli_playing = true
          require("milli.runtime").play(buf, { splash = dashboard_splash, loop = true })
        end
      end,
    })

    require("snacks").setup(opts)
  end,

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
    { "<leader>s/", function() Snacks.picker.lines() end,     desc = "Search buffer lines" },
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
    { "<leader>gg", function() Snacks.lazygit() end,          desc = "LazyGit" },
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
