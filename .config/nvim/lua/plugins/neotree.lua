return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>i", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
  config = function()
    require("neo-tree").setup(
      {
        filesystem = {
          hijack_netrw_behavior = "disabled", -- netrw disabled, opening a directory opens neo-tree
          follow_current_file = {
            enabled = true
          },
        },
      }
    )
  end,
}
