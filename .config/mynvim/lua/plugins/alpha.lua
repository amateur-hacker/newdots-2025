-----------------------------------------------------------
-- Alpha (Dashboard)
-----------------------------------------------------------

return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")

    --    local logo = [[
    --                                              
    --       ████ ██████           █████      ██
    --      ███████████             █████ 
    --      █████████ ███████████████████ ███   ███████████
    --     █████████  ███    █████████████ █████ ██████████████
    --    █████████ ██████████ █████████ █████ █████ ████ █████
    --  ███████████ ███    ███ █████████ █████ █████ ████ █████
    -- ██████  █████████████████████ ████ █████ █████ ████ ██████
    --      ]]
    --
        local logo = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]]

    -- local logo = {
    --   [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣬⣶⣿⣄⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    --   [[ ⠀⠀⠀⠀⠀⠀⠀⠸⠾⠋⠍⡙⠻⣿⣿⣷⣗⡀⠀⠀⠀⠀⠀⠀⠀ ]],
    --   [[ ⠀⠀⠀⠀⠀⠀⡓⠄⠀⢠⣭⣭⣏⢙⣽⣿⣿⣟⡭⠄⠀⠀⠀⠀⠀ ]],
    --   [[ ⠀⠀⠀⠂⢤⣤⠀⠀⠀⠀⠀⠁⠈⢉⣁⠨⠿⣦⣍⡀⠀⠀⠀⠀⠀ ]],
    --   [[ ⠀⠀⠀⠀⠨⣸⡌⠀⠀⠀⢐⢕⣢⡌⣠⠇⣰⡧⠅⠀⠀⣀⠀⡀⠀ ]],
    --   [[ ⠀⠀⠀⠀⠀⠐⠀⣀⠐⡄⣠⣿⣿⣿⣿⣸⠙⢀⣀⣀⠎⡐⢻⢧⠀ ]],
    --   [[ ⠀⠀⠀⠀⠀⠀⠈⠈⠋⠊⠻⢿⠿⣿⡿⠛⠂⠿⠆⠉⠀⠀⠀⠀⠱ ]],
    --   [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠒⢷⢖⠄⠀⠀⠀⠀⠀ ]],
    --   [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠖⠄⠀⠀⠀⠀⠊⠉⠀⠀⠀⠀⡼⣠ ]],
    --   [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⣰⠋⠐⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠇ ]],
    --   [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠨⠀⠘⠂⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    --   [[ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
    --   [[ ⠀⠀⠀     Amateur Hacker⠀⠀  ]],
    -- }

    dashboard.section.header.val = vim.split(logo, "\n")
    -- dashboard.section.header.val = logo

    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file", "<cmd>Telescope find_files<cr>"),
      dashboard.button("n", " " .. " New file", "<cmd>ene <BAR> startinsert<cr>"),
      dashboard.button("r", " " .. " Recent files", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button("g", " " .. " Find text", "<cmd>Telescope live_grep<cr>"),
      dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load()<CR>]]),
      dashboard.button("l", "󰒲 " .. " Lazy", "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit", "<cmd> qa <cr>"),
    }

    local colors = require("catppuccin.palettes.mocha")
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = colors.blue })
    vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = colors.peach })
    vim.api.nvim_set_hl(0, "AlphaButtons", { fg = colors.sky })
    vim.api.nvim_set_hl(0, "AlphaFooter", { fg = colors.sapphire })

    for _, button in ipairs(dashboard.section.buttons.val) do
      button.opts.hl = "AlphaButtons"
      button.opts.hl_shortcut = "AlphaShortcut"
    end
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.footer.opts.hl = "AlphaFooter"
    dashboard.opts.layout[1].val = 4
    return dashboard
  end,
  config = function(_, dashboard)
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "AlphaReady",
        callback = function()
          require("lazy").show()
        end,
      })
    end

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      once = true,
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
        dashboard.section.footer.val = "⚡ Neovim loaded "
          .. stats.loaded
          .. "/"
          .. stats.count
          .. " plugins in "
          .. ms
          .. "ms"
        pcall(vim.cmd.AlphaRedraw)
      end,
    })

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
