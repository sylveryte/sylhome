return {
  "3rd/diagram.nvim",
  -- dependencies = {
  --   { "3rd/image.nvim" }, -- already setup you'd probably want to configure image.nvim manually instead of doing this
  -- },
  opts = {                           -- you can just pass {}, defaults below
    events = {
      -- render_buffer = { "InsertLeave", "BufWinEnter","TextChanged" }, -- for automatic in -- for now manual is better
      render_buffer = { "InsertLeave", "BufWinEnter"},
      -- render_buffer = {}, -- manually press K to render see below
      clear_buffer = { "BufLeave" },
    },
    renderer_options = {
      mermaid = {
        background = nil, -- nil | "transparent" | "white" | "#hex"
        theme = nil,      -- nil | "default" | "dark" | "forest" | "neutral"
        scale = 3,        -- nil | 1 () | 2  | 3 | ...
        width = 800,      -- nil | 800 | 400 | ...
        height = 600,     -- nil | 600 | 300 | ...
        cli_args = nil,   -- nil | { "--no-sandbox" } | { "-p", "/path/to/puppeteer" } | ...
      },
      -- plantuml = {
      --   charset = nil,
      --   cli_args = nil, -- nil | { "-Djava.awt.headless=true" } | ...
      -- },
      d2 = {
        theme_id = 100,
        width = 1200, -- nil | 800 | 400 | ...
        height = 900, -- nil | 600 | 300 | ...
        dark_theme_id = nil,
        scale = nil,
        layout = nil,
        sketch = nil,
        cli_args = nil, -- nil | { "--pad", "0" } | ...
      },
      gnuplot = {
        size = nil,     -- nil | "800,600" | ...
        font = nil,     -- nil | "Arial,12" | ...
        theme = nil,    -- nil | "light" | "dark" | custom theme string
        cli_args = nil, -- nil | { "-p" } | { "-c", "config.plt" } | ...
      },
    }
  },
  --  keys = {
  --   {
  --     ",d", -- or any key you prefer
  --     function()
  --       require("diagram").show_diagram_hover()
  --     end,
  --     mode = "n",
  --     ft = { "markdown"}, -- Only in these filetypes
  --     desc = "Show diagram in new tab",
  --   },
  -- },
}
