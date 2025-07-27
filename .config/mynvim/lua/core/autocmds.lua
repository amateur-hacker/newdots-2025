-----------------------------------------------------------
-- Autocommand functions
-----------------------------------------------------------

-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup

local function augroup(name)
  return vim.api.nvim_create_augroup(name, { clear = true })
end -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank()
  end,
})

-- resize splits if window got resized
autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
  group = augroup("json_conceal_off"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- wrap and check for spell in text filetypes
autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Go to last loc when opening a buffer
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close some filetypes with <q>
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd("close")
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Make it easier to close man-files when opened inline
autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- Trim trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("trim_whitespace"),
  callback = function()
    vim.cmd([[silent! %s/\s\+$//e]])
  end,
})

-- Disable auto-commenting on new lines
autocmd("BufEnter", {
  group = augroup("auto_commenting_off"),
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Delete empty and unnamed buffers
autocmd("BufReadPost", {
  group = augroup("cleanup_empty_bufs"),
  callback = function()
    local buffers = vim.api.nvim_list_bufs()

    for _, bufnr in ipairs(buffers) do
      if
        vim.api.nvim_buf_is_loaded(bufnr)
        and vim.api.nvim_buf_get_name(bufnr) == ""
        and vim.api.nvim_buf_get_option(bufnr, "buftype") == ""
      then
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local total_characters = 0
        for _, line in ipairs(lines) do
          total_characters = total_characters + #line
        end
        if total_characters == 0 then
          vim.api.nvim_buf_delete(bufnr, { force = true })
        end
      end
    end
  end,
})

-- Enter insert mode when switching to terminal
autocmd("TermOpen", {
  group = augroup("terminal_behavior"),
  pattern = "term://*",
  callback = function()
    vim.opt_local.listchars = ""
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.cursorline = false
    vim.opt_local.filetype = "terminal"
    vim.cmd.startinsert()
  end,
})

-- Automatically close terminal on exit
autocmd("TermClose", {
  group = augroup("terminal_behavior"),
  pattern = "term://*",
  callback = function()
    vim.api.nvim_input("<cr>")
  end,
})

-- Auto open nvim-tree when opening a directory
autocmd("VimEnter", {
  group = augroup("auto_open_nvim_tree"),
  callback = function()
    local args = vim.fn.argv()
    local arg = args[1]
    if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      vim.cmd.cd(arg)

      require("lazy").load({ plugins = { "nvim-tree.lua" } })

      vim.cmd("NvimTreeToggle")
    end
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.jsonc",
  callback = function()
    vim.cmd("%!biome format --stdin")
  end,
})
