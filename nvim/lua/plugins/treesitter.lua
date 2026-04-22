-- Plugin handles parser installation, Neovim handles highlighting
return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({})

    local wanted = {
      "bash",
      "css",
      "diff",
      "elixir",
      "eex",
      "heex",
      "html",
      "javascript",
      "json",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "query",
      "regex",
      "sql",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    }

    -- Only install parsers that aren't already installed
    local installed = {}
    for _, p in ipairs(require("nvim-treesitter").get_installed()) do
      installed[p] = true
    end

    local missing = {}
    for _, p in ipairs(wanted) do
      if not installed[p] then
        missing[#missing + 1] = p
      end
    end

    if #missing > 0 then
      require("nvim-treesitter").install(missing)
    end

    -- Map filetypes to parser names where they differ
    vim.treesitter.language.register("heex", "eelixir")
    vim.treesitter.language.register("markdown", "livebook")

    -- Enable treesitter highlighting for all filetypes
    vim.api.nvim_create_autocmd("FileType", {
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })
  end,
}
