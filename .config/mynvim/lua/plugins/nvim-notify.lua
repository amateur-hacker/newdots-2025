-----------------------------------------------------------
-- Nvim Notify (Better Notification)
-----------------------------------------------------------

return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  init = function()
    vim.notify = require("notify")
  end,
  opts = {
    -- stages = "static",
    timeout = 3000,
    max_height = function()
      return math.floor(vim.o.lines * 0.75)
    end,
    max_width = function()
      return math.floor(vim.o.columns * 0.75)
    end,
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { zindex = 100 })
    end,
  },
  key = {
    {
      "<leader>nd",
      function()
        require("notify").dismiss({ silent = true, pending = true })
      end,
      desc = "Dismiss All Notifications",
    },
  },
}
