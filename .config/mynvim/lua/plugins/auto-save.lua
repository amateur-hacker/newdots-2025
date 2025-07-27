-----------------------------------------------------------
-- Autosave (Save Automatically)
-----------------------------------------------------------

return {
  "Pocco81/auto-save.nvim",
  enabled = false,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    execution_message = {
      message = "",
    },
  },
}
