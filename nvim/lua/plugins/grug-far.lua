return {
  "MagicDuck/grug-far.nvim",
  cmd = "GrugFar",
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open()
      end,
      desc = "Search and replace",
    },
    {
      "<leader>sr",
      function()
        require("grug-far").with_visual_selection()
      end,
      mode = "v",
      desc = "Search and replace (selection)",
    },
    {
      "<leader>sw",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      desc = "Search word under cursor",
    },
  },
  opts = {
    headerMaxWidth = 80,
    keymaps = {
      replace = { n = "\\r" },
      qflist = { n = "\\q" },
      syncLocations = { n = "\\s" },
      syncLine = { n = "\\l" },
      close = { n = "\\c" },
      historyOpen = { n = "\\t" },
      historyAdd = { n = "\\a" },
      refresh = { n = "\\f" },
      openLocation = { n = "\\o" },
      gotoLocation = { n = "<enter>" },
      pickHistoryEntry = { n = "<enter>" },
      abort = { n = "\\b" },
      toggleShowCommand = { n = "\\p" },
      swapEngine = { n = "\\e" },
    },
  },
}
