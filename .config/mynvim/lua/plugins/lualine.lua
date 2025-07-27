-----------------------------------------------------------
-- Lualine (Statusline)
-----------------------------------------------------------

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  init = function()
    vim.g.lualine_laststatus = vim.o.laststatus
    if vim.fn.argc(-1) > 0 then
      -- set an empty statusline till lualine loads
      vim.o.statusline = " "
    else
      -- hide the statusline on the starter page
      vim.o.laststatus = 0
    end
  end,
  opts = function()
    vim.o.laststatus = vim.g.lualine_laststatus
    local mode = {
      "mode",
      fmt = function(str)
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
        return " " .. str
      end,
    }

    local filename = {
      "filename",
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 100
    end

    local macros = function()
      local recording_register = vim.fn.reg_recording()
      if recording_register == "" then
        return ""
      else
        return "recording @" .. recording_register
      end
    end

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      colored = true,
      update_in_insert = false,
      always_visible = false,
      cond = hide_in_width,
    }

    local diff = {
      "diff",
      colored = true,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
    }

    return {
      options = {
        icons_enabled = true,
        theme = "auto",
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --        
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        -- component_separators = { left = "│", right = "│" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha" },
        always_divide_middle = false,
        globalstatus = vim.o.laststatus == 3,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { "branch" },
        lualine_c = { filename, macros },
        lualine_x = { diagnostics, diff, { "filetype", cond = hide_in_width } },
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {},
        lualine_y = { { "location", padding = 0 } },
        lualine_z = {},
      },
      tabline = {},
      extensions = { "trouble", "lazy", "nvim-tree", "man", "toggleterm", "mason", "fzf" },
    }
  end,
}
