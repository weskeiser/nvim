local c = require("wk/colors")
local hl = require("wk/util").hl

-- hl("@spell.arduino", { link = "Comment" })
hl("@define.arduino", { link = "@keyword" })
-- hl("@type.qualifier.arduino", { link = "Constant" })

vim.keymap.set("n", "<F3>",
    ":!arduino-cli compile --clean -u --log-file ./log.txt --no-color -b arduino:avr:nano -p /dev/ttyUSB0<CR>"
    , { desc = "Arduino compile" })

vim.keymap.set("n", "<F8>",
    ":!arduino-cli compile --clean -u --log-file ./log.txt --no-color -b arduino:avr:nano -p /dev/ttyUSB1<CR>"
    , { desc = "Arduino compile" })
