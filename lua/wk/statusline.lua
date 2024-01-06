local M = {}

function M.setup()
    local api = vim.api

    M.set_hl()

    vim.g.status_screen_col = 1

    _G.Get_winbar = M.Get_winbar
    _G.Get_tabline = M.Get_tabline
    _G.Get_statusline = M.Get_statusline

    vim.o.winbar = "%{%v:lua.Get_winbar()%}"
    vim.o.statusline = "%{%v:lua.Get_statusline()%}"
    vim.o.tabline = "%{%v:lua.Get_tabline()%}"

    vim.o.showtabline = 2
    vim.opt.laststatus = 3

    api.nvim_create_autocmd({ "CursorMoved", "CmdlineChanged" }, {
        callback = function()
            local fn, cmd = vim.fn, vim.cmd
            local sc = fn.screenpos(0, fn.line(".") or 1, fn.col(".") or 1).col or 1
            vim.g.status_screen_col = sc - 1
            vim.schedule(cmd.redrawtabline)
            vim.schedule(cmd.redrawstatus)
        end,
        group = vim.api.nvim_create_augroup("freshstatus", { clear = true }),
    })

    api.nvim_create_autocmd({ "DiagnosticChanged" }, {
        callback = function() vim.schedule(vim.cmd.redrawstatus) end,
        group = api.nvim_create_augroup("diagstatus", { clear = true }),
    })
end

function M.Get_tabline()
    return table.concat({
        "%#Tabline#%-6( %S%)",
        string.rep(" ", vim.g.status_screen_col - 6),
        "%*%#StatusLineCol#🭭 %#CursorLineNr#%-2c%#Tabline#",
    })
end

function M.Get_statusline()
    return table.concat({
        string.rep(" ", vim.g.status_screen_col),
        "%#StatusLineCol#🭯 %#CursorLineNr#%-2c%#TabLine#",
    })
end

function M.Get_winbar()
    local path = vim.fn.expand("%")

    if path:find("NvimTree") then
        return "%#StatusLine#"
    end

    if path:find("fugitive") then
        return table.concat({ "%#StatusLineBrownBg# ", path, "%#StatusLine#" })
    end

    return table.concat({
        M.show_modified(),
        M.pretty_path(path),
        M.show_macros(),
        "%{%v:lua.SvopStatus()%} ", -- vim.b["svopstatus"],
        M.git_status,
        M.lsp_errors(),
        "%=",
        M.show_tabs(),
    })
end

M.git_status = "%#StatusLineGit#[Head: %{get(b:,'gitsigns_head','')}] "

function M.get_pos()
    return table.concat({
        "%#StatusLineGreyed#",
        vim.fn.line("."),
        "%#StatusLineGreyed2#─%#StatusLineGreyed#%L%#StatusLineGreyed2#│",
        vim.fn.col("."),
        " ",
    })
end

function M.pretty_path(path)
    local dir = vim.fn.fnamemodify(path, ":~:.:h")
    if dir == "." then
        dir = ""
    else
        dir = table.concat({ dir, "/" })
    end
    return table.concat({
        M.show_icon(path),
        "%#StatusLineDir#",
        dir,
        "%#StatusLineFilename#%t ",
    })
end

M.tab_nums = { "❶", "❷", "❸", "❹", "❺", "❻" }


function M.show_tabs()
    local api, fn = vim.api, vim.fn
    if vim.fn.winnr() ~= fn.winnr("$") then
        return ""
    end

    local tabs = api.nvim_list_tabpages()

    if #tabs < 2 then
        return ""
    end


    local tabline

    for _, tab in ipairs(tabs) do
        local win = api.nvim_tabpage_get_win(tab)

        local filepathColor = win == api.nvim_get_current_win() and "%#StatusLineLightGrey#"
            or "%#StatusLineLighterGrey#"

        tabline = table.concat({ " ", filepathColor, M.tab_nums[tab],
                fn.fnamemodify(api.nvim_buf_get_name(api.nvim_win_get_buf(win)), ":~:.:t"), "%#StatusLine#" },
            " ")
    end

    return tabline
end

M.icon_cache = {}

function M.get_icon(filename)
    filename = filename or vim.fn.expand("%:t")

    if not M.icon_cache[filename] then
        local file_icon, hl_group = require("nvim-web-devicons").get_icon(filename, _, { default = true })

        M.icon_cache[filename] = table.concat({ " %#", hl_group, "#", file_icon, "%* " })
    end

    return M.icon_cache[filename]
    -- local icon, color = require'nvim-web-devicons'.get_icon_color("init.lua", "lua")
end

function M.show_icon(filename)
    return vim.F.npcall(M.get_icon, filename) or ""
end

function M.show_modified()
    return vim.bo.modified and "%#StatusLineYellowBold#[]" or "   "
end

function M.show_macros()
    local recording = vim.fn.reg_recording()

    if #recording > 0 then
        recording = table.concat({ "%#StatusLineMacro# RECORDING MACRO [ ", recording, " ]" })
    end

    return recording
end

function M.lsp_errors()
    local type = { "Error", "Warn", "Hint", "Info", }
    local display = { "", "", "", "" }

    for i, t in ipairs(type) do
        local error_count = vim.tbl_count(vim.diagnostic.get(0, { severity = t }))

        if error_count > 0 then
            display[i] = table.concat({ " %#Winbar", t, "#", error_count })
        end
    end

    return table.concat(display)
end

