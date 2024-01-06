vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

local c = require("wk/colors")
local setHl = function(k, v)
	vim.api.nvim_set_hl(0, k, v)
end

setHl("@lsp.typemod.class.defaultLibrary.svelte", { link = "Function" })
setHl("@tag.delimiter.svelte", { link = "@punctuation.bracket" })
setHl("@tag.svelte", { fg = c.tag })
setHl("@tag.script.svelte", { fg = c.bluebrighter })
setHl("@tag.style.svelte", { fg = c.bluebrighter })
setHl("@type.css", { fg = c.orange_fun })
-- setHl("@tag.attribute.svelte", { fg = c.purple_pinkish })
setHl("@tag.attribute.svelte", { link = "Keyword" })
setHl("@keyword.svelte", { fg = c.green_deep })
setHl("@property", { fg = c.blue_nice })
setHl("@property.css", { fg = c.identifier2 })
