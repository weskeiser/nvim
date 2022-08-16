-- https://github.com/nuxshed/dotfiles/tree/main/config/nvim/lua
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html

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


local c = {
  fg = "#685c56",
  bg = "#F0EDEC",
  accent = "#2c374e",
  lightbg = "#e9e4e2",
  fgfaded = "#948985",
  grey = "#948985",
  light_grey = "#948985",
  dark_grey = "#383432",
  bright = "#ffffff",
  red = "#A8334C",
  brightred = "#EE4B2B",
  green = "#597a37",
  blue = "#286486",
  yellow = "#a8623e",
  brightyellow = "#FFFF00",
  magenta = "#88507D",
  orange = "#944927",
  orange_primary =  '#f99157',
  cyan = "#3B8992",
  brightyellow = "#FFFF00",
  brightgreen = "#66FF00",
  smoothgreen = "#6da832",
  eggwhite = "#d1e0bc",
  ViMode = {
    Normal = "#26363c",
  },
}

-- Mode
local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local cmd = vim.cmd

cmd("hi StatusLineAccent guifg=" .. c.light_grey .. " guibg=" .. c.accent or c.magenta)
cmd("hi StatusLineLines guifg=" .. c.light_grey .. " guibg=" .. c.accent)
cmd("hi StatusLineTotalLines guifg=" .. c.smoothgreen .. " guibg=" .. c.accent)
cmd("hi StatusLineInsertAccent guifg=" .. c.dark_grey .. " guibg=" .. c.eggwhite)
cmd("hi StatusLineVisualAccent guifg=" .. c.dark_grey .. " guibg=" .. c.brightgreen)
cmd("hi StatusLineReplaceAccent guifg=" .. c.bg .. " guibg=" .. c.red)
cmd("hi StatusLineCmdLineAccent guifg=" .. c.bg .. " guibg=" .. c.yellow)
cmd("hi StatuslineTerminalAccent guifg=" .. c.bg .. " guibg=" .. c.yellow)
cmd("hi StatusLineFilename guifg=" .. c.orange_primary .. " guibg=" .. c.accent)
cmd("hi StatusLineFilenameInactive guifg=" .. c.smoothgreen .. " guibg=" .. c.accent)
cmd("hi StatusLineExtra guifg=" .. c.light_grey)
cmd "hi StatusLineNC guifg=#ffffff"

--cmd("hi CursorLineNr guibg=NONE")

cmd "hi link NvimTreeLspDiagnosticsWarning LspDiagnosticsSignWarning"
cmd "hi link NvimTreeLspDiagnosticsError LspDiagnosticsSignError"
cmd "hi link NvimTreeLspDiagnosticsInformation LspDiagnosticsSignInformation"
cmd "hi link NvimTreeLspDiagnosticsHint LspDiagnosticsSignHint"

-- Mode colors
local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
      mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
      mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
      --vim.o.cursorline = true
      mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
      mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
      mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
      mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

-- Filepath
local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
      return " "
  end

  return string.format(" %%<%s/", fpath)
end

-- Filename
local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
      return ""
  end
  return fname .. " "
end

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
    errors = " %#LspDiagnosticsSignError# " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#LspDiagnosticsSignInformation# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#Normal# "
end

-- Total lines in file
local function totalLines()
  return "%L%*"
end

local function columnCount()
  return "%v%*"
end

-- Filetype
local function filetype()
  return string.format(" %s ", vim.bo.filetype):upper()
end

-- File modified
local function fileModified()
  return "%m% "
end

-- Line info
local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P "
end

-- Buffer number
local function buffernumber()
  return "%n% "
end

-- Building the statusline
Statusline = {}

Statusline.active = function()
  return table.concat {
    update_mode_colors(),
    mode(),
    "%#StatusLineTotalLines#",
    totalLines(),
    "%#StatusLineExtra#",
    filepath(),
    "%#StatusLineFilename#",
    filename(),
    "%#StatusLineExtra#",
    fileModified(),
    "%=%#Normal#",
    lsp(),
    "%#StatusLineExtra#",
    filetype(),
    "%#StatusLineFilename#",
    columnCount(),
  }
end

function Statusline.inactive()
 -- return " %F"
  return table.concat {
    update_mode_colors(),
    filepath(),
    "%#StatusLineFilenameInactive#",
    filename(),
    "%#StatusLineExtra#",
    fileModified(),
  }
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end

-- Showing the statuslinevim.api.nvim_exec([[
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
