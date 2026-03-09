-- Flash: quick jump/navigation
-- Press 's' then type characters to jump to any match on screen.
-- Labels appear over matches so you can pick one with a single keystroke.
-- 'S' selects treesitter nodes (great for selecting functions, blocks, etc.)
return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  },
}