function M.set_hl()
    local c = require("wk.colors")
    local hl = require("wk.util").hl
    local bg = c.bg_mid_dark

    hl("StatusLine", { bg = bg })
    hl("StatusLineNC", { bg = bg, fg = c.white })
    hl("StatusLineGit", { fg = "#5f4f57", bg = bg })
    hl("StatusLineNr", { fg = "#7777aa", bg = bg })
    hl("StatusLineFilename", { fg = c.green_soft, bg = bg })
    hl("StatusLineDir", { fg = "#98a9a8", bg = bg })
    hl("StatusLineMacro", { fg = c.red_bright, bg = bg })
    hl("StatusLineLighterGrey", { fg = c.lighter_grey, bg = bg })
    hl("StatusLineLightGrey", { fg = c.light_grey2, bg = bg })
    hl("StatusLineYellowBold", { fg = "#ffdd00", bg = bg, bold = true })
    hl("StatusLineGreenSoft", { fg = c.green_soft, bg = bg })
    hl("StatusLineGreyed", { fg = "#555555", bg = bg })
    hl("StatusLineGreyed2", { fg = "#333333", bg = bg })
    hl("StatusLineLnrTotal", { fg = c.green_soft, bg = bg })
    hl("StatusLineLnr", { fg = "#70d070", bg = bg })
    hl("StatusLineBrownBg", { fg = c.white, bg = c.brown })
    hl("StatuslineBrown", { fg = c.brown_light, bg = bg })
    hl("StatuslineCol", { fg = c.cyan, bg = bg })
    hl("Red", { fg = c.red, bg = c.red })

    hl("TabLine", { link = "StatusLine" })

    hl("WinBar", { link = "StatusLine" })
    hl("WinBarNC", { link = "StatusLineNC" })

    hl("WinbarError", { fg = c.red_bright, bg = bg })
    hl("WinbarWarn", { fg = c.yellow_bright, bg = bg })
    hl("WinbarHint", { fg = "#5373a3", bg = bg })
    hl("WinbarInfo", { fg = "#336363", bg = bg })

    hl("NvimTreeTitle", { fg = "#a9ca76", bg = c.bg_even_darker })
end

----------------------------------------------------------------------------------

-- M.git_status = "%#StatusLineGreyed#[Head: %{get(b:,'gitsigns_head','')}] "

-- local function get_mode_color()
-- 	local current_mode = vim.api.nvim_get_mode().mode
-- 	local mode_color = "%#LineNrTotal#"
--
-- 	if current_mode == "i" then
-- 		mode_color = "%#WhiteFG#"
-- 		-- elseif current_mode == "c" then
-- 		-- 	mode_color = "%#Funkygreen#"
-- 	end
--
-- 	return mode_color
-- end

-- Mode colors

-- cmd("hi StatusLineInsert guifg=" .. c.dark_grey .. " guibg=" .. c.eggwhite)
-- cmd("hi StatusLineVisual guifg=" .. c.dark_grey .. " guibg=" .. c.bright_green)
-- cmd("hi StatusLineCmdLine guifg=" .. c.orange_strong .. " guibg=" .. c.orange_faded)
-- cmd("hi StatuslineTerminal guifg=" .. c.orange_strong .. " guibg=" .. c.orange_faded)

-- local function updateColors()
-- 	local current_mode = vim.api.nvim_get_mode().mode
-- 	local mode_color = "%#StatusLineOrangeBg#"
--
-- 	if current_mode == "n" then
-- 		mode_color = "%#StatusLineOrangeBg#"
-- 	elseif current_mode == "i" or current_mode == "ic" then
-- 		mode_color = "%#StatuslineInsert#"
-- 	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
-- 		mode_color = "%#StatuslineVisual#"
-- 	elseif current_mode == "c" then
-- 		mode_color = "%#StatuslineCmdLine#"
-- 	elseif current_mode == "t" then
-- 		mode_color = "%#StatuslineTerminal#"
-- 	end
--
-- 	return mode_color
-- end

-- vim.api.nvim_exec(
-- 	[[
--   augroup Statusline
--   au!
--   au WinEnter,BufEnter,FocusGained * setlocal statusline=%!v:lua.Statusline.active()
--   au WinLeave,BufLeave,FocusLost * setlocal statusline=%!v:lua.Statusline.inactive()
--   au WinEnter,BufEnter,FileType NvimTree_1 setlocal statusline=%!v:lua.Statusline.nvim_tree()
--   au FocusLost * setlocal statusline=%!v:lua.Statusline.inactive()
--   augroup END
-- ]],
-- 	false
-- )

-- local modes = {
-- 	["n"] = "NORMAL",
-- 	["no"] = "NORMAL",
-- 	["v"] = "VISUAL",
-- 	["V"] = "VISUAL LINE",
-- 	[""] = "VISUAL BLOCK",
-- 	["s"] = "SELECT",
-- 	["S"] = "SELECT LINE",
-- 	[""] = "SELECT BLOCK",
-- 	["i"] = "INSERT",
-- 	["ic"] = "INSERT",
-- 	["R"] = "REPLACE",
-- 	["Rv"] = "VISUAL REPLACE",
-- 	["c"] = "COMMAND",
-- 	["cv"] = "VIM EX",
-- 	["ce"] = "EX",
-- 	["r"] = "PROMPT",
-- 	["rm"] = "MOAR",
-- 	["r?"] = "CONFIRM",
-- 	["!"] = "SHELL",
-- 	["t"] = "TERMINAL",
-- }

-- https://github.com/nuxshed/dotfiles/tree/main/config/nvim/lua
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
return M
