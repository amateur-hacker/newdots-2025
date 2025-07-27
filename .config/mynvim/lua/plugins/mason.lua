return {
  -- cmdline tools and lsp servers
  {

    "mason-org/mason.nvim",
    -- cmd = "Mason",
    cmd = { "Mason", "MasonInstall", "MasonLog", "MasonUninstall", "MasonUninstallAll", "MasonUpdate" },
    keys = { { "<leader>m", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = {
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "vtsls",
        "lua-language-server",
        "emmet-ls",
        "pyright",
        "bash-language-server",
        "prettierd",
        "eslint_d",
        "biome",
        "isort",
        "black",
        "pylint",
        "stylua",
        "shfmt",
        "shellcheck",
        "markdown-toc",
        "markdownlint-cli2",
        "taplo",
      },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(), })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
    end,
  },

  -- pin to v1 for now
  { "mason-org/mason.nvim", version = "^1.0.0" },
  { "mason-org/mason-lspconfig.nvim", version = "^1.0.0" },
}
