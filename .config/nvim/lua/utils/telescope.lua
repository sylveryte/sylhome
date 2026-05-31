local map = vim.keymap.set
local builtin = require('telescope.builtin')

local find_dir_with_zoxide = function(selector)
  -- Use zoxide to list available directories
  local zoxide_dirs = vim.fn.systemlist("zoxide query -l")

  -- Prompt the user to select a directory using Telescope
  vim.ui.select(zoxide_dirs, {
    prompt = 'Select a directory from zoxide: ',
  }, function(selected_dir)
    if selected_dir then
      if selector == 2 then
        builtin.live_grep({ cwd = selected_dir })
      else
        builtin.find_files({ cwd = selected_dir })
      end
    end
  end)
end


return { find_dir_with_zoxide = find_dir_with_zoxide }
