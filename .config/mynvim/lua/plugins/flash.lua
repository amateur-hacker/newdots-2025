-----------------------------------------------------------
-- Flash (Motion plugin)
-----------------------------------------------------------

return {
  "folke/flash.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = function()
    -- local colors = require("catppuccin.palettes.mocha")
    -- vim.api.nvim_set_hl(0, "FlashLabel", { bg = colors.blue, fg = colors.mantle })
    -- vim.api.nvim_set_hl(0, "FlashLabel", { bg = "#ed0477", fg = "#ffffff" })
    return {
      label = { rainbow = { enabled = false } },
      modes = {
        char = {
          enabled = false,
          jump_labels = false,
        },
        search = {
          enabled = false,
        },
      },
    }
  end,
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
