return {
  "CRAG666/code_runner.nvim",
  enabled=false,
  config = function()
    require('code_runner').setup({
      -- choose default mode (valid term, tab, float, toggle, vimux)
      mode = "term",
      -- add hot reload (Experimental)
      hot_reload = false,
      -- Focus on runner window(only works on term and tab mode)
      focus = false,
      -- startinsert (see ':h inserting-ex')
      startinsert = false,
      insert_prefix = "",
      term = {
        --  Position to open the terminal, this option is ignored if mode ~= term
        position = "vert",
        -- window size, this option is ignored if mode == tab
        size = 50,
      },
      float = {
        close_key = "<q>",
        -- Window border (see ':h nvim_open_win')
        border = "single",

        -- Num from `0 - 1` for measurements
        height = 0.8,
        width = 0.8,
        x = 0.5,
        y = 0.5,

        -- Highlight group for floating window/border (see ':h winhl')
        border_hl = "FloatBorder",
        float_hl = "Normal",

        -- Transparency (see ':h winblend')
        blend = 0,
      },
      filetype = {
        java = {
          "cd $dir &&",
          "javac $fileName &&",
          "java $fileNameWithoutExt"
        },
        lua = "lua",
        python = "python",
        typescript = "deno run",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt"
        },
        c = function(...)
          c_base = {
            "cd $dir &&",
            "gcc $fileName -o",
            "/tmp/$fileNameWithoutExt",
          }
          local c_exec = {
            "&& /tmp/$fileNameWithoutExt &&",
            "rm /tmp/$fileNameWithoutExt",
          }
          vim.ui.input({ prompt = "Add more args:" }, function(input)
            c_base[4] = input
            vim.print(vim.tbl_extend("force", c_base, c_exec))
            require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
          end)
        end,
      },
    })

    vim.keymap.set('n', '<localleader>r', ':RunCode<CR>', { desc="Run code based on file code_runner" ,noremap = true, silent = false })
    -- vim.keymap.set('n', '<localleader>rf', ':RunFile<CR>', { noremap = true, silent = false })
    -- vim.keymap.set('n', '<localleader>rft', ':RunFile tab<CR>', { noremap = true, silent = false })
    -- vim.keymap.set('n', '<localleader>rp', ':RunProject<CR>', { noremap = true, silent = false })
    -- vim.keymap.set('n', '<localleader>rc', ':RunClose<CR>', { noremap = true, silent = false })
    -- vim.keymap.set('n', '<localleader>crf', ':CRFiletype<CR>', { noremap = true, silent = false })
    -- vim.keymap.set('n', '<localleader>crp', ':CRProjects<CR>', { noremap = true, silent = false })
  end
}
