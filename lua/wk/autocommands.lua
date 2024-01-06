return {
    setup = function()
        local hl, c = require("wk/util").hl, require("wk/colors")
        local autocmd, au_group = vim.api.nvim_create_autocmd, vim.api.nvim_create_augroup

        autocmd("InsertEnter", {
            callback = function()
                hl("LineNrIcon", { fg = "#9ce8e7", bg = c.bg_mid_dark })
                hl("CursorLineNr", { fg = "#9ce8e7", bg = c.bg_mid_dark })
            end,
            group = au_group("InsArrow", { clear = true }),
        })
        autocmd("InsertLeave", {
            callback = function()
                hl("LineNrIcon", { fg = "#7777aa", bg = c.bg_mid_dark })
                hl("CursorLineNr", { fg = "#7777aa", bg = c.bg_mid_dark })
            end,
            group = au_group("InsLeaveArrow", { clear = true }),
        })

        ---------------- Highlight on yank
        autocmd("TextYankPost", {
            callback = function()
                vim.highlight.on_yank({ higroup = "Yank", timeout = 80, priority = 9999 })
            end,
            group = au_group("TextYankPost", { clear = true }),
        })

        -------------- New lines are not comments
        vim.cmd("set fo-=c fo-=r fo-=o")
        autocmd("BufEnter", {
            pattern = "*",
            command = "set fo-=c fo-=r fo-=o",
            group = au_group("newlines", { clear = true }),
        })
    end
}
