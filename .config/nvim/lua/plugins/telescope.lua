return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-frecency.nvim",
    "jvgrootveld/telescope-zoxide",
    'ghassan0/telescope-glyph.nvim',
    "AckslD/nvim-neoclip.lua",
    "princejoogie/dir-telescope.nvim",
    'nvim-telescope/telescope-ui-select.nvim',
    "debugloop/telescope-undo.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
  config = function()
    require('telescope').load_extension('zoxide')
    require('telescope').load_extension('frecency')
    require('telescope').load_extension('glyph')
    require('neoclip').setup()
    require('telescope').load_extension('neoclip')
    require("dir-telescope").setup()
    require("telescope").load_extension("dir")
    require("telescope").load_extension("undo")
    local spath = require('utils.sylpath')
    local ut = require('utils/telescope')
    local themes = require('telescope.themes')
    require("frecency.config").setup {
      auto_validate = true,
      db_validate_threshold = 100
    }
    require('telescope').setup(
      {
        matchup = {
          enable = true, -- mandatory, false will disable the whole extension
          disable = {},  -- optional, list of language that will be disabled
          -- [options]
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
          },
          -- ["ui-select"] = {
          --   themes.get_cursor({
          --     previewer = false,
          --     initial_mode = "normal",
          --   }),
          -- },
          ["ui-select"] =
              themes.get_dropdown({
                previewer = false,
                layout_strategy = "center",

                layout_config = {
                  width = 50,
                  height = 10,
                },

              }),
          -- ["ui-select"] = {
          --   require("telescope.themes").get_dropdown({
          --     previewer = false,
          --     width = 40,
          --     height = 8,
          --   }),
          -- },
        },
        defaults = {
          layout_strategy = 'vertical',
          wrap_results = true,
          layout_config = {
            height = 0.98,
            width = 0.98,
            horizontal = {
              preview_cutoff = 50,
              prompt_position = "bottom",
            },
            vertical = {
              preview_cutoff = 30,
              prompt_position = "bottom",
            }
          },
          -- mappings = {
          --   i = { ["<c-t>"] = require('trouble').open_with_trouble },
          --   n = { ["<c-t>"] = require('trouble').open_with_trouble },
          -- },
        },
      },
      -- load after config setup so it picks up
      require("telescope").load_extension("ui-select")
    )
    local map = vim.keymap.set
    local builtin = require('telescope.builtin')
    map("n", "<leader>gs", "<cmd>Telescope dir live_grep<CR>", { noremap = true, silent = true })
    map("n", "<leader>gg", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
    map("n", "<leader>gf", "<cmd>Telescope dir find_files<CR>", { noremap = true, silent = true })
    map("n", "<leader>a", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", { noremap = true, silent = true })
    map("n", "<leader>m", ":Telescope frecency<CR>", { desc = "Telescope frecency" })
    map('n', '<leader>f', builtin.find_files, { desc = "telescope find files og" })
    map('n', '<leader>vg', function()
      builtin.git_files({ cwd = vim.fn.expand('%:p:h') })
    end, { desc = "telescope find files with cur dir context" })
    map('n', '<leader>vv', function()
      builtin.find_files({ cwd = spath.find_syl_root_dir() })
    end, { desc = "telescope find files from current file's sylroot" })
    map('n', '<leader>vf', function()
      builtin.find_files({ cwd = spath.find_syl_root_dir() })
    end, { desc = "telescope find files from current file's sylroot" })
    map('n', '<leader>vs', function()
      builtin.live_grep({ cwd = spath.find_syl_root_dir() })
    end, { desc = "telescope search in files from current file's sylroot" })
    map('n', '<leader>zc', ":Telescope zoxide list<CR>", { desc = "Telescope zoxide" })
    map('n', '<leader>z', function()
      ut.find_dir_with_zoxide(1)
    end, { desc = "telescope zoxide then find files" })
    map('n', '<leader>zz', function()
      ut.find_dir_with_zoxide(1)
    end, { desc = "telescope zoxide then find files" })
    map('n', '<leader>zf', function()
      ut.find_dir_with_zoxide(1)
    end, { desc = "telescope zoxide then find files" })
    map('n', '<leader>zs', function()
      ut.find_dir_with_zoxide(2)
    end, { desc = "telescope zoxide then search in files" })
    map('n', '<leader>s', builtin.live_grep, { desc = "telescope live grep" })
    map('n', '<leader>b', builtin.buffers, { desc = "telescope buffers" })
    map('n', '<leader>j', builtin.grep_string, { desc = "telescope grep string" })
    map('n', '<leader>k', builtin.oldfiles, { desc = "telescope oldfiles" })
    map('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = "telescope current_buffer_fuzzy_find" })
    map('n', 'gd', function()
        -- syllsp.better_link_action(builtin.lsp_definitions)
        builtin.lsp_definitions()
      end,
      { desc = "telescope syl lsp_definitions" })
    map('n', '<leader>gi', builtin.lsp_implementations, { desc = "telescope lsp_implementations" })
    map('n', 'grt', builtin.lsp_references, { desc = "telescope lsp_references" })
    map('n', '<leader>tl', builtin.builtin, { desc = "telescope list builtins" })
    map('n', '<leader>th', builtin.help_tags, { desc = "telescope help tags" })
    map('n', '<leader>tt', builtin.treesitter, { desc = "telescope treesitter" })
    map('n', '<leader>tc', builtin.commands, { desc = "telescope commands" })
    map('n', '<leader>tgb', builtin.git_bcommits, { desc = "telescope buffer commits" })
    map('n', '<leader>tgc', builtin.git_commits, { desc = "telescope commits" })
    map('n', '<leader>tk', builtin.keymaps, { desc = "telescope keymaps" })
    map('n', '<leader>ts', builtin.symbols, { desc = "telescope symbols" })

    require('utils/telescope')
  end
}
