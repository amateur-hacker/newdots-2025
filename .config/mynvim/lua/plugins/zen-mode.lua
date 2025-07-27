-----------------------------------------------------------
-- Zen Mode (Distraction free coding and writing)
-----------------------------------------------------------

return {
  "folke/zen-mode.nvim",
  dependencies = { "folke/twilight.nvim" },
  cmd = "ZenMode",
  opts = {
    window = {
      width = 1,
    },
    plugins = {
      twilight = { enabled = false },
      todo = { enabled = false},
      kitty = {
        enabled = true,
        font = "+2",
      },
    },
    on_open = function()
      vim.opt.laststatus = 0
      vim.opt.foldenable = false
      vim.opt.foldmethod = "manual"
      vim.opt.signcolumn = "no"
    end,
    on_close = function()
      vim.opt.laststatus = 3
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldenable = true
      vim.opt.signcolumn = "yes"
      vim.cmd("silent! lua require('ufo').enable()")
    end,
  },
  keys = {
    { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle ZenMode" },
  },
}
