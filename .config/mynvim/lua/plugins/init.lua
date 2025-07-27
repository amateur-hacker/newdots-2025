return {
  -- icons for most of programming languages
  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    opts = function()
      return {
        override = Utils["dev-icons"],
      }
    end,
  },

  -- yaml schema support
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false, -- last release is way too old
  },

  -- lua functions that many plugins use
  "nvim-lua/plenary.nvim",

  -- tmux & split window navigation
  "christoomey/vim-tmux-navigator",
}

