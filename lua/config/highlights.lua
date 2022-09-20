local c = {
  --[[
  bg = '#303d55',
  green_primary =  '#6da832',
  orange_primary =  '#f99157',
  bright_green = '#66FF00',
  light_grey = '#a6accd',
  dark_grey = '#313547',
  string_green = '#C3E88D',
  cyan = '#92cfe8',
  --cyan = '#89DDFF',
  blue = '#749ffb',
  lightblue = '#8fb9f0',
  propblue = '#A6ACCD',
  pink = '#C792EA',
  variable = '#788fc2'

  ]]--

  bg = '#2b2b2c',
  bg_light = '#353536',
  bg_lighter = '#494d5a',
  background = '#212122',
  white = '#ffffff',
  green_primary =  '#6da832',
  orange_primary =  '#f99157',
  bright_green = '#66FF00',
  cursorline = '#494d5a',
  light_grey = '#a6accd',
  dark_grey = '#313547',
  string_green = '#C3E88D',
  cyan = '#92cfe8',
  --cyan = '#89DDFF',
  blue = '#749ffb',
  pink = '#C792EA',
  lightblue = '#8fb9f0',
  --const = '#CB7832',
  const = '#de7621',
  --variable = '#9774A8',
  variable = '#a88bb6',
  string = '#688458',
  --property = '#969cbb',
  property = '#b5b6ba',
  --func = '#FEC56D',
  func = '#fec671',
  identifier = '#a0afd9',
  bright_pink = '#EA68DB',
  bright_blue = '#00A2FF',
  bright_yellow = '#FFD100',
  bluish = '#303d55',
  yellow_error = '#FFCB6B',
  red_error = '#FF5370',
}


local highlights = {
  -- Lsp

  --[[
  CmpItemAbbrDeprecated = { bg=NONE, gui=strikethrough, fg='#808080' },
  CmpItemAbbrMatch = { bg=NONE, fg='#569CD6' },
  CmpItemAbbrMatchFuzzy = { bg=NONE, fg='#569CD6' },
  CmpItemKindVariable = { bg=NONE, fg='#9CDCFE' },
  CmpItemKindInterface = { bg=NONE, fg='#9CDCFE' },
  CmpItemKindText = { bg=NONE, fg='#9CDCFE' },
  CmpItemKindFunction = { bg=NONE, fg='#C586C0' },
  CmpItemKindMethod = { bg=NONE, fg='#C586C0' },
  CmpItemKindKeyword = { bg=NONE, fg='#D4D4D4' },
  CmpItemKindProperty = { bg=NONE, fg='#D4D4D4' },
  CmpItemKindUnit = { bg=NONE, fg='#D4D4D4' },
  ]]--

  Pmenu = { fg = '', bg = c.bg_light },


  DiagnosticInformation = {  bg = c.bg_light },
  DiagnosticInfo = {  bg = c.bg_light },

  DiagnosticVirtualTextInfo = {  bg = c.bg_light },
  DiagnosticVirtualTextWarn = { fg = c.orange_primary, bg = c.bg_light },
  DiagnosticVirtualTextError = {  fg = c.red_error, bg = c.bg_light },
  DiagnosticVirtualTextHint = {  fg = c.yellow_error, bg = c.bg_light },

  DiagnosticSignInfo = {  bg = c.bg_light },
  DiagnosticSignError = {  fg = c.bg, bg = c.red_error },
  DiagnosticSignWarn = {  fg = c.bg, bg = c.orange_primary },
  DiagnosticSignHint = {  fg = c.bg, bg = c.yellow_error },

  DiagnosticFloatingInfo = {  bg = c.bg_light },
  DiagnosticFloatingError = { fg = c.red_error, bg = c.bg_light },
  DiagnosticFloatingWarn = { fg = c.orange_primary, bg = c.bg_light },
  DiagnosticFloatingHint = { fg = c.yellow_error, bg = c.bg_light },

  Conceal = { fg = "#757c9f" },



  -- Nvim Foreground and Background
  Normal = { bg = c.bg },
  NormalNC = { bg = c.bg },
  NormalFloat = { fg = '', bg = c.bg_light },

  -- Misc
  MatchParen = { fg = c.bright_green  },

  -- Cursor and Line Number
  LineNr = {fg = c.green_primary},
  cursor = { fg = c.orange_primary, bg= c.green_primary},
  cursorLineNr = {fg = c.orange_primary, bg = c.bg },
  cursorLine = { bg = c.cursorline },



  -- Buffer
  BufferTabpageFill = { fg = c.dark_grey, bg = c.dark_grey },

  BufferCurrent = { fg =  c.orange_primary },
  BufferCurrentSign = { fg =  c.orange_primary },

  BufferVisible = {fg = c.light_grey, bg = c.background },
  BufferVisibleMod = { bg = c.background },
  BufferVisibleSign = { fg=c.dark_grey, bg = c.background },

  BufferInactive = {fg = c.light_grey, bg = c.dark_grey },
  BufferInactiveMod = { bg = c.dark_grey },
  BufferInactiveSign = { fg=c.dark_grey, bg = c.dark_grey },

  -- Tsx
  TSProperty = { fg = c.property },
  Property = {fg = c.property },
  TSTagAttribute = {fg = c.property },
  TSTypeBuiltin = {fg = c.property },
  Statement = { fg = c.const },
  TSConstMacro = { fg = c.const },

  TSVariable = { fg = c.variable },
  TSParameter = { fg = c.variable },
  TSConstant = { fg = c.variable },

  TSRepeat = { fg = c.variable },

  TSPunctDelimiter = { fg = c.func },
  TSTag = { fg = c.func },

  TSInclude = { fg = c.const },
  TSURI = { fg = c.const },
  TSInclude = { fg = c.const },
  TSKeywordReturn = { fg = c.const },
  TSPunctSpecial = { fg = c.identifier },
  TSStorageClass = { fg = c.identifier },
  TSException = { fg = c.identifier },
  TSConditional = { fg = c.identifier },
  TSEnvironment = { fg = c.identifier },
  TSOperator = { fg = c.identifier },
  TSPunctBracket = { fg = c.const },
  TSTagDelimiter = { fg = c.const },

  TSString = { fg = c.green_primary },

  Identifier = { fg = c.identifier },
  --TSText = { fg = c.identifier },
  --TSNone = { fg = c.identifier },

  TSType = { fg = c.pink},
  TSTypeBuiltin = { fg = c.pink },


  TSMethod = { fg = c.func },
  TSMath = { fg = c.func },
  TSFunction = { fg = c.func },
  TSFuncMacro = { fg = c.func },
  TSMethodCall = { fg = c.func },
  TSConstructor = { fg = c.func },
  TSFuncBuiltin = { fg = c.func },
  --Tag = { fg = '#ffffff' },
  --Special = { fg = '#ffffff' },
  --jsonTSLabel = { fg = '#A6ACCD' },
  --jsonNoise = { fg = '#ffffff' },

}


for k, v in pairs(highlights) do
  vim.api.nvim_set_hl(0, k, v)
end
