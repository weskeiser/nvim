local autocmd = vim.api.nvim_create_autocmd

local c = {
  blue_dark = '#243e61',
  blue_darker = '#273445',
}




local au_linenr = vim.api.nvim_create_augroup("linenr", { clear = true })
autocmd("FocusGained", {
  command = ":hi LineNr guifg=" .. c.blue_dark,
  group = au_linenr,
})
autocmd("FocusLost", {
    command = "hi LineNr guifg=" .. c.blue_darker,
    group = au_linenr,
})


local au_syntaxsync = vim.api.nvim_create_augroup("syntaxsync", { clear = true })
autocmd('BufEnter', {
  pattern = '*.{js,jsx,ts,tsx}',
  command = ":syntax sync fromstart",
  group = au_syntaxsync,
})
autocmd('BufLeave', {
  pattern = '*.{js,jsx,ts,tsx}',
  command = ":syntax sync clear",
  group = au_syntaxsync,
})


-- Open :help as vsplit
local au_vsplit = vim.api.nvim_create_augroup("vsplit", { clear = true })
autocmd('BufEnter', {
  command = "if &ft ==# 'help' | wincmd L | endif",
  group = au_vsplit
})

-- New lines are not comments
local au_newlines = vim.api.nvim_create_augroup("newlines", { clear = true })
autocmd('BufEnter', {
  pattern = '*',
  command = 'set fo-=c fo-=r fo-=o',
  group = au_newlines
})

local au_unmap = vim.api.nvim_create_augroup("unmap", { clear = true })
autocmd('VimEnter', {
  command = ':nnoremap dF "+dF',
  group = au_unmap
})
autocmd('VimEnter', {
  command = ':nnoremap df "+df',
  group = au_unmap
})

autocmd('VimEnter', {
  command = ':nnoremap dt "+dt',
  group = au_unmap
})

autocmd('VimEnter', {
  command = ':nnoremap dT "+dT',
  group = au_unmap
})

autocmd('VimEnter', {
  command = ':nnoremap yF "+yF',
  group = au_unmap
})
autocmd('VimEnter', {
  command = ':nnoremap yf "+yf',
  group = au_unmap
})

autocmd('VimEnter', {
  command = ':nnoremap yt "+yt',
  group = au_unmap
})

autocmd('VimEnter', {
  command = ':nnoremap yT "+yT',
  group = au_unmap
})


autocmd('VimEnter', {
  command = ':unmap [%',
  group = au_unmap
})
autocmd('VimEnter', {
  command = ':unmap ]%',
  group = au_unmap
})
