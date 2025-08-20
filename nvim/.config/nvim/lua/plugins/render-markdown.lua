-- Extend which-key with custom groups
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        border = "none",
        conceal_delimiters = false,
        inline_left = "`",
        inline_right = "`",
        language_icon = true,
        language_name = true,
      },
      link = {
        enabled = false,
      },
    },
  },
}
