local c = require("config/colors")

-- Material Theme
vim.g.material_style = "palenight"

-- local c = {
--   --bg = '#2b2b2c',
--   bg = 'NONE',
--   white = '#ffffff',
--   green_primary =  '#6da832',
--   bright_green = '#66FF00',
--   funkygreen = '#18d18d',
--   orange_primary =  '#f99157',
--   orange_darker = '#f76f26',
--   orange_secondary = '#de7621',
--   identifier = '#a0afd9',
--   purple = '#C792EA',
--   red = '#d04e4e',
-- }

require("material").setup({

	contrast = {
		sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
		floating_windows = false, -- Enable contrast for floating windows
		line_numbers = false, -- Enable contrast background for line numbers
		sign_column = false, -- Enable contrast background for the sign column
		cursor_line = false, -- Enable darker background for the cursor line
		non_current_windows = false, -- Enable darker background for non-current windows
		popup_menu = false, -- Enable lighter background for the popup menu
	},

	italics = {
		comments = false, -- Enable italic comments
		keywords = false, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false, -- Enable italic variables
	},

	contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
		--"terminal", -- Darker terminal background
		--"packer", -- Darker packer background
		--"qf" -- Darker qf list background
	},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = false, -- Enable higher contrast text for darker style
	},

	disable = {
		colored_cursor = false, -- Disable the colored cursor
		borders = false, -- Disable borders between verticaly split windows
		background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false, -- Hide the end-of-buffer lines
	},

	lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

	async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

	custom_highlights = {

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

		--NvimTree
		NvimTreeRootFolder = { fg = c.green_primary },
		NvimTreeNormalNC = { bg = c.bg_dark_dark },
		NvimTreeFolderName = { fg = c.orange_darker },
		NvimTreeOpenedFolderName = { fg = c.orange_primary },
		NvimTreeVertSplit = { fg = c.green_primary, bg = c.green_primary },

		-- Indent Blankline

		IndentBlanklineSpaceChar = { fg = "#A6ACCD", nocombine = true },
		IndentBlanklineContextStart = { special = "#000000", undercurl = true },
		--Identifier = { fg = c.pink },
		--TSText = { fg = c.pink },
		--TSNone = { fg = c.pink },
	},
})
