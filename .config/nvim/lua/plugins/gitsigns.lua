return {
  "lewis6991/gitsigns.nvim",
  config = function()
    local map = vim.keymap.set
    require('gitsigns').setup()
    map("n", "<leader>gsd", "<cmd>:Gitsigns toggle_deleted<cr>", { desc = "toggle_deleted" })
    map("n", "<leader>gsn", "<cmd>:Gitsigns toggle_numhl<cr>", { desc = "toggle_numhl" })
    map("n", "<leader>gsl", "<cmd>:Gitsigns toggle_linehl<cr>", { desc = "toggle_linehl" })
    map("n", "<leader>gsw", "<cmd>:Gitsigns toggle_word_diff<cr>", { desc = "toggle_word_diff" })
    map("n", "<leader>gsb", "<cmd>:Gitsigns toggle_current_line_blame<cr>", { desc = "toggle_current_line_blame" })
  end
}
