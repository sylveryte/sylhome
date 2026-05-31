return{
    "vhyrro/luarocks.nvim",
    enabled=false, --issues with something
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
        rocks = { "magick" },
    },
}
