vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4

local c = require("wk/colors")

vim.api.nvim_set_hl(0, "@type.sql", { fg = c.green_idk })
vim.api.nvim_set_hl(0, "@type.builtin.sql", { fg = c.tag })
vim.api.nvim_set_hl(0, "@keyword.sql", { fg = c.fun2 })
vim.api.nvim_set_hl(0, "@keyword.operator.sql", { fg = c.beige })
vim.api.nvim_set_hl(0, "@attribute.sql", { fg = c.fun2 })
