local c = require("config/colors")

function highlightRest()
	local highlights = {

		CmpItemAbbrDeprecated = { bg = NONE, gui = strikethrough, fg = "#808080" },
		CmpItemAbbrMatch = { bg = NONE, fg = "#569CD6" },
		CmpItemAbbrMatchFuzzy = { bg = NONE, fg = "#569CD6" },
		CmpItemKindText = { bg = NONE, fg = "#9CDCFE" },
		CmpItemKindProperty = { fg = NONE, fg = "#D4D4D4" },
		CmpItemKindUnit = { fg = NONE, fg = "#D4D4D4" },
		CmpItemKindFunction = { bg = "#323234", fg = c.orange_secondary },
		CmpItemKindConstant = { bg = "#323234", fg = c.green_primary },
		CmpItemKindVariable = { bg = "#323234", fg = c.green_primary },
		CmpItemKindMethod = { bg = "#323234", fg = c.identifier },
		CmpItemKindField = { bg = "#323234", fg = c.identifier },
		CmpItemKindModule = { bg = "#727279", fg = c.orange_secondary },
		CmpItemKindKeyword = { bg = "#323234", fg = c.white },
		CmpItemKindInterface = { bg = "#323234", fg = c.purple },

		-- Telescope
		TelescopePromptNormal = { fg = c.orange_primary },

		TelescopePromptTitle = { fg = c.funkygreen },
		TelescopePromptBorder = { fg = c.green_primary },
		TelescopePromptCounter = { fg = c.orange_primary },
		TelescopePromptPrefix = { fg = c.green_primary },

		TelescopePreviewTitle = { fg = c.funkygreen },
		TelescopePreviewBorder = { fg = c.green_primary },

		TelescopeResultsTitle = { fg = c.funkygreen },
		TelescopeResultsBorder = { fg = c.green_primary },

		TelescopeSelection = { fg = c.bright_green },
		TelescopeSelectionCaret = { fg = c.bright_green },
		TelescopeMatching = { fg = c.orange_primary },

		TelescopeNormal = { fg = "#a6accd" },

		Directory = { fg = "#82aaff" },
		Visual = { bg = "#444267" },
		Special = { fg = "#f07178" },
		WinSeparator = { fg = "#364367" },
		VertSplit = { fg = "#364367" },

		--NvimTree
		NvimTreeRootFolder = { fg = c.green_primary },
		NvimTreeNormalNC = { bg = c.bg_dark_dark },
		NvimTreeFolderName = { fg = c.orange_darker },
		NvimTreeFolderIcon = { fg = c.orange_darker },
		NvimTreeOpenedFolderName = { fg = c.orange_primary },
		NvimTreeVertSplit = { fg = c.green_primary, bg = c.green_primary },
		NvimTreeOpenedFile = { fg = c.identifier },
		NvimTreeExecFile = { fg = c.identifier },
		NvimTreeImageFile = { fg = c.identifier },
		NvimTreeFileStaged = { fg = c.identifier },
		NvimTreeFileNew = { fg = c.identifier },
		NvimTreeFileMerge = { fg = c.identifier },
		NvimTreeFileStaged = { fg = c.identifier },
		NvimTreeFileRenamed = { fg = c.identifier },
		NvimTreeLiveFilterValue = { fg = c.identifier },
		NvimTreeLiveFilterPrefix = { fg = c.identifier },
		NvimTreeLspDiagnosticsHint = { fg = c.identifier },

		SignColumn = { fg = "#a6accd", bg = NONE },
		DiffAdd = { fg = "#c3e88d", bg = NONE },
		DiffChange = { fg = "#82aaff", bg = NONE },
		DiffDelete = { fg = "#f07178", bg = NONE },
		DiffText = { fg = "#82aaff", reverse = true },
		DiffFile = { fg = "#717cb4" },
		DiffLine = { fg = c.cyan },
		NonText = { fg = "#515772" },
		StatusLine = { fg = "#a6accd" },
		StatusLineNC = { fg = "#515772" },
		Comment = { fg = "#676e95" },

		Boolean = { fg = "#f78c6c" },
		Number = { fg = "#f78c6c" },
		TSNone = { fg = "#bfcef8" }, -- make whiter

		-- Indent Blankline

		IndentBlanklineSpaceChar = { fg = "#A6ACCD", nocombine = true },
		IndentBlanklineContextStart = { special = "#000000", undercurl = true },
		--Identifier = { fg = c.pink },
		--TSText = { fg = c.pink },
		--TSNone = { fg = c.pink },
	}

	for k, v in pairs(highlights) do
		vim.api.nvim_set_hl(0, k, v)
	end
end

local autocmd = vim.api.nvim_create_autocmd
-- autocmd("WinEnter", {
-- 	pattern = "*",
-- 	-- command = "lua highlightRest()",
-- 	command = ":echo 'hi'",
-- })
--
-- function test23()
-- 	return ':echo "hi"'
-- end

vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = "#ffffff" })
vim.cmd("hi NvimTreeFolderName guifg=#ffffff")

highlightRest()
