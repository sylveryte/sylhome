return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    vim.opt.termguicolors = true
    require("nvim-highlight-colors").setup {
      render = 'background', -- or 'foreground' or 'first_column'
      enable_named_colors = true,
      enable_tailwind = true,
    }
  end
}
