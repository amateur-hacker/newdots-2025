return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      vim.api.nvim_set_hl(0, "UfoFoldedEllipsis", { bg = "none", fg = "#cdd6f4" })

      local ftMap = {
        vim = "indent",
        python = { "treesitter", "indent" },
        lua = { "treesitter", "indent" },
        javascript = { "treesitter", "indent" },
        typescript = { "treesitter", "indent" },
        javascriptreact = { "treesitter", "indent" },
        typescriptreact = { "treesitter", "indent" },
        vue = { "lsp", "indent" },
        json = { "treesitter", "indent" },
        jsonc = { "treesitter", "indent" },
        yaml = { "treesitter", "indent" },
        toml = { "treesitter", "indent" },
        rust = { "lsp", "treesitter" },
        go = { "lsp", "treesitter" },
        php = { "lsp", "treesitter" },
        ruby = { "treesitter", "indent" },
        c = { "lsp", "treesitter" },
        cpp = { "lsp", "treesitter" },
        java = { "lsp", "treesitter" },
        css = { "treesitter", "indent" },
        scss = { "treesitter", "indent" },
        html = { "treesitter", "indent" },
        xml = { "treesitter", "indent" },
        markdown = { "treesitter", "indent" },
        sh = { "treesitter", "indent" },
        zsh = { "treesitter", "indent" },
        fish = { "treesitter", "indent" },
        git = "",
        gitcommit = "",
        help = "indent",
        text = "indent",
    }

      return {
        open_fold_hl_timeout = 150,
        enable_get_fold_virt_text = true,
        fold_virt_text_handler = Utils.fold.ufo_virt_text_handler_enhanced,
        close_fold_kinds_for_ft = {
            default = { "imports", "comment" },
            json = { "array" },
            jsonc = { "array" },
            c = { "comment", "region" },
            cpp = { "comment", "region" },
            java = { "comment", "imports" },
            javascript = { "comment", "imports" },
            typescript = { "comment", "imports" },
            vue = { "comment", "imports" },
            python = { "comment", "imports" },
            go = { "comment", "imports" },
            rust = { "comment", "imports" },
            php = { "comment", "imports" },
        },
        provider_selector = function(bufnr, filetype, buftype)
            return ftMap[filetype] or Utils.fold.ufo_provider_selector
        end,
      }
    end,
    -- stylua: ignore
    keys = {
      {"zR", function() require("ufo").openAllFolds() end, desc = "Open all folds"},
      {"zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },
      {"zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds"},
      {"zK", function()
        local windid = require("ufo").peekFoldedLinesUnderCursor()
        if not windid then
          vim.lsp.buf.hover()
        end
      end, desc = "Peek Fold or hover"},
    },
  },

  {
    "razak17/tailwind-fold.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "html", "astro", "typescriptreact", "javascriptreact" },
  },

  {
    "luukvbaal/statuscol.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        setopt = true,
        -- override the default list of segments with:
        -- number-less fold indicator, then signs, then line number & separator
        segments = {
          { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
          { text = { "%s" }, click = "v:lua.ScSa" },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
        },
      }
    end,
  },
}
