-----------------------------------------------------------
-- Git Integration
-----------------------------------------------------------

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = {
      add = { text = " ▎" },
      change = { text = " ▎" },
      delete = { text = " " },
      topdelete = { text = " " },
      changedelete = { text = " ▎" },
      untracked = { text = " ▎" },
    },
    signs_staged = {
      add = { text = " ▎" },
      change = { text = " ▎" },
      delete = { text = " " },
      topdelete = { text = " " },
      changedelete = { text = " ▎" },
    },
  },
  keys = {
    { "]h", "<cmd>Gitsigns next_hunk<CR>", desc = "Next Hunk" },
    { "[h", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev Hunk" },
    { "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview Hunk" },
    { "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle current blame line" },
    -- NOTE: Need to add more bindings here.
  },
}
