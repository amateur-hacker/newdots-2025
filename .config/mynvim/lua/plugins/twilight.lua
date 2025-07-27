-----------------------------------------------------------
-- Twilight (Dim inactive portions of code)
-----------------------------------------------------------

return {
  "folke/twilight.nvim",
  cmd = "Twilight",
  opts = {
    dimming = { alpha = 0.45, color = { "Normal", "#ffffff" }, inactive = false },
    context = 9,
    treesitter = true,
    expand = { "function", "method", "table", "if_statement", "element" },
    exclude = {},
  },
  keys = {
    { "<leader>T", "<cmd>Twilight<cr>", desc = "Toggle Twilight" },
  },
}
