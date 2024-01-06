local M = {}

function M.config()
    local cmp = require("cmp")

    cmp.event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())

    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
        mapping = cmp.mapping.preset.insert({
            ["<CR>"] = nil,
            ["<Tab>"] = nil,

            ["<C-d>"] = cmp.mapping.select_next_item({ cmp_select, count = 4 }),

            ["<C-y>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() then
                        cmp.confirm({ select = true })
                    else
                        fallback()
                    end
                end,
                s = cmp.mapping.confirm({ select = true }),
                c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
            }),

            ["<C-u>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.get_active_entry() then
                        cmp.select_prev_item({ cmp_select, count = 4 })
                    else
                        fallback()
                    end
                end,
            }),
        }),

        snippet = {
            expand = function(args)
                -- vim.fn["vsnip#anonymous"](args.body)
                require("luasnip").lsp_expand(args.body)
            end,
        },

        completion = {
            completeopt = "menu,menuone,noinsert",
        },

        formatting = {
            formatting = require("lsp-zero").cmp_format(),
        },

        sources = {
            { name = "path" },
            { name = "nvim_lsp" },
            -- { name = "nvim_lsp_signature_help" },
            { name = "nvim_lua", keyword_length = 2 },
            { name = "buffer" },
            -- { name = "vsnip", keyword_length = 2 },
            { name = "luasnip",  keyword_length = 2 },
            -- { name = "vim-dadbod-completion" },
        },

        window = {
            documentation = {
                border = "rounded",
            },
            completion = {
                col_offset = -1,
                max_width = 30,
                scrolloff = 8,
            },
        },
    })

    M.highlight()
end

function M.highlight()
    local c = require("wk/colors")
    local hl = require("wk/util").hl

    -- Cmp (also affected by Pmenu)
    hl("CmpItemMenu", { fg = c.green_identifier })

    hl("CmpItemAbbrMatch", { fg = c.green_identifier })
    -- hl("CmpItemAbbrMatchFuzzy", { fg = c.bg_mid_dark, blend = 5 })
    hl("CmpItemAbbrDeprecated", { fg = "#808080" })

    hl("CmpItemKindClass", { link = "Function" })
    hl("CmpItemKindConstant", { fg = c.const })
    hl("CmpItemKindEnum", { link = "@lsp.type.enum" })
    hl("CmpItemKindEnumMember", { link = "@lsp.type.enumMember" })
    hl("CmpItemKindField", { link = "@identifier" })
    hl("CmpItemKindFunction", { link = "Function" })
    hl("CmpItemKindInterface", { link = "Interface" })
    hl("CmpItemKindKeyword", { link = "Keyword" })
    hl("CmpItemKindMethod", { link = "@method", bold = true })
    hl("CmpItemKindModule", { fg = c.documentation, bold = true })
    hl("CmpItemKindProperty", { link = "@property" })
    hl("CmpItemKindReference", { link = "Comment" })
    hl("CmpItemKindStruct", { link = "Structure" })
    hl("CmpItemKindText", { link = "@identifier" })
    hl("CmpItemKindVariable", { link = "@variable" })
end

return M
