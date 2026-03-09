return {
  "everviolet/nvim",
  name = "evergarden",
  lazy = false,
  priority = 1000, -- Load before other plugins so UI looks right immediately
  opts = {
    theme = {
      variant = "spring", -- 'winter'|'fall'|'spring'|'summer'
      accent = "green",
    },
    editor = {
      transparent_background = false,
      sign = { color = "none" },
      float = {
        color = "mantle",
        solid_border = false,
      },
      completion = {
        color = "surface0",
      },
    },
  },
  config = function(_, opts)
    require("evergarden").setup(opts)
    vim.cmd.colorscheme("evergarden")

    -- Dim inactive windows slightly
    local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
    if normal_bg then
      -- Darken the background slightly for inactive windows
      local r = math.max(0, math.floor(normal_bg / 65536) - 8)
      local g = math.max(0, math.floor(normal_bg / 256) % 256 - 8)
      local b = math.max(0, normal_bg % 256 - 8)
      vim.api.nvim_set_hl(0, "NormalNC", { bg = r * 65536 + g * 256 + b })
    end
  end,
}
