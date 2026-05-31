local ls = require("luasnip")
local date = require("utils.date")
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")

return {

  s(
    {
      trig = "entry",
      name = "Ledger entry",
      dscr = "Ledger entry",
    },
    fmt("{} {}\n    {}    {}\n    {}    {}\n", {
      extras.partial(vim.fn.strftime,"%Y/%m/%d"),
      ls.i(1),
      ls.i(2),
      ls.i(3),
      ls.i(4),
      ls.i(5),
    })
  ),
}
