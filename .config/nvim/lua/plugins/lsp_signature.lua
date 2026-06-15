return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  enabled = true,
  opts = {},
  config = function(_, opts)
    require 'lsp_signature'.setup(opts)
    require "lsp_signature".on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "single"
      }
    })
  end
}
