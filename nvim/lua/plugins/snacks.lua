local explorer_ignore = {
  ".claude",
  ".devcontainer",
  ".DS_Store",
  ".elixir_ls",
  ".expert",
  ".git",
  "_build",
}

local picker_ignore = {
  ".claude",
  ".DS_Store",
  ".elixir_ls",
  ".expert",
  "_build",
  "deps",
  "node_modules",
  "tmux/.config/tmux/plugins",
}

return {
  "folke/snacks.nvim",
  opts = {
    -- Disable input to avoid conflict with noice cmdline
    input = { enabled = false },
    dashboard = {
      preset = {
        header = [[
                                       u            @88>                      
   u.    u.                     u.    88Nu.   u.    %8P      ..    .     :    
 x@88k u@88c.      .u     ...ue888b  '88888.o888c    .     .888: x888  x888.  
^"8888""8888"   ud8888.   888R Y888r  ^8888  8888  .@88u  ~`8888~'888X`?888f` 
  8888  888R  :888'8888.  888R I888>   8888  8888 ''888E`   X888  888X '888>  
  8888  888R  d888 '88%"  888R I888>   8888  8888   888E    X888  888X '888>  
  8888  888R  8888.+"     888R I888>   8888  8888   888E    X888  888X '888>  
  8888  888R  8888L      u8888cJ888   .8888b.888P   888E    X888  888X '888>  
 "*88*" 8888" '8888c. .+  "*888*P"     ^Y8888*""    888&   "*88%""*88" '888!` 
   ""   'Y"    "88888%      'Y"          `Y"        R888"    `~    "    `"`   
                 "YP'                                ""                       
]],
      },
    },
    picker = {
      sources = {
        files = {
          exclude = picker_ignore,
          git = true,
          hidden = true,
          ignored = false,
        },
        grep = {
          exclude = picker_ignore,
          git = true,
          hidden = true,
          ignored = false,
        },
        explorer = {
          exclude = explorer_ignore,
          git = true,
          hidden = true,
          ignored = true,
        },
      },
    },
  },
}
