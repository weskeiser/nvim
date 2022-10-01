-- Material Theme
vim.g.material_style = "palenight"

local c = {
  white = '#ffffff',
  green_primary =  '#6da832',
  orange_primary =  '#f99157',
  orange_darker = '#f76f26',
  --bg = '#303d55',
  --bg = '#2b2b2c',
  bg = 'NONE',
  bg_dark = '#212a3b',
  bright_green = '#66FF00',
  light_grey = '#a6accd',
  dark_grey = '#303d55',
  string_green = '#C3E88D',
  indent1 = '#364367',
  indent2 = '#4c5e90',
  indent3 = '#3a4b78',
  funkygreen = '#18d18d',
  const = '#de7621',
  variableDark = '#9774A8',
  string = '#688458',
  property = '#969cbb',
  func = '#FEC56D',
  identifier = '#a0afd9',
  type = '#C792EA',
  red = '#d04e4e',
}

require('material').setup({

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
		variables = false -- Enable italic variables
	},

	contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
		--"terminal", -- Darker terminal background
		--"packer", -- Darker packer background
		--"qf" -- Darker qf list background
	},

	high_visibility = {
		lighter = false, -- Enable higher contrast text for lighter style
		darker = false -- Enable higher contrast text for darker style
	},

	disable = {
		colored_cursor = false, -- Disable the colored cursor
		borders = false, -- Disable borders between verticaly split windows
		background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false -- Hide the end-of-buffer lines
	},

	lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

	async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)


	custom_highlights = {

    CmpItemAbbrDeprecated = { bg=NONE, gui=strikethrough, fg='#808080' },
    CmpItemAbbrMatch = { bg=NONE, fg='#569CD6' },
    CmpItemAbbrMatchFuzzy = { bg=NONE, fg='#569CD6' },
    CmpItemKindText = { bg=NONE, fg='#9CDCFE' },
    CmpItemKindProperty = { fg=NONE, fg='#D4D4D4' },
    CmpItemKindUnit = { fg=NONE, fg='#D4D4D4' },
    CmpItemKindFunction = { bg = '#323234', fg = c.const},
    CmpItemKindConstant = { bg = '#323234', fg = c.green_primary },
    CmpItemKindVariable = { bg = '#323234', fg = c.green_primary },
    CmpItemKindMethod = { bg = '#323234', fg = c.identifier },
    CmpItemKindField = { bg = '#323234', fg = c.identifier },
    CmpItemKindModule = { bg = '#727279', fg = c.const },
    CmpItemKindKeyword = { bg = '#323234', fg = c.white },
    CmpItemKindInterface = { bg= '#323234', fg = c.type },


    -- Telescope
    TelescopeNormal = {  bg = c.bg },
    TelescopePromptNormal = { fg = c.orange_primary, bg = c.bg },


    TelescopePromptTitle = { fg = c.funkygreen, bg=c.bg},
    TelescopePromptBorder = { fg =  c.green_primary, bg=c.bg},
    TelescopePromptCounter = { fg = c.orange_primary },
    TelescopePromptPrefix = { fg =  c.green_primary },

    TelescopePreviewTitle = { fg = c.funkygreen },
    TelescopePreviewBorder = { fg =  c.green_primary, bg=c.bg},

    TelescopeResultsTitle = { fg = c.funkygreen, bg=c.bg},
    TelescopeResultsBorder = { fg =  c.green_primary, bg=c.bg},

    TelescopeSelection = { fg = c.bright_green },
    TelescopeSelectionCaret = { fg = c.bright_green },
    TelescopeMatching = { fg = c.orange_primary},

    --NvimTree
    NvimTreeRootFolder = { fg = c.red },
    NvimTreeNormalNC = { bg = c.bg_dark_dark},
    NvimTreeFolderName = { fg =  c.orange_darker},
    NvimTreeOpenedFolderName = { fg =  c.orange_primary },
    --NvimTreeVertSplit = { fg= c.bg_dark_dark, bg= c.bg_dark},
    NvimTreeVertSplit = { fg= c.green_primary, bg= c.green_primary},

    -- Indent Blankline

    IndentBlanklineSpaceChar = { fg = '#A6ACCD',  nocombine=true},
    IndentBlanklineContextStart = { special = '#000000', undercurl=true },

    --Identifier = { fg = c.pink },
    --TSText = { fg = c.pink },
    --TSNone = { fg = c.pink },
    },
  })


  --IndentBlanklineContextChar = { fg = c.indent2 },
  --IndentBlanklineSpaceChar = { bg = '#18d18d',  gui=nocombine },


