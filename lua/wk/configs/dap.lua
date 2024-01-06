local M = {}

function M.config()
    local dap_status_ok, dap = pcall(require, "dap")
    if not dap_status_ok then
        return vim.notify("Dap failed to initiate")
    end

    M.setup_dapui()
    M.setup_dap_vscode_js()

    vim.schedule(M.set_highlight)
    vim.schedule(M.set_keymap)

    dap.defaults.fallback.focus_terminal = true

    vim.api.nvim_create_autocmd("BufWinEnter", {
        pattern = { "\\[dap-repl\\]", "*DAP*" },
        callback = function()
            vim.wo.statusline = ""
            vim.wo.wrap = true
            vim.wo.linebreak = false
        end,
        group = vim.api.nvim_create_augroup("dap", { clear = true }),
    })

    -- require("nvim-dap-virtual-text").setup()
end

function M.setup_dapui()
    local dap_ui_status_ok, dapui = pcall(require, "dapui")
    if not dap_ui_status_ok then
        return vim.notify("Dap-ui failed to initiate")
    end

    dapui.setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        expand_lines = vim.fn.has("nvim-0.7") == 1,
        windows = { indent = 1 },
        render = {
            max_type_length = nil,
        },
    })

    require("dap").listeners.after.event_initialized["dapui_config"] = dapui.open
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapUIBreakpointsPath", linehl = "", numhl = "" }) --
end

function M.setup_dap_vscode_js()
    local dap_vscode_js_status_ok, dap_vscode_js = pcall(require, "dap-vscode-js")

    if not dap_vscode_js_status_ok then
        return vim.notify("Dap adapter for vscode-js failed to initiate")
    end

    dap_vscode_js.setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    })

    for _, language in ipairs({ "typescript", "javascript", "svelte" }) do
        require("dap").configurations[language] = {
            -- -- config goes here
            -- ...
            {
                -- use nvim-dap-vscode-js's pwa-node debug adapter
                type = "pwa-node",
                -- attach to an already running node process with --inspect flag
                -- default port: 9222
                port = 9229,
                request = "attach",
                -- allows us to pick the process using a picker
                processId = require("dap.utils").pick_process,
                -- name of the debug action
                name = "Attach debugger to existing `node --inspect` process",
                -- for compiled languages like TypeScript or Svelte.js
                sourceMaps = true,
                -- resolve source maps in nested locations while ignoring node_modules
                resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
                -- path to src in vite based projects (and most other projects as well)
                cwd = "${workspaceFolder}/src",
                -- we don't want to debug code inside node_modules, so skip it!
                skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
            },
            {
                type = "pwa-chrome",
                name = "Launch Chrome to debug client",
                request = "launch",
                url = "http://localhost:5173",
                sourceMaps = true,
                protocol = "inspector",
                port = 9222,
                webRoot = "${workspaceFolder}/src",
                -- skip files from vite's hmr
                skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
            },
            -- only if language is javascript, offer this debug action
            language == "javascript"
            and {
                -- use nvim-dap-vscode-js's pwa-node debug adapter
                type = "pwa-node",
                -- launch a new process to attach the debugger to
                request = "launch",
                -- name of the debug action you have to select for this config
                name = "Launch file in new node process",
                -- launch current file
                program = "${file}",
                cwd = "${workspaceFolder}",
            }
            or nil,
        }
    end
end

function M.set_keymap()
    local dap = require("dap")
    local dapui = require("dapui")
    local function dapRestart()
        dap.terminate({}, {}, dap.continue)
    end

    local function endAndClose()
        dap.terminate()
        dapui.close()
    end

    local function map(mapping, action)
        vim.keymap.set("n", table.concat({ "<leader>", mapping }), action)
    end

    map("da", dapui.toggle)
    map("dl", dapRestart)
    map("dp", dap.run_last)

    map("dc", dap.continue)
    map("do", dap.step_over)
    map("di", dap.step_into)
    map("db", dap.step_out)

    map("dr", dap.repl.toggle)
    map("dd", dap.toggle_breakpoint)

    map("dq", endAndClose)
end

function M.set_highlight()
    local c = require("wk/colors")
    local hl = require("wk/util").hl

    hl("DapUIWatchesEmpty", { fg = c.blue_null })
    hl("DapUISource", { link = "@property" })
    hl("DapUILineNumber", { link = "LineNr" })
    hl("DapUIBreakpointsCurrentLine", { fg = c.green_primary })
    hl("DapUIBreakpointsPath", { fg = c.orange_faded })
    hl("DapUIStoppedThread", { fg = c.orange_faded })
    hl("DapUIScope", { fg = c.blue_null })
    hl("DapUIType", { link = "Type" })
end

return M
