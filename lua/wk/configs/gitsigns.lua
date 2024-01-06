local M = {}

function M.config()
    require("gitsigns").setup({
        signcolumn = true,
        on_attach = M.on_attach,
        -- numhl = true,

        signs = {
            add = { text = "⏵" },
            change = { text = "⏵" },
            delete = { text = "◿" },
            topdelete = { text = "◹" },
            untracked = { text = "" },
        },

        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "right_align", -- 'eol' | 'overlay' | 'right_align'
            delay = 50,
            ignore_whitespace = false,
        },
    })

    M.set_highlight()
end

function M.on_attach(bufnr)
    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    local gs = package.loaded.gitsigns

    map("n", "]c", function()
        if vim.wo.diff then
            return "]c"
        end
        vim.schedule(function()
            gs.next_hunk()
        end)
        return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
        if vim.wo.diff then
            return "[c"
        end
        vim.schedule(function()
            gs.prev_hunk()
        end)
        return "<Ignore>"
    end, { expr = true })

    -- Actions
    map("n", "<leader>gs", gs.stage_hunk)
    map("v", "<leader>gs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("n", "<leader>gu", gs.undo_stage_hunk)

    map("n", "<leader>gr", gs.reset_hunk)
    map("v", "<leader>gr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
    end)

    map("n", "<leader>gS", gs.stage_buffer)
    map("n", "<leader>gR", gs.reset_buffer)

    map("n", "<leader>gP", gs.preview_hunk)
    map("n", "<leader>gp", gs.preview_hunk_inline)

    map("n", "<leader>gL", gs.toggle_current_line_blame)
    map("n", "<leader>gl", function()
        gs.blame_line({ full = true })
    end)

    map("n", "<leader>gw", gs.toggle_word_diff)
    map("n", "<leader>ghd", gs.diffthis)
    map("n", "<leader>ghD", function()
        gs.diffthis("~")
    end)

    map("n", "<leader>ga", function()
        gs.toggle_word_diff()
        gs.toggle_deleted()
    end, { desc = "Toggle word diff and deleted. Heuristic 'all'" })

    map("n", "<leader>gtd", gs.toggle_deleted)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>")
end

function M.set_highlight()
    local c = require("wk/colors")
    local hl = require("wk/util").hl

    hl("GitSignsDelete", { fg = c.red_error_light })
    hl("GitSignsChange", { fg = c.bluebright })
    hl("GitSignsAdd", { fg = "#6cc662", bold = false })

    hl("GitSignsDeleteVirtLn", { fg = c.red_error_light, bg = c.bg_mid_dark })
    hl("GitSignsDeletePreview", { fg = c.red, bg = c.bg_mid_dark })

    hl("GitSignsCurrentLineBlame", { fg = c.purple_pinkish })

    -- hl("GitSignsAddNr", { fg = c.green_sea })
end

return M
