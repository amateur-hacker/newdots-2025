return {
  "m4xshen/smartcolumn.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    disabled_filetypes = {
      "help",
      "text",
      "markdown",
      "lazy",
      "mason",
      "checkhealth",
      "lspinfo",
      "noice",
      "alpha",
      "trouble",
      "toggleterm",
      "javascriptreact",
      "typescriptreact",
    },
  },
}
