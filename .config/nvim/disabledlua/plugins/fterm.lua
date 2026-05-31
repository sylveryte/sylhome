local sylpath = require "utils.sylpath"
return {
  "numToStr/FTerm.nvim",
  config = function()
    local map = vim.keymap.set
    -- neo float term
    local fterm = require('FTerm')
    fterm.setup({
      border     = 'solid',
      dimensions = {
        height = 0.85,
        width = 0.85,
      },
    })
    -- runners
    local runners = { lua = 'lua', javascript = 'node', go = "go run", rust = "cargo run", python='python' }
    map('n', '<localleader>r', function()
      local buf = vim.api.nvim_buf_get_name(0)
      local ftype = vim.filetype.match({ filename = buf })
      local exec = runners[ftype]
      if exec == 'rust' then
        fterm.run('rustc '..buf..' -o /tmp/rust_bin && /tmp/rust_bin')
      elseif exec ~= nil then
        fterm.run(' ' .. exec .. ' ' .. buf)
      end
    end, { desc = 'Run the program' })
    map({ 't', 'n' }, '<leader>rr', function()
      fterm.toggle()
    end, { desc = 'Toggle the program runner' })
    -- web runners
    -- local npmrundev = fterm:new({ ft = 'fterm_npmrundev', cmd = "npm run dev" })
    -- local npmrunstart = fterm:new({ ft = 'fterm_npmrunstart', cmd = "npm run start" })
    -- local makerun = fterm:new({ ft = 'fterm_makerun', cmd = "make run" })

    map({ 'n', 't', 'i' }, '<A-a>', function()
      fterm.run({ 'cd', sylpath.current_file_dir_path() })
    end, { desc = "Toggle floating term at buf location" })

    -- map({ 'n', 't' }, '<leader>rd', function()
    --   npmrundev:toggle()
    -- end, { desc = "npm run dev" })
    -- map({ 'n', 't' }, '<leader>rs', function()
    --   npmrunstart:toggle()
    -- end, { desc = "npm run start" })
    -- map({ 'n', 't' }, '<leader>ru', function()
    --   makerun:toggle()
    -- end, { desc = "make run" })
  end
}
