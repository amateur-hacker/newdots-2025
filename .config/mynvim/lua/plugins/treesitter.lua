-----------------------------------------------------------
-- Treesitter (Syntax highlighting)
-----------------------------------------------------------

return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = {
        enable = true,
      },
      indent = { enable = true },
      autotag = { enable = true },
      ensure_installed = {
        "bash",
        "cmake",
        "c",
        "c_sharp",
        "css",
        "dockerfile",
        "diff",
        "fish",
        "gitignore",
        "go",
        "graphql",
        "haskell",
        "html",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "norg",
        "python",
        "ruby",
        "rust",
        "sql",
        "svelte",
        "tsx",
        "typescript",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
        "xml",
        "regex",
        "nix",
        "zathurarc",
        "passwd",
      },
      auto_install = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
