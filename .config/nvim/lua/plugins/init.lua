return {
  {
    "akinsho/bufferline.nvim",
    opts = function(_, opts)
      table.insert(opts.options.offsets, {
        filetype = "snacks_layout_box",
        separator = true,
      })
      table.insert(opts.options.offsets, {
        filetype = "NvimTree",
        separator = true,
      })
    end,
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>fe", false },
      { "<leader>fE", false },
      { "<leader>e", false },
      { "<leader>E", false },
    },
    opts = {
      explorer = { enabled = false },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
      },
      extensions = { "trouble", "lazy", "nvim-tree", "man", "mason", "fzf" },
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<c-j>"] = { "select_next" },
        ["<c-k>"] = { "select_prev" },
      },
    },
  },
  {
    "echasnovski/mini.icons",
    opts = {
      default = {
        file = { glyph = "" },
      },
    },
  },
  -- {
  --   "echasnovski/mini.files",
  --   keys = {
  --     { "<leader>e", "<leader>fm", desc = "Open min.files (Directory of Current File)", remap = true },
  --     { "<leader>E", "<leader>fM", desc = "Open mini.files (cwd)", remap = true },
  --   },
  --   opts = {
  --     options = {
  --       use_as_default_explorer = true,
  --     },
  --   },
  -- },
}
