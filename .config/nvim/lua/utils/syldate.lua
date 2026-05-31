local date = require("utils.date")

local function get_date_string_for_month(s)
  local pattern = "(%d+)-(%d+)-"
  if s == nil then
    return nil
  end
  local y, m = s:match(pattern, 0)

  if y == nil or m == nil then
    return s
  end

  return y .. "-" .. m .. "-1"
end

local function get_last_date_of_month(dt)
  -- get first day
  local y,m,d = dt:getdate()
  -- get next month
  local nm = date(y,m,1):addmonths(1)
  -- get -1 day and return
  return nm:adddays(-1):getday()
end



return {
  get_date_string_for_month = get_date_string_for_month,
  get_last_date_of_month = get_last_date_of_month
}
