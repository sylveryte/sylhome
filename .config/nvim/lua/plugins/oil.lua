return {
  'stevearc/oil.nvim',
  opts = {},
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Oil" },
  },
  -- Optional dependencies
  config = function()
    require("oil").setup(
      {
        keymaps = {
          ["<C-h>"] = false,
          ["<C-l>"] = false,
          ["A-r"] = "actions.refresh"
        }
      }
    )
  end
}
