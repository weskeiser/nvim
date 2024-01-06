local map = vim.keymap.set
local hl = require("wk/util").hl
local c = require("wk/colors")

local rt = require("rust-tools")
rt.setup({
    server = {
        standalone = false,
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<leader>d", rt.hover_actions.hover_actions, { buffer = bufnr })
            vim.keymap.set("n", "<leader>.", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
    tools = { inlay_hints = { auto = false, }, },
})

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.rs",
    command = "silent !cargo fmt",
    group = vim.api.nvim_create_augroup("FormatSave", { clear = true }),
})


local rshl = function(k, opts)
    vim.api.nvim_set_hl(0, "@lsp." .. k .. ".rust", opts)
end

rshl("typemod.method.declaration", { fg = c.green_primary })
rshl("typemod.function.declaration", { fg = c.green_primary })
rshl("typemod.keyword.async", { link = "Keyword" })

rshl("mod.controlFlow", { fg = c.control_flow, italic = false })
rshl("mod.callable", { link = "Function" })
rshl("mod.documentation", { fg = "#555555" })
rshl("mod.documentation", { fg = c.documentation })

rshl("type.derive", { link = "Interface" })
rshl("type.selfKeyword", { fg = c.salmon2 })
rshl("type.attributeBracket", { fg = c.punct })
rshl("type.formatspecifier", { fg = c.fun2 })
rshl("type.lifetime", { fg = c.tag, italic = true })
rshl("type.parameter", { link = "@property" })

hl("@keyword.operator.rust", { link = "Type" })
hl("@type.qualifier.rust", { fg = c.keyword })

hl("rustSelf", { link = "@lsp.type.selfKeyword.rust" })
hl("rustSigil", { link = "Operator" })
hl("rustAssert", { link = "Macro" })
hl("rust9", { link = "Delimiter" })

map("n", "<leader>lr", ":!cargo ", { buffer = 0 })
map("n", "<c-p>", "[[")
map("n", "<c-n>", "]]")

map("n", "<leader>lh", function()
    local mut = vim.api.nvim_get_hl(0, { name = "@lsp.mod.mutable.rust" })
    if mut["underdotted"] ~= nil then
        vim.api.nvim_set_hl(0, "@lsp.mod.mutable.rust", { underdotted = false })
    else
        vim.api.nvim_set_hl(
            0,
            "@lsp.mod.mutable.rust",
            { underdotted = true, special = require("wk/colors").bluebrighter }
        )
    end

    local consuming = vim.api.nvim_get_hl(0, { name = "@lsp.mod.consuming.rust" })
    if consuming["bold"] ~= nil then
        vim.api.nvim_set_hl(0, "@lsp.mod.consuming.rust", { bold = false })
    else
        vim.api.nvim_set_hl(0, "@lsp.mod.consuming.rust", { bold = true })
    end
end, { desc = "Highlights for Mut and Consumable in Rust" })
