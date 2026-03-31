return {
  "TrevorS/uuid-nvim",
  lazy = true,
  event = "InsertEnter",
  config = function()
    local uuid = require("uuid-nvim")
    uuid.setup({
      case = "lower",
      quotes = "none",
      insert = "before",
    })
    vim.keymap.set("i", "<C-d>", uuid.insert_v4, { desc = "Insert UUID" })
  end,
}
