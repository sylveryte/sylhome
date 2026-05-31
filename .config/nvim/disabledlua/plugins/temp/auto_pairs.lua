return {
  'windwp/nvim-autopairs',
  enabled = true,
  event = "InsertEnter",
  config = function()
    require('nvim-autopairs').setup({
      disable_filetype = { "TelescopePrompt", "vim" },
      map_cr = true
    })
  end
}
