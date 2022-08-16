local c = {
  --bg = '#273145',
  bg = '#2c374e',
  --bg_dark = '#212a3b',
  bg_dark = '#273145',
  green_primary =  '#6da832',
  orange_primary =  '#f99157',
  bright_green = '#66FF00',
  light_grey = '#a6accd',
  dark_grey = '#313547',
  string_green = '#C3E88D',

}


local highlights = {
  -- Lsp
  Pmenu = { fg = '', bg = '#46577c' },

  -- Nvim Foreground and Background
  Normal = { bg = c.bg },
  NormalNC = { bg = c.bg_dark },

  -- Misc
  MatchParen = { fg = c.bright_green },
  IndentBlanklineContextChar = { fg = c.green_primary },
  IndentBlanklineContextStart = { fg = c.green_primary },
  IndentBlanklineChar = { fg = c.green_primary },

  -- Cursor and Line Number
  LineNr = {fg = c.green_primary},
  cursor = { fg = c.orange_primary, bg= c.green_primary},
  cursorLineNr = {fg = c.orange_primary  },

  -- Buffer
  BufferTabpageFill = { fg = c.dark_grey, bg = c.dark_grey },

  BufferCurrent = { fg =  c.orange_primary },
  BufferCurrentSign = { fg =  c.orange_primary },

  BufferVisible = {fg = c.light_grey, bg = c.bg_dark },
  BufferVisibleMod = { bg = c.bg_dark },
  BufferVisibleSign = { fg=c.dark_grey, bg = c.bg_dark },

  BufferInactive = {fg = c.light_grey, bg = c.dark_grey },
  BufferInactiveMod = { bg = c.dark_grey },
  BufferInactiveSign = { fg=c.dark_grey, bg = c.dark_grey },

  -- Tsx
  -- '#6b9474' - nice green
  --TSProperty = { fg = '#8c81d5' },
  TSProperty = { fg = '#A6ACCD' },
  Property = { fg = '#A6ACCD' },
  TSTagAttribute = { fg = '#A6ACCD' },
  TSParameter = { fg = '#95b0e9' },
  --TSType = { fg = '#FFCB6B' },
  TSTypeBuiltin = { fg = '#A6ACCD' },
  TSConditional = { fg = '#89DDFF' },
  TSConstMacro = { fg = '#C792EA' },
  TSOperator = { fg = '#C792EA' },
  Statement = { fg = '#C792EA' },
  TSVariable = { fg = '#95b0e9' },
  TSException = { fg = '#89DDFF' },
  --Tag = { fg = '#ffffff' },
  --Special = { fg = '#ffffff' },
  --jsonTSLabel = { fg = '#A6ACCD' },
  --jsonNoise = { fg = '#ffffff' },
  --Identifier = { fg = '#ffffff' },



  --TSPunctBracket = { fg = '#c8a679' },
  Identifier = { fg = '#a0afd9' },

  styledAmpersand = { fg = '#C792EA' },


  --typescriptIdentifierName = { fg = '#000000' },

--     tsxTSConstructor = { fg = '#ffffff' },

  --tsxTSMethod = { fg = '#ffffff' },

   --tsxTSPunctBracket = { fg = '#ffffff' },
   --tsxTSPunctDelimiter = { fg = '#ffffff' },
   --tsxTSConstructor = { fg = '#ffffff' },
   --tsxTSInclude = { fg = '#ffffff' },
   --tsxTSString = { fg = '#555555' },

  --C792EA
  --Identifier = { fg = '#F78C6C' }
  --TSParameter = { fg = '#ffffff' },
}

for k, v in pairs(highlights) do
  vim.api.nvim_set_hl(0, k, v)
end
