local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local s = ls.snippet
local date = require("utils.date")
local extras = require("luasnip.extras")

local function getFileNameWithoutExtension(snip)
  local fileName = snip.env.TM_FILENAME:match("(.+)%..+$")
  return fileName
end

return {
  s(
    {
      trig = "meeting",
      name = "Meeting Template",
      dscr = "Set boiler plate meeting",
    },
    fmt("* {}\n{} \n\n* Points\n\n- ( ) {}\n\n===\n___\nlink day: {}", {
      ls.f(function(_, snip)
        return getFileNameWithoutExtension(snip)
      end, {}),
      ls.f(function(_, snip)
        return date():fmt("%F-%T")
      end, {}),
      ls.i(2),
      ls.i(1),
    })
  ),
  s(
    {
      trig = "linkproperty",
      name = "Link Property",
      dscr = "Write a label and link a file",
    },
    fmt("{}: {}\n\n", {
      ls.i(1),
      ls.i(2, 'Press <C-l>'),
    })
  ),
  s(
    {
      trig = "footline",
      name = "footline",
      dscr = "Write a footer line start",
    },
    fmt("===\n___\n{}", {
      ls.i(0),
    })
  ),
  s(
    {
      trig = "fileTitle",
      name = "file title",
      dscr = "Write the title of file without md",
    },
    fmt("* {}\n\n", {
      ls.f(function(_, snip)
        return getFileNameWithoutExtension(snip)
      end, {}),
    })
  ),
  s(
    {
      trig = "conclusion",
      name = "conclusion_template",
      dscr = "Conclusion for review of day/week/month/year",
    },
    fmt(
      "* Conclusion for this {}\n\n** Best thing happened this {}?\n- {}\n\n** Worst thing happened this {}?\n- {}\n\n** Things learned?\n- {}\n\n** Needs improvement for the next {}\n- {}\n\n",
      {
        ls.i(1, "sylplaceholder"),
        extras.rep(1),
        ls.i(2),
        extras.rep(1),
        ls.i(3),
        ls.i(4),
        extras.rep(1),
        ls.i(5),
      })
  ),
  s(
    {
      trig = "goals",
      name = "goals_template",
      dscr = "Goals for review of day/week/month/year",
    },
    fmt("* Goals for this {}?\n- ( ) Plan the {} \n- ( ) {}\n\n* Potential blockers for this {}?\n- {}\n\n", {
      ls.i(1, "sylplaceholder"),
      extras.rep(1),
      ls.i(2),
      extras.rep(1),
      ls.i(3)
    })
  ),

  s(
    {
      trig = "yearly",
      name = "yearly_template",
      dscr = "Create Yearly Template Based on FileName",
    },
    fmt("* {}\n\n{{:{}:}} < {{:{}:}} > {{:{}:}}\n\n{}\n___\n\ngoal{}\n* :)\n___", {
      ls.f(function(_, snip)
        return getFileNameWithoutExtension(snip)
      end, {}),

      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1-1')
        d = d:addyears(-1)
        return d:fmt("%Y")
      end, {}),

      ls.f(function(_, snip)
        return getFileNameWithoutExtension(snip)
      end, {}),

      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1-1')
        d = d:addyears(1)
        return d:fmt("%Y")
      end, {}),


      ls.f(function(_, snip)
        local ds = ''
        local d = date(getFileNameWithoutExtension(snip) .. '-1-1')
        for i = 1, 12 do
          ds = ds .. '{:' .. d:fmt("%Y-%B") .. ':} SYLNEWLINE'
          d = d:addmonths(1)
        end
        return ds
      end, {}),

      ls.i(0),
    })
  ),

  s(
    {
      trig = "monthly",
      name = "monthly_template",
      dscr = "Create Monthly Template Based on FileName",
    },
    fmt("* {}\n\n{{:{}:}} < {{:{}:}} > {{:{}:}}\n\n{}\n___\n\ngoal{}\n===\n___\n{{:{}:}}\n", {
      ls.f(function(_, snip)
        return getFileNameWithoutExtension(snip)
      end, {}),

      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        d = d:addmonths(-1)
        return d:fmt("%Y-%B")
      end, {}),

      ls.f(function(_, snip)
        return getFileNameWithoutExtension(snip)
      end, {}),

      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        d = d:addmonths(1)
        return d:fmt("%Y-%B")
      end, {}),

      ls.f(function(_, snip)
        local ds = ''
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        for i = 1, 5 do
          ds = ds .. '{:' .. d:fmt("%Y-W%W") .. ':} SYLNEWLINE'
          d = d:adddays(7)
        end
        return ds
      end, {}),

      ls.i(0),

      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        return d:fmt("%Y")
      end, {}),
    })
  ),

  s(
    {
      trig = "wweekly",
      name = "wweekly_template",
      dscr = "Create Weekly Work Template Based on FileName",
    },
    fmt("* {}\n\n{{:{}:}}  < {{:{}:}} >  {{:{}:}}\n\n{}\n___\n\ngoal{}\n===\n___\n{{:{}:}} {{:{}:}}", {
      ls.f(function(_, snip)
        return getFileNameWithoutExtension(snip)
      end, {}),
      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        d = d:adddays(-7)
        return d:fmt("%Y-W%W")
      end, {}),
      ls.f(function(_, snip)
        return getFileNameWithoutExtension(snip)
      end, {}),
      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        d = d:adddays(7)
        return d:fmt("%Y-W%W")
      end, {}),
      ls.f(function(_, snip)
        local ds = ''
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        for i = 1, 5 do
          ds = ds .. '{:' .. d:setisoweekday(i):fmt("%F") .. ':}[' .. d:setisoweekday(i):fmt("%d %A") .. '] SYLNEWLINE'
        end
        return ds
      end, {}),
      ls.i(0),
      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        return d:fmt("%Y-%B")
      end, {}),
      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        return d:fmt("%Y")
      end, {}),
    })
  ),

  s(
    {
      trig = "dwdatom",
      name = "dwtomdatename",
      dscr = "Date and name of day after tomorrow",
    },
    fmt("*** {}", {
      ls.f(function(_, snip)
        local d = date()
        d = d:adddays(2)
        return d:fmt("%F %A")
      end, {}),
    })
  ),

  s(
    {
      trig = "dwtom",
      name = "dwtomdatename",
      dscr = "Date and name of tomorrow",
    },
    fmt("*** {}", {
      ls.f(function(_, snip)
        local d = date()
        d = d:adddays(1)
        return d:fmt("%F %A")
      end, {}),
    })
  ),

  s(
    {
      trig = "weekly",
      name = "weekly_template",
      dscr = "Create Weekly Template Based on FileName",
    },
    fmt("* {}\n\n{{:{}:}}  < {{:{}:}} >  {{:{}:}}\n\n{}\n___\n\ngoal{}\n===\n___\n{{:{}:}} {{:{}:}}", {
      ls.f(function(_, snip)
        return getFileNameWithoutExtension(snip)
      end, {}),
      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        d = d:adddays(-7)
        return d:fmt("%Y-W%W")
      end, {}),
      ls.f(function(_, snip)
        return getFileNameWithoutExtension(snip)
      end, {}),
      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        d = d:adddays(7)
        return d:fmt("%Y-W%W")
      end, {}),
      ls.f(function(_, snip)
        local ds = ''
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        for i = 1, 7 do
          ds = ds .. '{:' .. d:setisoweekday(i):fmt("%F") .. ':}[' .. d:setisoweekday(i):fmt("%d %A") .. '] SYLNEWLINE'
        end
        return ds
      end, {}),
      ls.i(0),
      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        return d:fmt("%Y-%B")
      end, {}),
      ls.f(function(_, snip)
        local d = date(getFileNameWithoutExtension(snip) .. '-1')
        return d:fmt("%Y")
      end, {}),
    })
  ),
  s(
    {
      trig = "lnyesterday",
      name = "link of yesterday in norg",
      dscr = "Create a link to yesterday's file",
    },
    fmt(
      "{{:$/journal/{}:}}[{}]",
      {
        ls.f(function(_, _)
          local d = date():adddays(-1)
          return d:fmt("%F")
        end, {}),
        ls.f(function(_, _)
          local d = date():adddays(-1)
          return d:fmt("%F %A")
        end, {}),
      })
  ),
  s(
    {
      trig = "lntomorrow",
      name = "link of tomorrow in norg",
      dscr = "Create a link to tomorrow's file",
    },
    fmt(
      "{{:$/journal/{}:}}[{}]",
      {
        ls.f(function(_, _)
          local d = date():adddays(1)
          return d:fmt("%F")
        end, {}),
        ls.f(function(_, _)
          local d = date():adddays(1)
          return d:fmt("%F %A")
        end, {}),
      })
  ),
  s(
    {
      trig = "lntoday",
      name = "link of today in norg",
      dscr = "Create a link to today's file",
    },
    fmt(
      "{{:$/journal/{}:}}[{}]",
      {
        ls.f(function(_, _)
          local d = date()
          return d:fmt("%F")
        end, {}),
        ls.f(function(_, _)
          local d = date()
          return d:fmt("%F %A")
        end, {}),
      })
  ),

  s(
    {
      trig = "daily",
      name = "daily_template",
      dscr = "Create Daily Template Based on FileName",
    },
    fmt(
      "* {}\n\n{{:{}:}}[{}] < {{:{}:}}[{}] > {{:{}:}}[{}]\n\n___\n\n* Improvement for today?\n - ( ){} \n\ngoal{}\n===\n___\n{{:{}:}}[{}] {{:{}:}} {{:{}:}}",
      {
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("%F %A")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          d = d:adddays(-1)
          return d:fmt("%F")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          d = d:adddays(-1)
          return d:fmt("%A")
        end, {}),
        ls.f(function(_, snip)
          return getFileNameWithoutExtension(snip)
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("%A")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          d = d:adddays(1)
          return d:fmt("%F")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          d = d:adddays(1)
          return d:fmt("%A")
        end, {}),
        ls.i(1),
        ls.i(0),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("%Y-W%W")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("W%W")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("%Y-%B")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("%Y")
        end, {}),
      })
  ),

  s(
    {
      trig = "wdaily",
      name = "work_daily_template",
      dscr = "Create Daily Template Based on FileName Work",
    },
    fmt(
      "* {}\n\n{{:{}:}}[{}] < {{:{}:}}[{}] > {{:{}:}}[{}]\n\n___\n\n* Tasks\n\n- ( ) Check Schedule\n- ( ) {}\n\n===\n___\n{{:{}:}}[{}] {{:{}:}} {{:{}:}}",
      {
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("%F %A")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          if d:getweekday() == 2 then
            d = d:adddays(-3)
          else
            d = d:adddays(-1)
          end
          return d:fmt("%F")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          if d:getweekday() == 2 then
            d = d:adddays(-3)
          else
            d = d:adddays(-1)
          end
          return d:fmt("%A")
        end, {}),
        ls.f(function(_, snip)
          return getFileNameWithoutExtension(snip)
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("%A")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          if d:getweekday() == 6 then
            d = d:adddays(3)
          else
            d = d:adddays(1)
          end
          return d:fmt("%F")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          if d:getweekday() == 6 then
            d = d:adddays(3)
          else
            d = d:adddays(1)
          end
          return d:fmt("%A")
        end, {}),
        ls.i(0),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("%Y-W%W")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("W%W")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("%Y-%B")
        end, {}),
        ls.f(function(_, snip)
          local d = date(getFileNameWithoutExtension(snip))
          return d:fmt("%Y")
        end, {}),
      })
  ),

  s(
    {
      trig = "wticket",
      name = "Work Ticket",
      dscr = "Write a ticket",
    },
    fmt(
    "* {}\n___\n\n** Tasks \n- ( ) {}\n\n** Unit Tests \n\n*** Setup \n ~ {} \n\n *** Features to test \n - {}\n\n===\n___\n{{{}}}[link]",
      {
        ls.f(function(_, snip)
          return getFileNameWithoutExtension(snip)
        end, {}),
        ls.i(2),
        ls.i(3),
        ls.i(4),
        ls.i(1),
      })
  ),

  s(
    {
      trig = "link",
      name = "markdown_link",
      dscr = "Create markdown link [txt](url).\nSelect link, press C-s, type link.",
    },
    fmt("[{}]({})\n{}", {
      ls.i(1),
      ls.f(function(_, snip)
        return snip.env.TM_SELECTED_TEXT[1] or {}
      end, {}),
      ls.i(0),
    })
  ),

  s(
    {
      trig = "ratings",
      name = "Ratings",
      dscr = "Rating for the period",
    },
    fmt("red: {}\nmarichi: {}\nazeel: {}\nsylveryte: {}\nparag: {}\nmystery: {}\nlight: {}\ntr: {}", {
      ls.i(1),
      ls.i(2),
      ls.i(3),
      ls.i(4),
      ls.i(5),
      ls.i(6),
      ls.i(7),
      ls.i(8),
    })
  ),

  s(
    {
      trig = "fourpillar",
      name = "Four Pillar questions",
      dscr = "All planning in the start with a todo",
    },
    fmt("Pillar one: {}\n- ( ) Pillar t_w_o: {}\n- ( ) Pillar 3333: {}\n- ( ) Pillar fourth: {}\n", {
      ls.i(1),
      ls.i(2),
      ls.i(3),
      ls.i(4),
    })
  ),

  s(
    {
      trig = "plant",
      name = "Plant Entry",
      dscr = "All info needed for a plant care entry",
    },
    fmt(
    "- Soil Mix: {}\n- Watering: {}\n- Fertilizer: {}\n- Light: {}\n- Pot size: {}\n- Benifits: {}\n- Issues: {}\n- Propogation: {}\n- Note: {}",
      {
        ls.i(1),
        ls.i(2),
        ls.i(3),
        ls.i(4),
        ls.i(5),
        ls.i(6),
        ls.i(7),
        ls.i(8),
        ls.i(9),
      })
  ),

  s( -- Codeblock {{:{
    {
      trig = "codeblock",
      name = "Make code block",
      dscr = "codeblock",
    },
    fmt("@code {}\n{}\n@end", {
      ls.i(1, "Language"),
      ls.i(0, ""),
    })
  ),
}
