-----------------------------------------------------------
-- Telescope (Fuzzy finder for all things)
-----------------------------------------------------------

return {
  "nvim-telescope/telescope.nvim",
  version = false,
  cmd = { "Telescope" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local themes = require("telescope.themes")

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    return {
      defaults = {
        path_display = { "smart" },
        file_ignore_patterns = {
          "node_modules",
          "package-lock.json",
          ".git",
          ".png",
          ".jpg",
          ".jpeg",
          ".face",
          ".mp4",
          ".mp3",
          ".webm",
          ".webp",
        },
        previewer = false,
        layout_config = {
          prompt_position = "top",
          preview_cutoff = 120,
        },
        initial_mode = "insert",
        select_strategy = "reset",
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        sorting_strategy = "ascending",
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        oldfiles = {
          previewer = false,
          path_display = { "truncate" },
          layout_config = {
            height = 0.4,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        find_files = {
          previewer = false,
          path_display = { "truncate" },
          layout_config = {
            height = 0.4,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        git_files = {
          previewer = false,
          path_display = { "truncate" },
          layout_config = {
            height = 0.4,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        buffers = {
          path_display = { "truncate" },
          previewer = false,
          initial_mode = "insert",
          sort_mru = true,
          ignore_current_buffer = true,
          layout_config = {
            height = 0.4,
            width = 0.6,
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        current_buffer_fuzzy_find = {
          previewer = true,
          layout_config = {
            prompt_position = "top",
            preview_cutoff = 120,
          },
        },
        live_grep = {
          only_sort_text = true,
          previewer = true,
        },
        grep_string = {
          only_sort_text = true,
          previewer = true,
        },
        lsp_references = {
          show_line = false,
          previewer = true,
        },
        treesitter = {
          show_line = false,
          previewer = true,
        },
        colorscheme = {
          enable_preview = true,
        },
      },
      extensions = {
        ["ui-select"] = {
          themes.get_dropdown({
            require("telescope.themes").get_dropdown({
              previewer = false,
              initial_mode = "normal",
              sorting_strategy = "ascending",
              layout_strategy = "horizontal",
              layout_config = {
                horizontal = {
                  width = 0.5,
                  height = 0.4,
                  preview_width = 0.6,
                },
              },
            }),
          }),
        },
      },
    }
  end,
  keys = {
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Find recent files" },
    { "<leader>ff", "<cmd>Telescope find_files<Cr>", desc = "Find files in cwd" },
    { "<leader>fb", "<cmd>Telescope buffers<Cr>", desc = "Find buffers" },
    { "<leader>ft", "<cmd>Telescope colorscheme<Cr>", desc = "Find themes" },
    { "<leader>fg", "<cmd>Telescope grep_string<Cr>", desc = "Find string under cursor in cwd" },
    { "<leader>fs", "<cmd>Telescope live_grep<Cr>", desc = "Find string in cwd" },
  },
}
