local sylmarkdown = require "utils.sylmarkdown"
local function better_link_action(action)
  if vim.bo.filetype == 'markdown' then
    if sylmarkdown.better_link_action(action) then
      return
    end
  end
  action()
end

return { better_link_action = better_link_action }
