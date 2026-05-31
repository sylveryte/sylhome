return {
  "folke/ts-comments.nvim",
  opts = {},
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10.0") == 1,
  config = function()
    require('ts-comments').setup({
      lang={
        ledger ="; %s"
      }
    })
    -- vim.keymap.set({ "n", "v" }, "cm", "gc") -- not working
    vim.cmd([[nmap cm gc]])
    vim.cmd([[vmap cm gc]])
  end
}
