require("wk.options")

require("wk.plugins")

require("wk.keymaps").setup()
require("wk.highlights").setup()
require("wk.statusline").setup()

require("wk.diagnostics").setup()
require("wk.autocommands").setup()

vim.o.guicursor =
"n-c:Cursor-blinkon100,i-ci:CursorInsert-blinkon100,v:CursorVisual-blinkon100,o:CursorPending-blinkon100,r-cr:CursorReplace-hor20-blinkon100"
