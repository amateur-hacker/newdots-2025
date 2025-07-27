return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    signs = false,
  },
  -- stylua: ignore
  -- TODO: Implement the user authentication feature.
  -- FIXME: Fix the bug causing the application to crash on startup.
  -- FIX: Update the regular expression to match email addresses correctly.
  -- HACK: Temporary workaround for the issue with the third-party API.
  -- WARNING: This code is sensitive and may cause security issues if not handled properly.
  -- NOTE: This function will be removed in the next major release.
  -- PERF: Optimize this query to reduce database load during peak hours.
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME,HACK,WARNING,NOTE,PERF}}<cr>", desc = "TODO,FIX,FIXME,HACK,WARNING,NOTE,PERF (Trouble)" },
    { "<leader>tt", "<cmd>TodoTelescope<cr>", desc = "Todo" },
    { "<leader>tT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
}
