local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local f = ls.function_node

local function fn(
    args,     -- text from i(2) in this example i.e. { { "456" } }
    parent,   -- parent snippet or parent node
    user_args -- user_args from opts.user_args
)
  local env = parent.snippet.env
  return env.TM_FILENAME_BASE
end

local function rep1(arg)
  return string.gsub(arg[1][1], "^%l", string.upper)
end


return {
  s(
    {
      trig = "cn",
      name = "className",
      dscr = "className",
    },
    fmt("className=\"{}\"", {
      ls.i(1),
    })
  ),
  s(
    {
      trig = "oc",
      name = "onClick",
      dscr = "onClick",
    },
    fmt("onClick={{()=>{})}}", {
      ls.i(1),
    })
  ),
  s({
      trig = "rfc",
      name = "React Functional COmponent",
      dscr = "React Functional COmponent",
    },
    fmt([[
interface OwnProps {{
    {}
}}
export const {} = ({{ }}:OwnProps) => {{
  return (
  {}
  )
}}
  ]], {
      ls.i(1),
      ls.function_node(fn),
      ls.i(2)
    })
  ),
  s({
      trig = "rfcs",
      name = "React Simple Functional COmponent",
      dscr = "React Functional COmponent",
    },
    fmt([[
export const {} = ()=> {{
  return (
  {}
  )
}}
  ]], {
      ls.function_node(fn),
      ls.i(1)
    })
  ),
  s(
    {
      trig = "sylc",
      name = "consolelog",
      dscr = "consolelog",
    },
    fmt("console.log('sylc {}')", {
      ls.i(1),
    })
  ),
  s(
    {
      trig = "tsi",
      name = "tsignore next line",
      dscr = "tsignore next line typescript",
    },
    fmt("// @ts-ignore:next-line ", {})
  ),
  s(
    {
      trig = "tsix",
      name = "tsignore next line",
      dscr = "tsignore next line tsx",
    },
    ls.text_node("{/* @ts-ignore:next-line */}")
  ),
  s({
      trig = "us",
      name = "Use state",
      dscr = "Use state",
    },
    fmt([[const [{},set{}] = useState<{}>({}) ]], {
      ls.i(1),
      ls.function_node(rep1, { 1 }),
      ls.i(2),
      ls.i(0),
    })
  ),
  s({
      trig = "uf",
      name = "Use effect",
      dscr = "Use effect",
    },
    fmt([[useEffect(()=>{{
      {}
    }},[{}])]], {
      ls.i(0),
      ls.i(1),
    })
  )
}
