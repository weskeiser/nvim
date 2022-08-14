-- Material Theme
vim.g.material_style = "palenight"

local c = {
  green_primary =  '#6da832',
  orange_primary =  '#f99157',
  bg = '#212a3b',
  bg_dark = '#273145',
  bright_green = '#66FF00',
  light_grey = '#a6accd',
  dark_grey = '#313547',
  string_green = '#C3E88D',

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
		darker = true -- Enable higher contrast text for darker style
	},

	disable = {
		colored_cursor = true, -- Disable the colored cursor
		borders = false, -- Disable borders between verticaly split windows
		background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false -- Hide the end-of-buffer lines
	},

	lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

	async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)


	custom_highlights = {
    -- Telescope
    TelescopeNormal = { fg =  c.green_primary, bg = c.bg },
    TelescopePromptNormal = { fg = c.orange_primary, bg = c.bg },


    TelescopePromptTitle = { fg = c.orange_primary, bg=c.bg},
    TelescopePromptBorder = { fg =  c.green_primary, bg=c.bg},
    TelescopePromptCounter = { fg = c.orange_primary },
    TelescopePromptPrefix = { fg =  c.green_primary },

    TelescopePreviewTitle = { fg = c.orange_primary },
    TelescopePreviewBorder = { fg =  c.green_primary, bg=c.bg},

    TelescopeResultsTitle = { fg = c.orange_primary, bg=c.bg},
    TelescopeResultsBorder = { fg =  c.green_primary, bg=c.bg},

    TelescopeSelection = { fg = c.bright_green },
    TelescopeSelectionCaret = { fg = c.bright_green },
    TelescopeMatching = { fg = ''},

    --NvimTree
    NvimTreeNormalNC = { bg = c.bg_dark},
    NvimTreeFolderName = { fg =  c.string_green},
    NvimTreeOpenedFolderName = { fg =  c.string_green },
    NvimTreeRootFolder = { fg = c.orange_primary },
    --NvimTreeVertSplit = { fg= c.bg_dark, bg= c.bg_dark},
    NvimTreeVertSplit = { fg= c.green_primary, bg= c.green_primary},

    -- Indent Blankline
    IndentBlanklineContextChar = { fg = '#4c5e90' },
  }
})



