return {
  "mason-org/mason.nvim",
  dependencies = { 'neovim/nvim-lspconfig',
    "mason-org/mason-lspconfig.nvim",
    {
      'creativenull/efmls-configs-nvim',
      version = 'v1.x.x', -- version is optional, but recommended
    }
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = {
        -- general
        "efm",
        -- web
        -- "svelte",
        "ts_ls", "cssls", "astro",
        "tailwindcss", "html",
        -- specific langs
        "lua_ls",
        "pylsp",
        -- "gopls",
        "rust_analyzer",
        "sqls",
        "clangd",
      },
    }

    vim.lsp.config.sylmark = {
      -- cmd = { "/home/sylveryte/trisha/sylmark-linux-amd64" },
      cmd = { "sylmark" },
      -- cmd = { "/home/sylveryte/projects/sylmark-out/sylmark-0.7.2-linux-amd64" },
      -- cmd = { "/home/sylveryte/projects/sylmark_play/tmp/main" },
      root_markers = { '.sylroot.toml' },
      filetypes = { 'markdown' },
      on_attach = function(client, bufnr)
        vim.api.nvim_create_user_command(
          "Daily",
          function(args)
            local input = args.args

            client:exec_cmd({
              title = "Show",
              command = "show",
              arguments = { input }, -- Also works with `vim.NIL`
            }, { bufnr = bufnr })
          end,
          { desc = 'Open daily note', nargs = "*" }
        )
        vim.api.nvim_create_user_command(
          "Graph",
          function(args)
            local input = args.args

            client:exec_cmd({
              title = "Open Graph",
              command = "graph",
              arguments = { input }, -- Also works with `vim.NIL`
            }, { bufnr = bufnr })
          end,
          { desc = 'Start graph server and open', nargs = "*" }
        )
      end
    }


    vim.lsp.config.ledger_lsp = {
      cmd = { "/home/sylveryte/projects/ledger-lsp/ledger-lsp" },
      root_markers = { '.git' },
      filetypes = { 'ledger' },
    }


    vim.lsp.config.lua_ls = {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {
              'vim',
              'require'
            },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        }
      }
    }


    ----------------------- efm start
    local eslint = require('efmls-configs.linters.eslint')
    local prettier = require('efmls-configs.formatters.prettier')
    local prettierd = require('efmls-configs.formatters.prettier_d')
    local sql_formatter = require('efmls-configs.formatters.sql-formatter')
    -- local goci = require('efmls-configs.linters.golangci_lint')
    -- local golangcilint = {
    --   lintCommand = "golangci-lint run",
    --   lintSource = "golanci-lint",
    -- }
    -- local golangci_lint = require('efmls-configs.formatters.golangci_lint')
    local languages = {
      typescript = { eslint, prettier },
      javascript = { eslint, prettier },
      typescriptreact = { eslint, prettier },
      javascriptreact = { eslint, prettier },
      markdown = { prettierd },
      html = { prettier },
      yaml = { prettier },
      css = { prettier },
      scss = { prettier },
      json = { prettier },
      -- go = { goci },
      sql = { sql_formatter }
    }
    local langKeys = {}
    for key, _ in pairs(languages) do
      table.insert(langKeys, key)
    end
    vim.lsp.config.efm = {
      init_options = { documentFormatting = true },
      filetypes = langKeys,
      settings = {
        rootMarkers = { ".git/", ".sylroot" },
        languages = languages
      }
    }
    ----------------------- efm end

    -- -- format on save
    -- local lsp_fmt_group = vim.api.nvim_create_augroup('LspFormattingGroup', {})
    -- vim.api.nvim_create_autocmd('BufWritePost', {
    --   group = lsp_fmt_group,
    --   callback = function(args)
    --     local bufn = args.buf
    --     local clients = vim.lsp.get_clients({ bufnr = bufn })
    --     if next(clients) ~= nil then
    --       vim.cmd("SylFormatSync")
    --     end
    --   end,
    -- })

    vim.lsp.enable({
      -- custom
      "sylmark",
      "ledger_lsp",
      -- general
      "efm",
      -- web
      "ts_ls", "cssls", "astro",
      -- "svelte",
      "tailwindcss", "html",
      -- specific langs
      "lua_ls",
      "pylsp",
      "gopls",
      "rust_analyzer",
      "sqls",
      "clangd",
    })
  end
}
