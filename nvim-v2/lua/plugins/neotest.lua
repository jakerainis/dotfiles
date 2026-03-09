return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "jfpedroza/neotest-elixir",
  },
  keys = {
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run test file",
    },
    {
      "<leader>ts",
      function()
        require("neotest").run.run({ suite = true })
      end,
      desc = "Run test suite",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Run last test",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "Show test output",
    },
    {
      "<leader>tO",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle output panel",
    },
    {
      "<leader>tS",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle summary",
    },
    {
      "<leader>tw",
      function()
        require("neotest").watch.toggle(vim.fn.expand("%"))
      end,
      desc = "Toggle watch",
    },
    {
      "[t",
      function()
        require("neotest").jump.prev({ status = "failed" })
      end,
      desc = "Previous failed test",
    },
    {
      "]t",
      function()
        require("neotest").jump.next({ status = "failed" })
      end,
      desc = "Next failed test",
    },
    {
      "<leader>td",
      function()
        require("neotest").output.open({ enter = true, last_run = true })
      end,
      desc = "Show last test output",
    },
  },
  config = function()
    -- Transform command for Workspace projects
    -- Instead of using workspace.run (which doesn't pass env vars),
    -- we cd into the app directory and run mix test directly
    local function workspace_post_process(cmd)
      local test_path_idx = nil
      local test_path = nil
      for i, arg in ipairs(cmd) do
        if arg:match("^apps/[%w_]+/test") then
          test_path_idx = i
          test_path = arg
          break
        end
      end

      if not test_path then
        return cmd
      end

      local project = test_path:match("^apps/([%w_]+)/")
      local relative_path = test_path:match("^apps/[%w_]+/(test/.+)$")

      if not project or not relative_path then
        return cmd
      end

      local inner_parts = {}
      for i, arg in ipairs(cmd) do
        if i == test_path_idx then
          table.insert(inner_parts, relative_path)
        else
          local escaped = arg:gsub("'", "'\"'\"'")
          table.insert(inner_parts, "'" .. escaped .. "'")
        end
      end

      local inner_cmd = table.concat(inner_parts, " ")
      local shell_cmd = string.format("cd apps/%s && %s", project, inner_cmd)

      return { "sh", "-c", shell_cmd }
    end

    require("neotest").setup({
      adapters = {
        require("neotest-elixir")({
          mix_task = "test",
          extra_formatters = {},
          post_process_command = workspace_post_process,
        }),
      },
      log_level = vim.log.levels.DEBUG,
      status = {
        virtual_text = true,
      },
      output = {
        open_on_run = "short",
      },
      output_panel = {
        enabled = true,
        open = "botright split | resize 15",
      },
      quickfix = {
        open = function()
          vim.cmd("copen")
        end,
      },
    })
  end,
}
