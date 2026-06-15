return {
  "rachartier/tiny-code-action.nvim",
  opts = {
    -- picker = "telescope"
    picker = "buffer"
  },
  init = function()
    -- sylnote if want, default is good
    -- require("tiny-code-action").setup({
    --   picker = {
    --     "telescope",
    --     opts = require("telescope.themes").get_dropdown({
    --       initial_mode = "normal",
    --       layout_config = {
    --         width = 0.6,
    --       },
    --     }),
    --   },
    -- })

    require("tiny-code-action").setup({
      picker = {
        "buffer",
        opts = {
          hotkeys = true, -- Enable hotkeys for quick selection of actions
          -- hotkeys_mode = "text_diff_based", -- Modes for generating hotkeys
          hotkeys_mode = function(titles, used_hotkeys)
            local t = {}
            for i = 1, #titles do t[i] = tostring(i) end
            return t
          end,
          auto_preview = true,               -- Enable or disable automatic preview
          auto_accept = true,                -- Automatically accept the selected action (with hotkeys)
          position = "cursor",                -- Position of the picker window
          winborder = "rounded",               -- Border style for picker and preview windows
          -- winborder = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
          -- winborder = { "⟪", "─", "⟫", "│", "⟫", "─", "⟪", "│" },
          -- winborder =  { "✧", "✦", "✧", "✦", "✧", "✦", "✧", "✦" },
          keymaps = {
            preview = "K",                    -- Key to show preview
            close = { "q", "<Esc>" },         -- Keys to close the window (can be string or table)
            select = "<CR>",                  -- Keys to select action (can be string or table)
            preview_close = { "q", "<Esc>" }, -- Keys to return from preview to main window (can be string or table)
          },
          custom_keys = {
            { key = 'm', pattern = 'Fill match arms' },
            { key = 'r', pattern = 'Rename.*' }, -- Lua pattern matching
          },
          group_icon = " └",
        },
      },
    })

    vim.keymap.set({ "n", "x" }, "<leader>ca", function()
      require("tiny-code-action").code_action()
    end, { noremap = true, silent = true })
    vim.keymap.set('n', ']K', vim.diagnostic.open_float, { desc = 'Show diagnostic' })
    -- Next error only
    vim.keymap.set("n", "]e", function()
      vim.diagnostic.jump({
        count = 1,
        severity = vim.diagnostic.severity.ERROR,
        on_jump = function()
          -- vim.lsp.buf.code_action()
          require("tiny-code-action").code_action()
        end,
      })
    end, { desc = "Next error" })
    -- Previous error only
    vim.keymap.set("n", "[e", function()
      vim.diagnostic.jump({
        count = -1,
        severity = vim.diagnostic.severity.ERROR,
        on_jump = function()
          -- vim.lsp.buf.code_action()
          require("tiny-code-action").code_action()
        end,
      })
    end, { desc = "Previous error" })
    -- Next warn only
    vim.keymap.set("n", "]w", function()
      vim.diagnostic.jump({
        count = 1,
        severity = vim.diagnostic.severity.WARN,
        on_jump = function()
          -- vim.lsp.buf.code_action()
          require("tiny-code-action").code_action()
        end,
      })
    end, { desc = "Next warn" })
    -- Previous warn only
    vim.keymap.set("n", "[w", function()
      vim.diagnostic.jump({
        count = -1,
        severity = vim.diagnostic.severity.WARN,
        on_jump = function()
          -- vim.lsp.buf.code_action()
          require("tiny-code-action").code_action()
        end,
      })
    end, { desc = "Previous warn" })
  end,
  event = "LspAttach",
}
