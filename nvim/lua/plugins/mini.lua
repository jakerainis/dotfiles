return {
  "echasnovski/mini.nvim",
  lazy = false,
  priority = 100,
  config = function()
    ---------------------------------------------------------------------------
    -- AI (Text Objects)
    -- Enhanced text objects: a = around, i = inside
    -- Works with quotes, brackets, tags, functions, arguments, etc.
    -- Examples: va) = select around parens, ciq = change inside quotes
    ---------------------------------------------------------------------------
    require("mini.ai").setup()

    ---------------------------------------------------------------------------
    -- BUFREMOVE
    -- Delete buffers without closing windows
    ---------------------------------------------------------------------------
    require("mini.bufremove").setup()

    ---------------------------------------------------------------------------
    -- CLUE
    -- Shows available keybindings in a popup (like which-key)
    ---------------------------------------------------------------------------
    local miniclue = require("mini.clue")
    miniclue.setup({
      triggers = {
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },
        { mode = "i", keys = "<C-x>" },
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
        { mode = "n", keys = "<C-w>" },
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
      },
      clues = {
        { mode = "n", keys = "<Leader>b", desc = "+buffer" },
        { mode = "n", keys = "<Leader>c", desc = "+code" },
        { mode = "n", keys = "<Leader>f", desc = "+find" },
        { mode = "n", keys = "<Leader>g", desc = "+git" },
        { mode = "n", keys = "<Leader>q", desc = "+quit" },
        { mode = "n", keys = "<Leader>s", desc = "+search" },
        { mode = "n", keys = "<Leader>S", desc = "+session" },
        { mode = "n", keys = "<Leader>t", desc = "+test" },
        { mode = "n", keys = "<Leader>w", desc = "+window" },
        { mode = "n", keys = "<Leader>y", desc = "+yank" },
        { mode = "n", keys = "gs",        desc = "+surround" },
        { mode = "x", keys = "gs",        desc = "+surround" },
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },
      window = {
        delay = 300,
        config = {
          width = "auto",
          border = "rounded",
        },
      },
    })

    ---------------------------------------------------------------------------
    -- COMMENT
    -- Toggle comments with gcc (line) or gc{motion}
    ---------------------------------------------------------------------------
    require("mini.comment").setup()

    ---------------------------------------------------------------------------
    -- CURSORWORD
    -- Highlight all instances of the word under cursor
    ---------------------------------------------------------------------------
    require("mini.cursorword").setup()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "minifiles", "lazy", "mason", "snacks_dashboard" },
      callback = function()
        vim.b.minicursorword_disable = true
      end,
    })

    ---------------------------------------------------------------------------
    -- FILES
    -- File explorer with preview
    -- h/l to navigate, q to close, = to sync changes
    ---------------------------------------------------------------------------
    require("mini.files").setup({
      mappings = {
        close = "q",
        go_in = "l",
        go_in_plus = "<CR>",
        go_out = "h",
        go_out_plus = "-",
        reset = "<BS>",
        reveal_cwd = "@",
        show_help = "g?",
        synchronize = "=",
        trim_left = "<",
        trim_right = ">",
      },
      windows = {
        preview = true,
        width_focus = 30,
        width_nofocus = 15,
        width_preview = 80,
      },
    })

    -- Shift+Enter in mini.files: pick a window to open the file in
    -- Shows a letter label on each window so you can choose where the file opens
    vim.api.nvim_create_autocmd("User", {
      pattern = "MiniFilesBufferCreate",
      callback = function(args)
        vim.keymap.set("n", "<S-CR>", function()
          local entry = MiniFiles.get_fs_entry()
          if not entry or entry.fs_type ~= "file" then return end

          MiniFiles.close()

          -- Get all normal (non-floating) windows
          local wins = vim.tbl_filter(function(w)
            return vim.api.nvim_win_get_config(w).relative == ""
          end, vim.api.nvim_list_wins())

          if #wins <= 1 then
            vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
            return
          end

          -- Label each window with a letter
          local labels = "abcdefghijklmnop"
          local saved = {}
          for i, win in ipairs(wins) do
            local char = labels:sub(i, i)
            local buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "  " .. char:upper() .. "  " })
            local w = vim.api.nvim_win_get_width(win)
            local h = vim.api.nvim_win_get_height(win)
            local float = vim.api.nvim_open_win(buf, false, {
              relative = "win",
              win = win,
              width = 5,
              height = 1,
              col = math.floor(w / 2) - 2,
              row = math.floor(h / 2),
              style = "minimal",
              border = "rounded",
              zindex = 100,
            })
            vim.api.nvim_set_hl(0, "MiniFilesPickWin", { link = "Visual" })
            vim.api.nvim_win_set_option(float, "winhl", "Normal:MiniFilesPickWin")
            saved[char] = { win = win, float = float, buf = buf }
          end

          vim.cmd("redraw")
          local key = vim.fn.getcharstr():lower()

          -- Clean up label floats
          for _, v in pairs(saved) do
            pcall(vim.api.nvim_win_close, v.float, true)
            pcall(vim.api.nvim_buf_delete, v.buf, { force = true })
          end

          if saved[key] then
            vim.api.nvim_set_current_win(saved[key].win)
            vim.cmd("edit " .. vim.fn.fnameescape(entry.path))
          end
        end, { buffer = args.data.buf_id, desc = "Open in picked window" })
      end,
    })

    ---------------------------------------------------------------------------
    -- ICONS
    -- File/filetype icons, used by other plugins
    ---------------------------------------------------------------------------
    require("mini.icons").setup()

    ---------------------------------------------------------------------------
    -- INDENTSCOPE
    -- Animated vertical line showing current indent scope
    ---------------------------------------------------------------------------
    require("mini.indentscope").setup({
      symbol = "│",
      options = {
        try_as_border = true,
      },
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "help", "lazy", "mason", "minifiles", "snacks_dashboard" },
      callback = function()
        vim.b.miniindentscope_disable = true
      end,
    })

    ---------------------------------------------------------------------------
    -- MOVE
    -- Move lines/selections with Alt+hjkl
    ---------------------------------------------------------------------------
    require("mini.move").setup()

    ---------------------------------------------------------------------------
    -- SESSIONS
    -- Session management with auto-save on exit
    ---------------------------------------------------------------------------
    require("mini.sessions").setup({
      autoread = false,
      autowrite = true,
    })
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        local dominated_ft = { "snacks_dashboard", "lazy", "mason", "minifiles", "" }
        local dominated_bt = { "nofile", "help", "terminal" }
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_loaded(buf) then
            local ft = vim.bo[buf].filetype
            local bt = vim.bo[buf].buftype
            if not vim.tbl_contains(dominated_ft, ft) and not vim.tbl_contains(dominated_bt, bt) then
              local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
              MiniSessions.write(name)
              return
            end
          end
        end
      end,
    })

    ---------------------------------------------------------------------------
    -- SPLITJOIN
    -- Toggle between single-line and multi-line with gS
    ---------------------------------------------------------------------------
    require("mini.splitjoin").setup({
      mappings = { toggle = "<leader>cs" },
    })

    ---------------------------------------------------------------------------
    -- STATUSLINE
    ---------------------------------------------------------------------------
    local statusline = require("mini.statusline")
    statusline.setup({
      content = {
        active = function()
          local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
          local mode_names = {
            n = "NORMAL",
            i = "INSERT",
            v = "VISUAL",
            V = "V-LINE",
            ["\22"] = "V-BLOCK",
            c = "COMMAND",
            R = "REPLACE",
            t = "TERMINAL",
          }
          mode = mode_names[vim.fn.mode()] or mode

          local rec = vim.fn.reg_recording()
          local recording = rec ~= "" and ("REC @" .. rec) or ""

          local git = statusline.section_git({ trunc_width = 40 })
          local head = vim.b.minigit_summary and vim.b.minigit_summary.head_name or ""
          if head ~= "" then
            git = head
          end

          local diagnostics = statusline.section_diagnostics({ trunc_width = 75 })
          local filename = statusline.section_filename({ trunc_width = 140 })
          local location = "%l:%c"
          local search = statusline.section_searchcount({ trunc_width = 75 })

          return statusline.combine_groups({
            { hl = mode_hl,                 strings = { mode } },
            { hl = "DiagnosticError",       strings = { recording } },
            { hl = "MiniStatuslineDevinfo", strings = { git } },
            "%<",
            { hl = "MiniStatuslineFilename", strings = { filename } },
            "%=",
            { hl = "MiniStatuslineDevinfo",  strings = { diagnostics } },
            { hl = "MiniStatuslineFileinfo", strings = { search } },
            { hl = mode_hl,                  strings = { location } },
          })
        end,
      },
    })

    ---------------------------------------------------------------------------
    -- SURROUND
    -- Add/delete/replace surrounding characters
    -- gsa{motion}{char} = add, gsd{char} = delete, gsr{old}{new} = replace
    ---------------------------------------------------------------------------
    require("mini.surround").setup({
      mappings = {
        add = "gsa",
        delete = "gsd",
        replace = "gsr",
        find = "gsf",
        find_left = "gsF",
        highlight = "gsh",
        update_n_lines = "gsn",
      },
    })
  end,

  ---------------------------------------------------------------------------
  -- KEYMAPS
  ---------------------------------------------------------------------------
  keys = {
    -- Buffer management
    {
      "<leader>bd",
      function()
        local buf = vim.api.nvim_get_current_buf()
        local bufs = vim.tbl_filter(function(b)
          return vim.bo[b].buflisted and vim.bo[b].buftype == ""
        end, vim.api.nvim_list_bufs())
        if #bufs <= 1 then
          vim.cmd("enew")
        end
        MiniBufremove.delete(buf)
      end,
      desc = "Delete buffer",
    },
    {
      "<leader>bw",
      function()
        local buf = vim.api.nvim_get_current_buf()
        local bufs = vim.tbl_filter(function(b)
          return vim.bo[b].buflisted and vim.bo[b].buftype == ""
        end, vim.api.nvim_list_bufs())
        if #bufs <= 1 then
          vim.cmd("enew")
        end
        MiniBufremove.wipeout(buf)
      end,
      desc = "Wipeout buffer",
    },

    -- File explorer
    {
      "<leader>e",
      function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" or not vim.uv.fs_stat(path) then
          path = vim.fn.getcwd()
        end
        MiniFiles.open(path, false)
      end,
      desc = "Explorer (current file)",
    },
    {
      "-",
      function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" or not vim.uv.fs_stat(path) then
          path = vim.fn.getcwd()
        end
        MiniFiles.open(path, false)
      end,
      desc = "Open parent directory",
    },
    {
      "<leader>E",
      function()
        MiniFiles.open(vim.fn.getcwd(), false)
      end,
      desc = "Explorer (cwd)",
    },

    -- Find/Pick (using snacks.picker — keymaps defined in snacks.lua)

    -- Sessions (leader+S)
    {
      "<leader>Ss",
      function()
        local name = vim.fn.input("Session name: ", vim.fn.fnamemodify(vim.fn.getcwd(), ":t"))
        if name ~= "" then
          MiniSessions.write(name)
        end
      end,
      desc = "Save session",
    },
    {
      "<leader>Sl",
      function()
        MiniSessions.select()
      end,
      desc = "Load session",
    },
    {
      "<leader>Sd",
      function()
        MiniSessions.select("delete")
      end,
      desc = "Delete session",
    },
    {
      "<leader>Sr",
      function()
        local name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        if MiniSessions.detected[name] then
          MiniSessions.read(name)
        else
          vim.notify("No session found for: " .. name, vim.log.levels.WARN)
        end
      end,
      desc = "Restore session (cwd)",
    },
  },
}
