return {
  ---------------------------------------------------------------------------
  -- Mason: auto-installs LSP servers, formatters, linters
  ---------------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    lazy = false, -- Load early so Mason's PATH is available for LSP servers
    keys = {
      { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" },
    },
    opts = {},
    config = function(_, opts)
      require("mason").setup(opts)
      -- Add Mason's bin to PATH so native vim.lsp.enable() can find servers
      vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
    end,
  },

  ---------------------------------------------------------------------------
  -- Mason-lspconfig: ensures servers are installed via Mason
  ---------------------------------------------------------------------------
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssls",
          "emmet_language_server",
          "expert",
          "html",
          "jsonls",
          "lua_ls",
          "tailwindcss",
          "ts_ls",
          "yamlls",
        },
      })
    end,
  },
}
