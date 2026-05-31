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
  local trimmed = string.gsub(env.TM_CURRENT_LINE, "^%s+", "") --trim start
  local fwf = string.gmatch(trimmed, "(%S*)")                  -- get matching pattern anything not %s %S is complementary
  local fwl = string.gsub(fwf(), "^%u", string.lower)

  return fwl
end


return {
  s(
    {
      trig = "js",
      name = "JSON tag",
      dscr = "Add json tag",
    },
    fmt("`json:\"{}\"{}`", {
      f(fn),
      ls.i(1)
    })
  ),
  s(
    {
      trig = "ie",
      name = "if_error_not_nil",
      dscr = "If error is not nil",
    },
    fmt("if err != nil {{\n{}\n}}", {
      ls.i(1)
    })
  ),
  s(
    {
      trig = "sylc",
      name = "sylc",
      dscr = "Consoling sylc",
    },
    fmt("fmt.Println(\"sylc {}\",{})", {
      ls.i(1),
      ls.i(2),
    })
  ),
  s(
    {
      trig = "vl",
      name = "Validate tag",
      dscr = "Add validate tag inside already a tag",
    },
    fmt("validate:\"{}\"", {
      ls.i(1),
    })
  ),
  s(
    {
      trig = "vlr",
      name = "Validate tag required",
      dscr = "Add validate tag inside already a tag",
    },
    ls.text_node("validate:\"required\"")
  ),
  s(
    {
      trig = "grj",
      name = "Read json",
      dscr = "Read json with bells n wistles",
    },
    fmt([[
	er := h.ReadJSON(&payload, w, r)
	if er != nil {{
		fmt.Println("Error ", er)
		h.ErrorResponse(er, http.StatusBadRequest, "Incorrect payload", w)
		return
	}}
    ]], {}
    )
  ),
  s(
    {
      trig = "gvl",
      name = "Validate",
      dscr = "Validate based on tags",
    },
    fmt([[
	// validation
	ver := m.app.Validate.Struct(payload)
	if ver != nil {{
		fmt.Println("Some error in validatoin '", ver)
		h.ErrorResponse(ver, http.StatusBadRequest, "Incorrect payload", w)
		return
	}}

    ]], {}
    )
  ),
  s(
    {
      trig = "gwb",
      name = "Write json",
      dscr = "Write json back to api",
    },
    fmt([[
	// write back
	err := h.WriteJson(h.Success{{
		Msg: "{} successfully",
	}}, w)
	if err != nil {{
		fmt.Println("Error  writing ", err)
	}}

    ]], { ls.i(1) }
    )
  ),
  s(
    {
      trig = "gem",
      name = "Error msg",
      dscr = "ErrorResponse with msg",
    },
    fmt([[
		msg := "{}"
		h.ErrorResponse(fmt.Errorf(msg), {}, msg, w)
    ]], { ls.i(1), ls.i(2) }
    )
  ),
  s(
    {
      trig = "ps",
      name = "Print struct better",
      dscr = "Print struct better",
    },
    fmt([[
  fmt.Printf("%+v\n",{})
    ]], { ls.i(1)}
    )
  ),
}
