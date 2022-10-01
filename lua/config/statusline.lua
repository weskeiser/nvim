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


local c = {
  NONE = 'NONE',
  funkygreen = '#18d18d' ,
  fg = "#685c56",
  bg = "#ff6a1a",
  accent = '#ff6a1a',
  --background = "#303d55",
  background = '#2b2b2c',
  orange_primary =  '#ff6a1a',
  bluish = '#303d55',
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
  cyan = "#3B8992",
  brightyellow = "#FFFF00",
  brightgreen = "#66FF00",
  smoothgreen = "#6da832",
  eggwhite = "#d1e0bc",
  white = '#ffffff',
  yellow_error = '#FFCB6B',
  ViMode = {
    Normal = "#26363c",
  },
}


cmd("hi StatusLineAccent guifg=" .. c.light_grey .. " guibg=" .. c.accent or c.magenta)
cmd("hi StatusLineLines guifg=" .. c.light_grey .. " guibg=" .. c.accent)
cmd("hi StatusLineTotalLines guifg=" .. c.dark_grey .. " guibg=" .. c.accent)
cmd("hi StatusLineInsertAccent guifg=" .. c.dark_grey .. " guibg=" .. c.eggwhite)
cmd("hi StatusLineVisualAccent guifg=" .. c.dark_grey .. " guibg=" .. c.brightgreen)
cmd("hi StatusLineReplaceAccent guifg=" .. c.bg .. " guibg=" .. c.red)
cmd("hi StatusLineCmdLineAccent guifg=" .. c.bg .. " guibg=" .. c.yellow)
cmd("hi StatuslineTerminalAccent guifg=" .. c.bg .. " guibg=" .. c.yellow)
cmd("hi StatusLineFilename guifg=" .. c.funkygreen .. " guibg=" .. c.NONE)
cmd("hi StatusLineFilename2 guifg=" .. c.orange_primary .. " guibg=" .. c.NONE)
cmd("hi StatusLineFilenameInactive guifg=" .. c.light_grey .. " guibg=NONE")
cmd("hi StatusLineFilepath guifg=" .. c.light_grey .. " guibg=" .. "#442212" )
cmd("hi StatusLineExtra guifg=" .. c.light_grey .. " guibg=" .. c.bg)
cmd("hi StatusLineFileModified guifg=" .. c.light_grey .. " guibg=" .. c.funkygreen)
cmd("hi StatusLineBackground guibg=" .. c.bg)
cmd("hi StatusLine guibg=NONE")

cmd("hi LspDiagnosticsSignHint guifg=White" .. " guibg=" .. c.yellow_error)
cmd("hi LspDiagnosticsSignInformation guifg=#ffffff" ..  " guibg=" .. c.bg)
cmd("hi LspDiagnosticsSignWarning guifg=" .. c.orange_primary ..  " guibg=White")
cmd("hi LspDiagnosticsSignError guifg=White" .. " guibg=" .. c.red)

-- Filepath
local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
      return ""
  end

  return string.format(" %%<%s", fpath)
end


-- Filename
local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
      return ""
  end
  return "/" .. fname .. " "
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

-- Total lines in file
local function totalLines()
  return "~ %L%*"
end

local function columnCount()
  return ":%v%*"
end

-- Filetype
local function filetype()
  return string.format(" %s ", vim.bo.filetype):upper()
end

-- File modified
local function fileModified()
  return " %#StatusLineFileModified#%m% "
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

-- Mode colors
local function update_mode_colors_general()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineTotalLines#"
  if current_mode == "n" then
      mode_color = "%#StatusLineTotalLines#"
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

local function update_mode_colors_filepath()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineFilepath#"
  if current_mode == "n" then
      mode_color = "%#StatusLineFilepath#"
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

-- Building the statusline
Statusline = {}

Statusline.active = function()
  return table.concat {
    update_mode_colors_general(),
    filename(),

    update_mode_colors_general(),
    string.format("%s", totalLines()),

    update_mode_colors_general(),
    string.format("%s", columnCount()),

    update_mode_colors_general(),
    lsp(),

    update_mode_colors_general(),
    fileModified(),

    update_mode_colors_general(),
    "%=",

--    update_mode_colors_filepath(),
    "%#StatusLineFilepath#",
    string.format("%s", filepath()),

    "%#StatusLineFilename#",
    filename(),
  }
end

function Statusline.inactive()
  return table.concat {
    "%#StatusLineFilename2# %t",
    "%=",
    "%#StatusLineFilename# %t",
    --"%#StatusLineFilenameInactive#%f | %#StatusLineFilename# %t ",
  }
end

function Statusline.focusLost()
  return table.concat {
    "%#StatusLineFilenameInactive# <<UNFOCUSED>>>>>>>>>>>>>>>>>>>",
    "%=",
     "%#StatusLineFilename# %t ",
  }
end

function Statusline.short()
  return "%#StatusLineFilename#   NvimTree"
end



-- Showing the statusline
vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter,FocusGained * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave,FocusLost * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree_1 setlocal statusline=%!v:lua.Statusline.short()
  au FocusLost * setlocal statusline=%!v:lua.Statusline.focusLost()
  augroup END
]], false)




-- https://github.com/nuxshed/dotfiles/tree/main/config/nvim/lua
-- https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html

