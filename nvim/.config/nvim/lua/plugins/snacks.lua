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
          exclude = ignore_list,
          git = true,
          hidden = true,
          ignored = false,
        },
        grep = {
          exclude = ignore_list,
          git = true,
          hidden = true,
          ignored = false,
        },
        explorer = {
          follow_cwd = false,
          git = true,
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
