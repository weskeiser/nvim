vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.wo.linebreak = true
vim.wo.wrap = true
--vim.o.columns = 80
vim.o.textwidth = 80
vim.o.breakindent = true
--vim.o.breakindentopt = 'shift:8'
vim.o.wrapmargin = 2
vim.wo.cursorline = true
vim.wo.cursorlineopt = "both"
--vim.wo.cursorlineopt = "number"
vim.o.showmatch = true
vim.o.history = 1000
vim.o.scrolloff = 14
vim.o.autoindent = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.equalalways = true
vim.opt.guifont = {"JetBrainsMono Nerd Font Mono", "h10"}
vim.o.signcolumn = 'yes:1'
vim.o.cmdheight = 1
--vim.opt.formatoptions = "njvcrql"

vim.o.shortmess = vim.o.shortmess .. 'cI'
--vim.o.colorcolumn = '80'

-- Cursor
vim.opt.termguicolors = true

-- Misc
vim.opt.smartindent = true
vim.o.relativenumber = true
vim.o.number = true
vim.o.numberwidth = 1

-- Tab input width
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- Disable swap files
vim.opt.swapfile = false

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
vim.opt.updatetime = 50
