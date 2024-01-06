local c = require("wk/colors")
local setHl = function(k, v)
    vim.api.nvim_set_hl(0, k, v)
end

setHl("storageClass", { fg = c.identifier })
setHl("statement", { fg = c.tag })
setHl("sassClass", { fg = c.pink_soft })
setHl("sassDefinition", { fg = c.pink_soft })
setHl("Constant", { fg = c.yellow_text })
setHl("Special", { fg = c.yellow_text })
setHl("PreProc", { fg = c.purple })
setHl("cssSelectorOp", { fg = "#82aaff" })
setHl("cssTagName", { fg = c.tag })
-- setHl("sassProperty", { fg = c.identifier })
setHl("sassAttribute", { fg = c.pink_soft })

setHl("@property.scss", { fg = c.identifier })
setHl("@type.definition.scss", { fg = c.identifier })
