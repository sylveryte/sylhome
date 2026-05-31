local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

local function hello()
  if vim.fn.mode() == 'i' then
    return '🍏'
  elseif vim.fn.mode() == 'V' then
    return "🍉"
  else
    return "🫐"
  end
end


local function lsp()
  local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  local count = 0;
  for _, _ in pairs(clients) do
    count = count + 1
  end
  if next(clients) ~= nil then
    if count == 1 then
      return '🌷(' .. count .. ')'
    end
    if count == 2 then
      return '🍁(' .. count .. ')'
    end
    return '🪴(' .. count .. ')'
  end
  return '📚'
end

local config = {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {},
    lualine_b = { hello,
      { lsp, color = { gui = 'bold' } },
      {
        'diff',
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        cond = conditions.hide_in_width,
      }, 'diagnostics'
    },
    lualine_c = { 'filename', {
      'filesize',
      cond = conditions.hide_in_width,
    }
    },
    lualine_x = {
      {
        'encoding',
        cond = conditions.hide_in_width,
      },
      {

        'fileformat',
        cond = conditions.hide_in_width,
      },
      {

        'filetype',
        cond = conditions.hide_in_width,
      }
    },
    lualine_y = {
      {
        'location',
        cond = conditions.hide_in_width,
      },
      'progress',
    },
    lualine_z = { 'branch' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
  theme = "auto"
}

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require("lualine").setup(config)
  end
}
