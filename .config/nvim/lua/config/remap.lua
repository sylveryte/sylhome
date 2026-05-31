local spath = require "utils.sylpath"
local function open_in(prog, dir)
  if vim.bo.filetype == 'markdown' then
    local line = vim.fn.getline('.')
    local pattern = '!%[%](%b())'
    local path = line:match(pattern)

    if path then
      path = path:sub(2, -2)
      local current_file_dir_path = vim.fn.expand('%:p:h')
      if dir == true then
        vim.fn.system(prog .. ' ' .. current_file_dir_path .. ' &')
      else
        local full_path = current_file_dir_path .. '/' .. path
        vim.fn.system(prog .. ' ' .. full_path .. ' &')
      end
    else
      print("No image path found in the current line")
    end
  else
    vim.fn.system(prog .. ' ' .. spath.current_file_path() .. ' &')
  end
end

local map = vim.keymap.set
-- map("n","-",vim.cmd.Ex)

-- indent
-- map("n", "<leader>oi", "gg=G<C-o>zR", { desc = "Indent using =" })
-- map("n", "<leader>nlr", ":%s/ SYLNEWLINE/\\r/g<CR>")

-- folds
map("n", "<space>", "za", { desc = "Fold" })

--Remap '\\' as leader key
-- keymap('', '\\', '<Nop>', opts)
-- vim.g.mapleader = '\\'

-- better up/down
-- map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize window using <alt> arrow keys
map("n", "<cs-k>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<cs-l>", "<cmd>vertical resize -2<cr>", { desc = "Increase window width" })
map("n", "<cs-j>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<cs-h>", "<cmd>vertical resize +2<cr>", { desc = "Decrease window width" })

-- Move Lines
map("n", "]j", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "]k", "<cmd>m .-2<cr>==", { desc = "Move up" })
-- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })


-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", ",x", "<C-W>s", { desc = "Split window below" })
map("n", ",v", "<C-W>v", { desc = "Split window right" })

-- tabs
map("n", "<leader><tab>]", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>[", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>l", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>h", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- buffers
map("n", "<C-,>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<C-.>", "<cmd>bnext<cr>", { desc = "Next buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- -- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- -- better indenting
-- map("v", "<", "<gv")
-- map("v", ">", ">gv")

-- quit
map("n", "<C-q>", "<cmd>q<cr>", { desc = "Quit" })
-- map("n", "<C-a>", "<cmd>bn|bd #<cr>", { desc = "Quit" })

-- background set
-- map("n", "<leader>d", "<cmd>set bg=dark<cr>", { desc = "Set background=dark" })
map("n", "<leader>d", ':exec &bg=="light"? "set bg=dark" : "set bg=light"<CR>',
  { noremap = true, silent = true, desc = "Toggle dark light bg" })

-- format range
function RangeFormatFunction()
  vim.lsp.buf.format({
    async = true,
    -- name = 'efm', -- to format using efm only
    range = {
      ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
      ["end"] = vim.api.nvim_buf_get_mark(0, ">"),
    }
  })
end

vim.api.nvim_create_user_command("SylFormatRange", function()
  RangeFormatFunction()
end, {})
vim.api.nvim_create_user_command("SylFormat", function()
  vim.lsp.buf.format()
end, {})
vim.api.nvim_create_user_command("SylFormatSync", function()
  vim.lsp.buf.format({
    async = false
  })
end, {})
vim.api.nvim_create_user_command("SylFormatEfm", function()
  vim.lsp.buf.format({ name = "efm" })
end, {})


map({ "n" }, "<localleader>ll", "<cmd>:LspRestart<CR>", { desc = "LSP restart" })
map("v", "<leader>o", "<Esc><cmd>:SylFormatRange<CR>", { desc = "LSP Range format" })
map({ "n" }, "<leader>o", "<cmd>:SylFormat<CR>", { desc = "LSP Format file" })
-- map({ "n" }, "<leader>p", "<cmd>:SylFormatEfm<CR>", { desc = "LSP Format file with efm only" })

map("n", "<localleader>oo", function() open_in('nsxiv') end, { desc = "Open in nsxiv" })
map("n", "<localleader>of", function() open_in('nautilus', true) end, { desc = "Open in dolphin" })
map("n", "<localleader>og", function() open_in('org.kde.gwenview') end, { desc = "Open in org.kde.gwenview" })
map("n", "<localleader>oy", function() open_in('ghostty -e yazi', true) end, { desc = "Open in yazi" })
map("n", "<localleader>ox", function() open_in('xdg-open', true) end, { desc = "Open in GUI" })
map("n", "<localleader>od", function() vim.cmd([[!xdg-open ~/.cache/nvim/diagram-cache/d2/$(ls ~/.cache/nvim/diagram-cache/d2/ -1t |head -1)]])  end, { desc = "Open last rendered d2 diagram" })
