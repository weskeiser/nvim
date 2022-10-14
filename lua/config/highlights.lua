local c = require("config/colors")

local highlights = {
	Normal = { bg = NONE },
	NormalNC = { bg = NONE },
	NormalFloat = { bg = c.dark_grey },

	-- Cursor and Line Number
	LineNr = { fg = c.blue_dark },
	Cursor = { bg = c.funkygreen },
	CursorVisual = { bg = c.bright_green },
	CursorPending = { bg = c.white },
	cursorLineNr = { fg = c.orange_primary, bg = c.cursorline },
	cursorLine = { bg = c.cursorline },
	CursorLineSign = { bg = c.cursorline },

	-- Misc
	MatchParen = { fg = c.bright_green },

	TreesitterContext = { bg = c.bg_light },
	TreesitterContextLineNumber = { bg = c.bg_light, fg = c.orange_primary },

	Pmenu = { fg = "", bg = NONE },

	-- LSP

	DiagnosticInformation = { bg = c.bg_light },
	DiagnosticInfo = { bg = c.bg_light },

	DiagnosticVirtualTextInfo = { bg = c.bg_light },
	DiagnosticVirtualTextWarn = { fg = c.orange_primary, bg = c.bg_light },
	DiagnosticVirtualTextError = { fg = c.red_error, bg = c.bg_light },
	DiagnosticVirtualTextHint = { fg = c.yellow_error, bg = c.bg_light },

	DiagnosticSignInfo = { bg = c.bg_light },
	DiagnosticSignError = { fg = c.bg, bg = c.red_error },
	DiagnosticSignWarn = { fg = c.bg, bg = c.orange_primary },
	DiagnosticSignHint = { fg = c.black, bg = c.yellow_error },

	DiagnosticFloatingInfo = { bg = c.bg_light },
	DiagnosticFloatingError = { fg = c.red_error, bg = c.bg_light },
	DiagnosticFloatingWarn = { fg = c.orange_primary, bg = c.bg_light },
	DiagnosticFloatingHint = { fg = c.yellow_error, bg = c.bg_light },

	Todo = { fg = "#ffcb6b", bold = true, italic = true },
	Error = { fg = "#ff5370", bold = true, underline = true },

	--Conceal = { fg = "#757c9f" },

	-- Buffer
	BufferTabpageFill = { fg = c.dark_grey, bg = c.dark_grey },

	BufferCurrent = { fg = c.orange_primary },
	BufferCurrentSign = { fg = c.orange_primary },

	BufferVisible = { fg = c.light_grey, bg = c.background },
	BufferVisibleMod = { bg = c.background },
	BufferVisibleSign = { fg = c.dark_grey, bg = c.background },

	BufferInactive = { fg = c.light_grey, bg = c.dark_grey },
	BufferInactiveMod = { bg = c.dark_grey },
	BufferInactiveSign = { fg = c.dark_grey, bg = c.dark_grey },

	-- Treesitter
	TSProperty = { fg = c.property },
	Property = { fg = c.property },
	TSField = { fg = c.property },
	TSTagAttribute = { fg = c.property },
	TSTypeBuiltin = { fg = c.property },
	Statement = { fg = c.const },
	TSConstMacro = { fg = c.const },

	TSVariable = { fg = c.variable },
	TSVariableBuiltin = { fg = c.variable },
	TSPunctBracket = { fg = c.const },
	TSParameter = { fg = c.variable },
	TSConstant = { fg = c.variable },

	TSRepeat = { fg = c.const },

	TSPunctDelimiter = { fg = c.const },
	TSTag = { fg = c.func },

	TSOperator = { fg = c.const },
	TSConditional = { fg = c.const },
	TSException = { fg = c.const },
	TSInclude = { fg = c.const },
	TSURI = { fg = c.const },
	TSInclude = { fg = c.const },
	TSTagDelimiter = { fg = c.const },
	TSKeywordReturn = { fg = c.cyan },
	TSPunctSpecial = { fg = c.identifier },
	TSStorageClass = { fg = c.identifier },
	TSEnvironment = { fg = c.identifier },

	TSString = { fg = c.green_string },

	Identifier = { fg = c.identifier },
	--TSText = { fg = c.identifier },
	--TSNone = { fg = c.identifier },

	TSType = { fg = c.pink },
	TSTypeBuiltin = { fg = c.pink },

	TSMethod = { fg = c.func },
	TSMath = { fg = c.func },
	TSFunction = { fg = c.func },
	TSFuncMacro = { fg = c.func },
	TSMethodCall = { fg = c.func },
	TSConstructor = { fg = c.func },
	TSFuncBuiltin = { fg = c.func },
}

for k, v in pairs(highlights) do
	vim.api.nvim_set_hl(0, k, v)
end
