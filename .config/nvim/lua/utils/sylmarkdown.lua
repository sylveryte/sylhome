local function get_current_line_links()
  local bufn = vim.api.nvim_get_current_buf()
  local cursor_line = vim.api.nvim_win_get_cursor(0)[1] --rembr 1index

  local parser = vim.treesitter.get_parser(bufn, 'markdown_inline')
  local tree = parser:parse()[1]
  local root = tree:root()

  local query = vim.treesitter.query.parse("markdown_inline", '(shortcut_link) @slink')

  local positions = {}

  for _, match, _ in query:iter_matches(root, bufn, 0, -1) do
    for id, nodes in pairs(match) do
      local start_row, start_col, _, end_col = nodes:range()

      -- +1 to make it 1index based, end_col - start_col since it's detecting [ ] as shortcut_link
      if start_row + 1 == cursor_line and end_col - start_col > 4 then
        table.insert(positions, {
          line = cursor_line,
          start_col = start_col,
          end_col = end_col + 1 --include last ]
        })
      end
    end
  end

  return positions
end

local function better_link_action(action)
  -- local positions = get_current_line_links()
  -- local c = vim.api.nvim_win_get_cursor(0)
  -- local cl = c[1]
  -- local cr = c[2]
  -- local cra = cr + 1 --adjust with link pos
  --
  -- local left, right
  -- for _, pos in ipairs(positions) do
  --   if pos.start_col <= cra and pos.end_col >= cra then
  --     action()
  --     return true
  --   else
  --     if pos.end_col < cra then
  --       local distance = cra - pos.end_col
  --       if left then
  --         if left.distance > distance then
  --           left = pos
  --           left.distance = distance
  --         end
  --       else
  --         left = pos
  --         left.distance = distance
  --       end
  --     end
  --     if pos.start_col > cra then
  --       local distance = pos.start_col - cra
  --       if right then
  --         if right.distance > distance then
  --           right = pos
  --           right.distance = distance
  --         end
  --       else
  --         right = pos
  --         right.distance = distance
  --       end
  --     end
  --   end
  -- end
  -- if right then
  --   vim.api.nvim_win_set_cursor(0, { cl, right.start_col - 1 })
  -- elseif left then
  --   vim.api.nvim_win_set_cursor(0, { cl, left.end_col - 1 })
  -- else
  --   local d = os.date("%M:%S")
  --   print("No link found", d)
  -- end
  action()
  return true
end


return {
  get_current_line_links = get_current_line_links,
  better_link_action = better_link_action
}
