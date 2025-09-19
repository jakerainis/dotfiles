return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    -- Load friendly snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Load custom snippets from snippets directory
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
  end,
}
