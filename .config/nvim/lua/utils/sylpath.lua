local function current_file_dir_path()
  -- print("current_file_dir_path")
  local path = vim.fn.expand('%:p:h') --current file dir
  -- print(path)
  -- print("subpathis:",string.sub(path, 1, 7))

  if string.sub(path, 1, 7) == "oil:///" then
    -- print('oil is here')
    -- Remove the "oil://" prefix
    return string.sub(path, 7)
  else
    return path
  end
end

local function current_file_path()
  -- print("current_file_dir_path")
  local path = vim.fn.expand('%') --current file dir
  -- print(path)
  -- print("subpathis:",string.sub(path, 1, 7))

  if string.sub(path, 1, 7) == "oil:///" then
    return current_file_dir_path()
  else
    return path
  end
end

local function relative_to_syl_root_dir()
  local markers = { ".sylroot" }

  -- Go up the directory tree looking for a root marker
  local cwd = current_file_dir_path()
  -- print("cwd sy is ",cwd)
  local c = './'
  while cwd ~= "/" do
    for _, marker in ipairs(markers) do
      local marker_path = cwd .. "/" .. marker
      if vim.fn.filereadable(marker_path) == 1 then
        return c
      end
    end
    -- Go up one directory
    cwd = vim.fn.fnamemodify(cwd, ":h")
    c = c .. '..' .. '/'
  end

  -- Return current directory if no root is found
  return '.'
end

local function find_syl_root_dir()
  -- print("find_syl_root_dir is ")
  local markers = { ".sylroot" }

  -- Go up the directory tree looking for a root marker
  local cwd = current_file_dir_path()
  -- print("cwd is ",cwd)
  while cwd ~= "/" do
    for _, marker in ipairs(markers) do
      local marker_path = cwd .. "/" .. marker
      if vim.fn.filereadable(marker_path) == 1 then
        return cwd
      end
    end
    -- Go up one directory
    cwd = vim.fn.fnamemodify(cwd, ":h")
  end

  -- Return current directory if no root is found
  return vim.fn.getcwd()
end

local M = {
  find_syl_root_dir = find_syl_root_dir,
  current_file_dir_path = current_file_dir_path,
  current_file_path = current_file_path,
  relative_to_syl_root_dir = relative_to_syl_root_dir
}
return M
