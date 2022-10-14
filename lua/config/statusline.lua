local c = require("config.colors")
local cmd = vim.cmd

local modes = {
	["n"] = "NORMAL",
	["no"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "VISUAL LINE",
	[""] = "VISUAL BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT LINE",
	[""] = "SELECT BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["R"] = "REPLACE",
	["Rv"] = "VISUAL REPLACE",
	["c"] = "COMMAND",
	["cv"] = "VIM EX",
	["ce"] = "EX",
	["r"] = "PROMPT",
	["rm"] = "MOAR",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERMINAL",
}

cmd("hi StatusLine guibg=NONE")
cmd("hi StatusLineAccent guifg=" .. c.beige .. " guibg=" .. c.orange_strong or c.magenta)
cmd("hi StatusLineInsert guifg=" .. c.dark_grey .. " guibg=" .. c.eggwhite)
cmd("hi StatusLineVisual guifg=" .. c.dark_grey .. " guibg=" .. c.bright_green)
cmd("hi StatusLineCmdLine guifg=" .. c.orange_strong .. " guibg=" .. c.orange_faded)
cmd("hi StatuslineTerminal guifg=" .. c.orange_strong .. " guibg=" .. c.orange_faded)

cmd("hi StatusLineFilename guifg=" .. c.green_primary .. " guibg=" .. c.NONE)
cmd("hi WinbarFilepath guifg=" .. c.identifier)
cmd("hi StatusLineInactive guifg=" .. c.beige .. " guibg=NONE")
cmd("hi StatusLineFileModified guifg=" .. c.beige .. " guibg=" .. c.funkygreen)

cmd("hi StatusLineOrange guifg=" .. c.orange_faded)
cmd("hi StatusLineOrangeBg guifg=" .. c.dark_grey .. " guibg=" .. c.orange_strong)

cmd("hi LspDiagnosticsSignHint guifg=" .. c.white .. " guibg=" .. c.yellow_error)
cmd("hi LspDiagnosticsSignInformation guifg=" .. c.white .. " guibg=" .. c.orange_strong)
cmd("hi LspDiagnosticsSignWarning guifg=" .. c.orange_strong .. " guibg=White")
cmd("hi LspDiagnosticsSignError guifg=" .. c.white .. " guibg=" .. c.red_secondary)

-- Lsp
local function lsp()
	local count = {}
	local levels = {
		errors = "Error",
		warnings = "Warn",
		info = "Info",
		hints = "Hint",
	}

	for k, level in pairs(levels) do
		count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
	end

	local errors = ""
	local warnings = ""
	local hints = ""
	local info = ""

	if count["errors"] ~= 0 then
		errors = " %#LspDiagnosticsSignError#  " .. count["errors"]
	end
	if count["warnings"] ~= 0 then
		warnings = " %#LspDiagnosticsSignWarning#  " .. count["warnings"]
	end
	if count["hints"] ~= 0 then
		hints = " %#LspDiagnosticsSignHint#  " .. count["hints"]
	end
	if count["info"] ~= 0 then
		info = " %#LspDiagnosticsSignInformation#  " .. count["info"]
	end

	return errors .. warnings .. hints .. info .. " "
end

local function filepath()
	local fpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.:h")
	if fpath == "" or fpath == "." then
		return ""
	end

	return string.format("%%<%s/", fpath)
end

local function filename()
	local fname = vim.fn.expand("%:t")
	if fname == "" then
		return ""
	end
	return "/" .. fname .. " "
end

local function totalLines()
	return "~ %L%*"
end

local function columnCount()
	return ":%v%*"
end

local function fileModified()
	return "%m"
end

-- Mode colors
local function updateColors()
	local current_mode = vim.api.nvim_get_mode().mode
	local mode_color = "%#StatusLineOrangeBg#"

	if current_mode == "n" then
		mode_color = "%#StatusLineOrangeBg#"
	elseif current_mode == "i" or current_mode == "ic" then
		mode_color = "%#StatuslineInsert#"
	elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
		mode_color = "%#StatuslineVisual#"
	elseif current_mode == "c" then
		mode_color = "%#StatuslineCmdLine#"
	elseif current_mode == "t" then
		mode_color = "%#StatuslineTerminal#"
	end

	return mode_color
end

-- Building the statusline
Statusline = {}

Statusline.active = function()
	return table.concat({

		updateColors(),
		"%=",

		lsp(),

		updateColors(),
		"%=",
	})
end

function Statusline.nvim_tree()
	return "%#StatusLineFilename#   NvimTree"
end

function Statusline.inactive()
	return table.concat({
		"%#StatusLineInactive#",
		"%=",

		lsp(),

		"%#StatusLineInactive#",
		"%=",
	})
end

-- Showing the statusline
vim.api.nvim_exec(
	[[
  augroup Statusline
  au!
  au WinEnter,BufEnter,FocusGained * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave,FocusLost * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree_1 setlocal statusline=%!v:lua.Statusline.nvim_tree()
  au FocusLost * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]],
	false
)

---------- WinBar ----------

local icon_cache = {}

local function get_icon(filename, extension)
	if not filename then
		-- if vim.bo.modified then
		--   return "  %*"
		-- end

		if vim.bo.filetype == "terminal" then
			filename = "terminal"
			extension = "terminal"
		else
			filename = vim.fn.expand("%:t")
		end
	end

	local cached = icon_cache[filename]
	if not cached then
		if not extension then
			extension = vim.fn.fnamemodify(filename, ":e")
		end
		local file_icon, hl_group = require("nvim-web-devicons").get_icon(filename, extension)
		cached = " " .. "%#" .. hl_group .. "#" .. file_icon .. " %*"
		icon_cache[filename] = cached
	end
	return cached
end

local function show_modified()
	if vim.bo.modified then
		return "  %*"
	else
		return ""
	end
end

local function show_icon()
	local has_icon, icon = pcall(get_icon)
	if has_icon then
		return icon
	else
		return ""
	end
end

local isempty = function(s)
	return s == nil or s == ""
end

local is_current = function()
	local winid = vim.g.actual_curwin
	if isempty(winid) then
		return false
	else
		return winid == tostring(vim.api.nvim_get_current_win())
	end
end

function get_winbar()
	local filepathColor = "%#WinbarFilepath#"

	if is_current() then
		filepathColor = "%#StatusLineOrange#"
	end

	return table.concat({
		"%=",

		"%#StatusLineOrange#",
		show_modified(),

		show_icon(),

		filepathColor,
		filepath(),

		"%#StatusLineFilename#",
		"%t",

		"%=",
	})
end

vim.o.winbar = "%{%v:lua.get_winbar()%}"

-- https://github.com/nuxshed/dotfiles/tree/main/config/nvim/lua
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html
