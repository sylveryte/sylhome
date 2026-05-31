return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  -- dependencies = { 'rafamadriz/friendly-snippets' },
  dependencies = { 'L3MON4D3/LuaSnip', version = 'v2.*' },

  -- use a release tag to download pre-built binaries
  version = '1.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = { preset = 'luasnip', },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
      ghost_text = { enabled = true, show_with_menu = true },
      list = { selection = { preselect = false } },
      documentation = { auto_show = true },
      accept = { auto_brackets = { enabled = true } },
    },
    cmdline = {
      completion = { menu = { auto_show = true }, list = { selection = { preselect = false } } },
    },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lsp = { fallbacks = {} },
        -- cmdline = {
        --   min_keyword_length = function(ctx)
        --     -- when typing a command, only show when the keyword is 3 characters or longer
        --     if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then return 3 end
        --     return 0
        --   end
        -- }
      },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" },
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    keymap = { preset = 'enter' },
  },
  opts_extend = { "sources.default" },
  config = function(_, opts)
    local ls = require('luasnip')
    ls.setup({
      enable_autosnippets = true,
    })
    vim.keymap.set({ "i" }, "<C-L>", function() ls.expand() end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<C-H>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true })

    require("luasnip.loaders.from_lua").lazy_load()
    require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. '/lua/luasnippets' } })
    require('blink.cmp').setup(opts)
  end,
}
