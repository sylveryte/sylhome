return {
  "tpope/vim-fugitive",
  config = function()
    local map = vim.keymap.set
    map("n", "<leader>g", "<cmd>:Git<cr>")
    map("n", "gb", ":Git blame<CR>")
  end
}
