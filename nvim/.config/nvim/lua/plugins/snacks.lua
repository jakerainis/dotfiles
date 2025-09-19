local ignore_list = { "node_modules", ".elixir_ls", "_build", "deps", "tmux/.config/tmux/plugins", ".DS_Store" }

return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
 ██▓    ▓█████▄▄▄█████▓  ██████     ▄████▄   ▒█████  ▓█████▄ ▓█████
▓██▒    ▓█   ▀▓  ██▒ ▓▒▒██    ▒    ▒██▀ ▀█  ▒██▒  ██▒▒██▀ ██▌▓█   ▀
▒██░    ▒███  ▒ ▓██░ ▒░░ ▓██▄      ▒▓█    ▄ ▒██░  ██▒░██   █▌▒███
▒██░    ▒▓█  ▄░ ▓██▓ ░   ▒   ██▒   ▒▓▓▄ ▄██▒▒██   ██░░▓█▄   ▌▒▓█  ▄
░██████▒░▒████▒ ▒██▒ ░ ▒██████▒▒   ▒ ▓███▀ ░░ ████▓▒░░▒████▓ ░▒████▒
░ ▒░▓  ░░░ ▒░ ░ ▒ ░░   ▒ ▒▓▒ ▒ ░   ░ ░▒ ▒  ░░ ▒░▒░▒░  ▒▒▓  ▒ ░░ ▒░ ░
░ ░ ▒  ░ ░ ░  ░   ░    ░ ░▒  ░ ░     ░  ▒     ░ ▒ ▒░  ░ ▒  ▒  ░ ░  ░
  ░ ░      ░    ░      ░  ░  ░     ░        ░ ░ ░ ▒   ░ ░  ░    ░
    ░  ░   ░  ░              ░     ░ ░          ░ ░     ░       ░  ░
                                   ░                  ░
        ]],
      },
    },
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = false,
          git = true,
          exclude = ignore_list,
        },
        grep = {
          hidden = true,
          ignored = false,
          git = true,
          exclude = ignore_list,
        },
      },
    },
    explorer = {
      hidden = true,
    },
  },
}
