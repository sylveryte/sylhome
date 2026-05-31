return {
  "mhartington/formatter.nvim",
  enabled = true,
  config = function()
    local map = vim.keymap.set
    -- Utilities for creating configurations
    -- local util = require "formatter.util"

    -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
    require("formatter").setup {
      -- Enable or disable logging
      logging = true,
      -- Set the log level
      log_level = vim.log.levels.WARN,
      -- All formatter configurations are opt-in
      filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        typescriptreact = require("formatter.defaults.prettier"),
        markdown = require("formatter.defaults.prettierd"),
        typescript = require("formatter.defaults.prettier"),
        javascript = require("formatter.defaults.prettier"),
        javascriptreact = require("formatter.defaults.prettier"),
        html = require("formatter.defaults.prettier"),
        css = require("formatter.defaults.prettier"),
        scss = require("formatter.defaults.prettier"),
        astro = require("formatter.defaults.prettier"),
        json = require("formatter.defaults.prettier"),
        sql = require("formatter.filetypes.sql").pgformat,

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ["*"] = {
          -- "formatter.filetypes.any" defines default configurations for any
          -- filetype
          require("formatter.filetypes.any").remove_trailing_whitespace
        }
      }
    }

    local augroup = vim.api.nvim_create_augroup
    local autocmd = vim.api.nvim_create_autocmd
    augroup("__formatter__", { clear = true })
    autocmd("BufWritePost", {
      group = "__formatter__",
      command = ":FormatWrite",
    })

    map("n", "<leader>p", "<cmd>:Format<cr>")
  end

}
