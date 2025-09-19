return {
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    },
  },
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      -- your configuration comes here
      global_keymaps = true,
    },
    init = function()
      local wk = require("which-key")
      wk.add({
        { "<leader>R", group = "REST" }, -- group
      })
    end,
    config = function(_, opts)
      require("kulala").setup(opts)
    end,
  },
}
