local M = {}

function M.setup()
    vim.diagnostic.config({
        virtual_text = true,
        update_in_insert = true,
        severity_sort = true,
        signs = false,
    })

    vim.schedule(M.set_hl)
    vim.schedule(M.set_keymap)
end

function M.set_keymap()
    local map = vim.keymap.set

    map("n", "<leader>ad", function()
        if vim.diagnostic.is_disabled(0) then
            vim.diagnostic.enable(0)
        else
            vim.diagnostic.disable(0)
        end
    end)

    map("n", "<C-N>", vim.diagnostic.goto_next, { desc = "Goto next diagnostic" })
    map("n", "<C-P>", vim.diagnostic.goto_prev, { desc = "Goto prev diagnostic" })
end

function M.set_hl()
    local c = require("wk/colors")
    local hl = require("wk/util").hl

    hl("Error", { fg = c.red_error_light, bg = c.none, underline = true })
    hl("ErrorMsg", { link = "Error" })
    hl("@error", { link = "Error" })
    hl("WarningMsg", { link = "Error" })
    hl("NvimInternalError", { link = "Error" })
    hl("RedrawDebugRecompose", { link = "Error" })

    hl("DiagnosticHint", { fg = "#537383", bg = c.none, italic = true })
    hl("DiagnosticError", { fg = c.red_error_light, bg = c.none, italic = true })
    hl("DiagnosticWarn", { fg = c.yellow_warn, bg = c.none, italic = true })
    hl("DiagnosticInfo", { fg = "#336363", bg = c.none, italic = true })

    hl("DiagnosticVirtualTextHint", { fg = "#537383", bg = c.none, italic = true, underdotted = true })
    hl("DiagnosticVirtualTextInfo", { fg = "#538363", bg = c.none, italic = true, underdotted = true })

    hl("DiagnosticSignError", { fg = c.red_error_light, bg = c.none })
    hl("DiagnosticSignWarn", { fg = c.yellow_warn2, bg = c.none })
    hl("DiagnosticSignHint", { fg = c.brown_dark, bg = c.none })

    hl("DiagnosticVirtualTextError", { fg = c.red_error_light, bg = c.none })
    hl("DiagnosticUnderlineError", { underdotted = true, special = c.red_error_light })

    vim.cmd("hi DiagnosticUnderlineWarn cterm=underdotted gui=underdotted")
    vim.cmd("hi DiagnosticUnderlineInfo cterm=underdotted gui=underdotted guisp=#336363")
    vim.cmd("hi DiagnosticUnderlineHint cterm=underdotted gui=underdotted")
end

return M
