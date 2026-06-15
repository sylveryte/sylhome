return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'neovim-treesitter/treesitter-parser-registry',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  lazy = false,
  build = ':TSUpdate',
  init = function()
    require('nvim-treesitter').setup {
      -- parsers and queries are installed here (prepended to runtimepath)
      install_dir = vim.fn.stdpath('data') .. '/site',
    }

    local lang = {
      -- backends
      'go', 'rust', 'gomod', 'gosum',
      'sql',
      'proto',
      'dockerfile',
      -- transports / config
      'json', 'csv',
      'yaml', 'toml',
      --docs
      'markdown', 'markdown-inline', 'vimdoc',
      -- web
      'javascript', 'jsdoc', 'typescript', 'tsx', 'html', 'css', 'scss', 'astro',
      'hurl',
      -- tools
      'make', 'diff',
      -- git
      'git_config', 'git_rebase', 'gitattributes', 'gitcommit', 'gitignore',
      -- linux
      'desktop', 'nginx', 'ssh_config', 'bash', 'zsh',
      -- others
      'ledger', 'query',
    }
    require('nvim-treesitter').install(lang)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = lang,
      callback = function()
        vim.treesitter.start()                                            -- highlighting
        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'               -- folds
        vim.wo.foldmethod = 'expr'
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- indentation
      end,
    })
  end
}
