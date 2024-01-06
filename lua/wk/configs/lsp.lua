local M = {}

function M.config()
    local neodev = vim.F.npcall(require, "neodev")
    if neodev and (vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":e") == "lua") then
        neodev.setup()
    end

    local lsp_zero = require("lsp-zero")

    lsp_zero.on_attach(M.on_attach)
    lsp_zero.format_on_save({
        servers = {
            ["prettierd"] = { "scss", "css", "svelte", "ts", "tsx", "json", "gql" },
            ["lua_ls"] = { "lua" },
            ["clangd"] = { "c", "cpp", "h" },
            ["arduino_language_server"] = { "arduino" }
        },
    })

    require("mason").setup({})
    require("mason-lspconfig").setup({
        ensure_installed = {
            "rust_analyzer",
            "tsserver",
            "svelte",
            "eslint",
            "cssls",
            "ruby_ls",
            "lua_ls",
            "clangd",
            "arduino_language_server",
            "jsonls",
            -- "prettierd"
        },
        handlers = {
            lsp_zero.default_setup,
            arduino_language_server = function()
                local fqbn = "arduino:avr:nano"
                require("lspconfig").arduino_language_server.setup {
                    cmd = {
                        "arduino-language-server",
                        "-clangd", "/usr/bin/clangd",
                        "-cli", "/usr/bin/arduino-cli",
                        "-cli-config", "/home/weskeiser/.arduino15/arduino-cli.yaml",
                        "-fqbn",
                        fqbn
                    },
                    on_attach = M.on_attach,
                }
            end,
        },
    })

    vim.schedule(M.set_hl)
end

function M.set_hl()
    local c = require("wk/colors")
    local hl = require("wk/util").hl

    hl("LspDiagnosticError", { fg = c.red_error_light, bg = c.none })
    hl("LspDiagnosticWarn", { fg = c.yellow_warn })
    hl("LspDiagnosticHint", { fg = c.brown_dark })
    hl("LspDiagnosticInfo", { bg = c.bg_light })

    hl("@lsp.type.comment", { link = "Comment" })
    hl("@lsp.type.interface", { link = "Interface" })
    hl("@lsp.type.type", { link = "Type" })
    hl("@lsp.type.namespace", { link = "@namespace" })
    hl("@lsp.type.parameter", { link = "@parameter" })
    hl("@lsp.type.variable", { link = "@variable" })
    hl("@lsp.type.function", { link = "Function" })
    hl("@lsp.type.method", { link = "@method" })
    hl("@lsp.type.enum", { fg = c.orange_fun })
    hl("@lsp.type.enumMember", { fg = c.orange_fun })
    hl("@lsp.type.property", { link = "@property" })
end

function M.goto_error(gotoFn)
    local errors = vim.tbl_count(vim.diagnostic.get(0, { severity = "Error" }))
    if errors ~= 0 then
        return vim.diagnostic[gotoFn]({ severity = vim.diagnostic.severity.ERROR })
    end
    vim.diagnostic[gotoFn]()
end

function M.on_attach(_, bufnr)
    local lsp_zero = require("lsp-zero")
    lsp_zero.buffer_autoformat({ buffer = bufnr })

    local map, opts = vim.keymap.set, { buffer = bufnr, remap = false }
    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    map("n", "<leader>vrr", vim.lsp.buf.references, opts)
    map("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    map("n", "<leader>.", vim.lsp.buf.code_action, opts)

    map("n", "<leader><C-N>", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Lsp goto next diagnostic" })

    map("n", "<leader><C-P>", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Lsp goto prev diagnostic" })

    map("n", "<C-N>", function()
        M.goto_error("goto_next")
    end, { buffer = bufnr, desc = "Lsp goto next error" })

    map("n", "<C-P>", function()
        M.goto_error("goto_prev")
    end, { buffer = bufnr, desc = "Lsp goto prev error" })
end

-- require("luasnip").config.set_config({
-- 	region_check_events = "InsertEnter",
-- 	delete_check_events = "InsertLeave",
-- 	enable_autosnippets = true,
-- })

return M
