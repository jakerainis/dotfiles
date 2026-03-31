return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",            -- Only load when you start typing
  dependencies = {
    "rafamadriz/friendly-snippets", -- Collection of common snippets
  },
  opts = {
    -- Don't show completions in picker prompts
    enabled = function()
      return vim.bo.buftype ~= "prompt" and vim.bo.filetype ~= "minipick"
    end,

    keymap = {
      preset = "default",
      ["<C-k>"] = { "select_prev", "fallback" },   -- Navigate up
      ["<C-j>"] = { "select_next", "fallback" },   -- Navigate down
      ["<CR>"] = { "accept", "fallback" },         -- Confirm selection
      ["<Tab>"] = { "select_next", "fallback" },   -- Tab cycles forward
      ["<S-Tab>"] = { "select_prev", "fallback" }, -- Shift+Tab cycles back
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "mono",
    },

    completion = {
      documentation = {
        auto_show = true, -- Show docs popup alongside completions
        auto_show_delay_ms = 200,
      },
      menu = {
        border = "rounded",
      },
    },

    -- Completion sources in priority order
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        snippets = {
          opts = {
            search_paths = { vim.fn.stdpath("config") .. "/snippets" },
          },
        },
      },
    },
  },
}
