return {
    config = function()
        vim.g.material_style = "palenight"

        require("material").setup({

            contrast = {
                terminal = false,            -- Enable contrast for the built-in terminal
                sidebars = false,            -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
                floating_windows = false,    -- Enable contrast for floating windows
                cursor_line = false,         -- Enable darker background for the cursor line
                non_current_windows = false, -- Enable darker background for non-current windows
                filetypes = {},              -- Specify which filetypes get the contrasted (darker) background
            },

            styles = { -- Give comments style such as bold, italic, underline etc.
                comments = { --[[ italic = true ]]
                },
                strings = { --[[ bold = true ]]
                },
                keywords = { --[[ underline = true ]]
                },
                functions = { --[[ bold = true, undercurl = true ]]
                },
                variables = {},
                operators = {},
                types = {},
            },

            high_visibility = {
                lighter = false, -- Enable higher contrast text for lighter style
                darker = false,  -- Enable higher contrast text for darker style
            },

            disable = {
                colored_cursor = false, -- Disable the colored cursor
                borders = false,        -- Disable borders between verticaly split windows
                background = true,      -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
                term_colors = false,    -- Prevent the theme from setting terminal colors
                eob_lines = false,      -- Hide the end-of-buffer lines
            },

            lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

            async_loading = false,     -- Load parts of the theme asyncronously for faster startup (turned on by default)
        })

        vim.cmd("colorscheme material") -- after theme and before statusline
    end
}
