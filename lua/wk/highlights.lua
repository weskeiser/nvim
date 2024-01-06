return {
    setup = function()
        local c = require("wk/colors")
        local hl = require("wk/util").hl

        -- -- Misc
        hl("Normal", { bg = c.bg })
        hl("NormalNC", { bg = c.bg_darker })
        hl("ModeMsg", { fg = c.white })
        hl("MsgArea", { fg = "#666666", bg = c.bg_mid_dark })
        hl("WinSeparator", { fg = c.bg_mid_dark, bg = c.bg_mid_dark })
        hl("SignColumn", { bg = c.bg })
        hl("None", { bg = c.none })
        hl("NonText", { fg = "#515772" })
        -- hl("VertSplit", { fg = c.bg_darker, bg = c.bg_darker })
        -- hl("ScrollBar", { fg = c.bg_darker, bg = c.red })
        -- hl("EndOfBuffer", { link = "StatusLine" })

        hl("Search", { fg = "#aaaaaa", bg = "#656060", bold = true })
        hl("IncSearch", { fg = "#ffffff", bg = "#656060", bold = true })
        hl("CurSearch", { fg = "#ffffff", bg = "#656060", bold = true })
        hl("MatchParen", { fg = c.white, bg = c.none, bold = true })

        hl("Yank", { bg = "#444267", fg = c.white })
        hl("Title", { link = "Identifier" })
        hl("Todo", { fg = c.funkygreen })

        -- CURSOR
        hl("Cursor", { bg = "#7777aa", fg = c.bg })
        hl("CursorReplace", { bg = c.cursor_replace })
        hl("CursorInsert", { bg = "#9ce8e7", })
        hl("CursorVisual", { bg = c.cursor_visual })
        hl("CursorPending", { bg = c.cursor_pending })

        hl("CursorLine", { bg = c.none })
        -- hl("CursorLine", { bg = c.cursorline })
        hl("CursorColumn", { bg = c.cursorline })
        -- hl("CursorLineSign", { bg = c.cursorline })

        --  LINE NUMBER
        -- hl("LineNrIcon", { fg = "#5ebeb8", bg = c.bg_mid_dark })
        -- hl("LineNr", { fg = c.cyan, bg = c.bg_mid_dark })
        hl("LineNrIcon", { fg = "#7777aa", bg = c.bg_mid_dark })
        hl("LineNr", { fg = "#7777aa", bg = c.bg_mid_dark })
        hl("LineNrAbove", { fg = "#995107", bg = c.bg_mid_dark })
        hl("LineNrBelow", { fg = "#4d7802", bg = c.bg_mid_dark })
        hl("CursorLineNr", { fg = "#7777aa", bg = c.bg_mid_dark })
        -- hl("CCSpill", { fg = "#555555", bg = c.bg })
        hl("CLineCurr", { fg = c.orange_secondary, bg = c.bg })

        hl("ScrollBar", { fg = "#5ebeb8", bg = c.bg_mid_dark })
        hl("ScrollBarModified", { fg = "#ffdd00", bg = c.bg_mid_dark })


        -- FOLDS
        hl("FoldColumn", { bg = c.cursorline })
        hl("MoreMsg", { bg = c.bg_darker, fg = c.string })

        hl("htmlLink", { fg = c.yellow_text })
        hl("Delimiter", { fg = c.operator })

        -- PMENU
        hl("Pmenu", { bg = "#37383f" })
        hl("PmenuSbar", { bg = "#37383f" })
        hl("PmenuThumb", { bg = "#555a65" })
        hl("PmenuSel", { bg = "#47484f" })

        -- PROG
        hl("Comment", { fg = "#666666" })
        hl("Macro", { fg = c.fun2, italic = true })
        hl("Special", { fg = c.cyan })

        hl("Conditional", { fg = c.control_flow })

        -- hl("Keyword", { fg = c.purple_next3, italic = true })
        -- hl("Keyword", { fg = "#ccacac", italic = true })
        hl("Keyword", { fg = "#ab8b8b", italic = true })
        hl("@keyword", { link = "Keyword" })
        hl("Include", { link = "Keyword" })

        hl("@punctuation", { link = "Keyword" })
        hl("@punctuation.delimiter", { fg = c.punct })
        hl("@punctuation.bracket", { fg = c.punct, bold = false })

        hl("Operator", { fg = c.operator })
        -- hl("Operator", { fg = "#3e7e98" })

        hl("String", { fg = c.green_soft })
        hl("@string", { link = "String" })
        hl("@string.regex", { link = "String" })
        hl("@string.special", { fg = c.bluebright })
        hl("@string.escape", { fg = "#767676" })

        hl("Boolean", { fg = "#a54d19" })
        hl("@boolean", { link = "Boolean" })

        hl("Number", { fg = c.orange_number })
        hl("@number", { link = "Number" })
        hl("@float", { link = "Number" })

        hl("@variable", { fg = c.identifier })
        hl("@variable.builtin", { link = "@variable" })
        hl("Constant", { fg = c.green_cool2 })
        hl("@type.qualifier.constant", { link = "Keyword" })
        hl("@constant", { link = "Constant" })
        hl("@constant.builtin", { link = "@variable" })

        -- hl("@lsp.type.enum", { link = "Type" })
        hl("@lsp.type.enum", { fg = c.green_deep })
        hl("@lsp.type.enumMember", { link = "@property" })

        hl("Function", { fg = c.fun2 })
        hl("@method", { fg = c.fun2 })
        hl("@parameter", { link = "@variable" })

        hl("@constructor", { link = "Function" })
        -- hl("@lsp.type.class", { fg = c.orange_smooth })

        hl("@property", { fg = c.blue_nice })
        hl("@field", { link = "Property" })

        hl("StorageClass", { fg = c.tag })

        hl("@punctuation", { fg = c.green_primary })

        -- hl("Interface", { fg = "#af8c71" })
        hl("Interface", { fg = c.interface })
        hl("Structure", { fg = c.greenie })
        -- hl("Type", { fg = c.green_idk })
        -- hl("Type", { fg = c.interface })
        -- hl("Type", { fg = "#ab8b8b" })
        hl("Type", { fg = "#6da832" })
        -- hl("Type", { fg = "#aa8771" })
        hl("@type", { link = "Type" })
        hl("@type.builtin", { link = "Type" })
        -- hl("@type.qualifier", { link = "@operator" })
        hl("@type.qualifier", { link = "StorageClass" })

        hl("@keyword.return", { fg = c.green_ooo })
        hl("@keyword.coroutine", { fg = c.green_ooo })
        hl("@repeat", { fg = c.control_flow })
        hl("@exception", { fg = c.control_flow })
        hl("@Special", { link = "Special" })
        hl("@label", { fg = c.testtt })
        -- hl("@text.title", { fg = "#cfcfcf" })
        -- hl("@text.title", { link = "@label" })
        hl("@text.title", { link = "@keyword" })

        hl("@function.builtin", { link = "Function" })

        hl("@namespace", { link = "@property" })
        hl("@tag", { fg = c.tag })

        -- hl("@null", { fg = c.tag })
        -- hl("@punctuation.special", { link = "Punctuation" })
        -- hl("@tag.delimiter", { fg = c.cyan })
        -- hl("@method.call", { link = "Function" })
        -- hl("@function.call", { link = "Function" })
        -- hl("@tag.attribute", { link = "Identifier" })

        -- ----------------------- Typescript / React

        hl("@tag.attribute.tsx", { link = "Identifier" })
        hl("@constructor.tsx", { link = "@tag" })
        hl("@tag.delimiter.tsx", { link = "Delimiter" })
        hl("@punctuation.special.tsx", { link = "@punctuation" })
        -- -- hl("@punctuation.bracket", { link = "Identifier" })
        -- hl("@type.tsx", { link = "Type" })
        -- hl("@lsp.type.type.typescriptreact", { link = "Type" })
        -- hl("@lsp.type.interface.typescriptreact", { link = "Type" })
        -- hl("@lsp.type.property.typescriptreact", { link = "@property" })
        -- hl("@lsp.type.function.typescriptreact", { link = "@method" })
        -- hl("@lsp.typemod.property.declaration.typescript", { link = "Identifier" })
        -- hl("@lsp.typemod.property.declaration.typescriptreact", { link = "Identifier" })
        -- hl("@lsp.typemod.interface.declaration.typescriptreact", { link = "Identifier" })
        -- hl("@lsp.typemod.function.declaration.typescriptreact", { link = "Function" })
        -- -- hl("@lsp.typemod.function.readonly.typescriptreact", {link = "Function"})
        -- -- hl("@lsp.typemod.function.local.typescriptreact", {link = "@method"})

        -- Markdown
        hl("markdownYamlHead", { fg = c.bluebright })
        hl("yamlPlainScalar", { link = "@variable" })
        hl("yamlKeyValueDelimiter", { link = "Operator" })
        hl("yamlBlockMappingKey", { link = "@label" })
        hl("markdownListMarker", { fg = c.bluebright })
        hl("markdownLinkText", { fg = c.funkygreen })

        hl("markdownH1", { fg = c.testtt })
        hl("markdownH1Delimiter", { fg = c.testtt })
        hl("markdownH2", { fg = c.testtt })
        hl("markdownH3", { fg = c.testtt })
        hl("markdownH4", { fg = c.testtt })
        hl("markdownH5", { fg = c.testtt })
        hl("markdownH6", { fg = c.testtt })
        hl("markdownUrl", { link = "htmlLink" })

        -- hl("@spell", { fg = "#b9ac50" })
        hl("@spell", { link = "Comment" })
        hl("@text.literal.markdown_inline", { fg = "#cc8771" })
        hl("@text.literal.block.markdown", { link = "@variable" })
        hl("@text.literal", { link = "@variable" })

        hl("@text.title.1.marker.markdown", { fg = c.brown_light })
        hl("@text.title.2.marker.markdown", { fg = c.brown_light })
        -- hl("@text.todo.unchecked.markdown", { fg = c.funkygreen, italic = true })

        hl("DevIconPng", { fg = c.green_soft })

        -- Diff
        hl("DiffAdd", { bg = c.git_add })
        hl("diffAdded", { bg = c.git_add })

        hl("DiffChange", { bg = "#303039" })
        hl("DiffText", { bg = c.git_add })

        hl("DiffDelete", { bg = "#363030", fg = c.bg })
        -- hl("diffRemoved", { fg = c.brown })

        -- -- Diff
        -- hl("DiffAdd", { bg = "#3c433c" })
        -- hl("DiffChange", { bg = "#3c3c42" })
        -- hl("DiffText", { bg = "#3c3c42" })
        -- hl("DiffDelete", { bg = "#4f3a39", fg = c.bg })
        -- hl("diffRemoved", { fg = c.brown, bg = c.bg_mid_dark })

        -- Sql
        hl("sqlKeyword", { fg = c.orange_java })
        hl("sqlSpecial", { fg = c.tag })
        hl("sqlOperator", { fg = c.beige })
        hl("sqlStatement", { fg = c.orange_java })
        hl("sqlString", { link = "String" })

        -- XML
        hl("xmlTagName", { fg = c.tag })
        hl("xmlTag", { fg = c.cyan })

        hl("Yellow", { fg = c.yellow })
        hl("Cyan", { fg = c.cyan })
    end
}
