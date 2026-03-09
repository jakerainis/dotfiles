-- Noice: replaces the default command line, messages, and notifications
-- with a nicer floating UI. Also fixes cmdheight=0 message issues.
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup",    -- Floating popup instead of bottom bar
      opts = {
        position = {
          row = "20%",           -- Near top of screen
          col = "50%",
        },
        size = {
          width = 60,
          height = "auto",
        },
        border = {
          style = "rounded",
        },
      },
    },
    messages = {
      enabled = true,
    },
    popupmenu = {
      enabled = true,
    },
    lsp = {
      override = {
        -- Let noice handle LSP markdown rendering (nicer formatting)
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
      },
    },
    presets = {
      bottom_search = false,         -- Search stays at bottom (vs floating)
      command_palette = true,         -- Grouped command palette style
      long_message_to_split = true,   -- Long messages go to a split
    },
  },
}
