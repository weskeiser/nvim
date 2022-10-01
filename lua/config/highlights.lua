local c = {
  --bg = '#2b2b2c',
  bg = 'NONE',
  bg_light = '#353536',
  bg_lighter = '#494d5a',
  background = '#212122',
  white = '#ffffff',
  black = '#000000',
  -- green_primary =  '#6da832',
  green_primary =  '#91c360',
  orange_primary =  '#f99157',
  bright_green = '#66FF00',
  cursorline = '#494d5a',
  light_grey = '#a6accd',
  dark_grey = '#313547',
  string_green = '#C3E88D',
  cyan = '#92cfe8',
  --cyan = '#89DDFF',
  blue = '#749ffb',
  pink = '#dc78ed',
  blue_dark = '#243e61',
  blue_darker = '#273445',
  --const = '#CB7832',
  -- const = '#de7621',
  const = '#j26b24',
  const = '#a881bb',
  --variable = '#9774A8',
  -- variable = '#a881bb',
  -- variable = '#c47ee7',
  variable = '#6d7fc0',
  --variable = '#759ecc',
  variable = '#8499e7',
  string = '#688458',
  --property = '#969cbb',
  property = '#a3a4a8',
  --func = '#FEC56D',
  func = '#fec671',
  func = '#eeb259',
  func = '#6c84da',
  func = '#cb9543',
  func = '#95b7ea',
  identifier = '#a0afd9',
  bright_pink = '#EA68DB',
  bright_blue = '#00A2FF',
  bright_yellow = '#FFD100',
  bluish = '#303d55',
  yellow_error = '#FFCB6B',
  red_error = '#FF5370',
  funkygreen = '#18d18d',
}




local highlights = {
  -- Nvim Foreground and Background

  -- Normal = { bg = c.bg },
  -- NormalNC = { bg = c.bg },
  -- NormalFloat = { fg = '', bg = c.bg_light },
  Normal = { bg = NONE,  },
  NormalNC = { bg = NONE,  },
  NormalFloat = { bg = c.dark_grey,  },


  -- Cursor and Line Number
  LineNr = {fg = c.blue_dark},
  Cursor = { bg= c.funkygreen},
  CursorVisual = { bg = c.bright_green},
  CursorPending = { bg = c.white},
  cursorLineNr = {fg = c.orange_primary, bg = c.cursorline },
  cursorLine = { bg = c.cursorline },
  CursorLineSign = { bg = c.cursorline },


  -- Misc
  MatchParen = { fg = c.bright_green  },

  TreesitterContext = { bg =  c.bg_light},
  TreesitterContextLineNumber = { bg = c.bg_light, fg = c.orange_primary },





  Pmenu = { fg = '', bg = NONE },


  DiagnosticInformation = {  bg = c.bg_light },
  DiagnosticInfo = {  bg = c.bg_light },

  DiagnosticVirtualTextInfo = {  bg = c.bg_light },
  DiagnosticVirtualTextWarn = { fg = c.orange_primary, bg = c.bg_light },
  DiagnosticVirtualTextError = {  fg = c.red_error, bg = c.bg_light },
  DiagnosticVirtualTextHint = {  fg = c.yellow_error, bg = c.bg_light },

  DiagnosticSignInfo = {  bg = c.bg_light },
  DiagnosticSignError = {  fg = c.bg, bg = c.red_error },
  DiagnosticSignWarn = {  fg = c.bg, bg = c.orange_primary },
  DiagnosticSignHint = {  fg = c.black, bg = c.yellow_error },

  DiagnosticFloatingInfo = {  bg = c.bg_light },
  DiagnosticFloatingError = { fg = c.red_error, bg = c.bg_light },
  DiagnosticFloatingWarn = { fg = c.orange_primary, bg = c.bg_light },
  DiagnosticFloatingHint = { fg = c.yellow_error, bg = c.bg_light },

  --Conceal = { fg = "#757c9f" },




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

  -- EyelinerPrimary = { fg = c.white, underline = true },
  -- EyelinerSecondary = {  fg = c.bright_blue, underline = true },
}


for k, v in pairs(highlights) do
  vim.api.nvim_set_hl(0, k, v)
end


