vim.g.mapleader = " "
require ('plugins')
require ('config/material')
vim.cmd 'colorscheme material' -- after theme and before statusline
require ('config/statusline')
require ('config/highlights')
require ('config/lsp')
require ('config/nvim-web-devicons')
require ('config/neoscroll')
require ('config/telescope')
require ('config/treesitter')
require ('config/autopairs')
require ('config/nvim-tree')
require ('config/options')
require ('config/harpoon')
require ('config/indent-blankline')
require ('config/formatter')
require ('config/keymaps')
require ('config/custom-diagnostic-highlight')
require ('config/eyeliner')
require ('config/scrollbar')



-- Highlight on yank
vim.cmd 'au TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })'


local autocmd = vim.api.nvim_create_autocmd

-- Open :help as vsplit
autocmd('BufEnter', {
  command = "if &ft ==# 'help' | wincmd L | endif"
})

-- New lines are not comments
autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o'
})

-- Traverse 24 lines on BufEnter
--autocmd('BufEnter', {
--  command = "call feedkeys('12j')"
--})

autocmd('VimEnter', {
  command = ':unmap [%'
})
autocmd('VimEnter', {
  command = ':unmap ]%'
})

