local M = function(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local map = M

-- Yank and paste to system clipboard
map("v", "y", '"+y')
map("n", "y", '"+y')
map("n", "Y", '"+y$')

map("v", "p", '"+p')
map("n", "p", '"+p')
map("n", "P", '"+P')

map("n", "d", '"+d')
map("v", "d", '"+d')
map("n", "D", '"+D')
map("n", "dd", '"+dd')

-- w -> e in visual and operational mode
map("v", "w", "e")
map("o", "w", "e")

-- Replace line with paste
map("n", "<C-p>", "VP")

-- Move line in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Control-J to Tab
-- map("i", "<C-j>", "<C-i>")
-- map("n", "<C-j>", "<C-i>")

-- Save and quit
map("n", "<C-s>", ":silent :w!<cr>", { noremap = true, silent = true })
map("i", "<C-s>", "<ESC>:silent: w!<cr>", { noremap = true, silent = true })

map("n", "qq", ":silent :close<CR>", { noremap = true, silent = true })
map("v", "qq", ":silent :close<CR>", { noremap = true, silent = true })
map("n", "<C-q>", ":silent :q!<cr>", { noremap = true, silent = true })
map("v", "<C-q>", ":silent :q!<cr>", { noremap = true, silent = true })
map("i", "<C-q>", "<ESC>:silent :q!<cr>", { noremap = true, silent = true })

map("n", "<C-Space>", ":silent :close<CR>", { noremap = true, silent = true })

-- Map macros to q5
map("n", "q", "")
map("n", "q5", "q")

-- Map * to *`` | TODO: Fix due to jump list
map("n", "*", "*``")

-- Keep visual selection when indenting
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- Map @ to be _
map("n", "@", "_")
map("v", "@", "_")
map("n", "y@", '"+y0')
map("n", "c@", '"+c0')
map("n", "d@", '"+d0')

map("n", "#", "_")
map("v", "#", "_")
map("n", "y#", '"+y0')
map("n", "c#", '"+c0')
map("n", "d#", '"+d0')

map("n", "<leader>k", "gM")

map("n", "<leader>h", "_")
map("v", "<leader>h", "_")
map("n", "y<leader>h", '"+y0')
map("n", "c<leader>h", '"+c0')
map("n", "d<leader>h", '"+d0')

map("n", "<leader>l", "$")
map("v", "<leader>l", "$")
map("n", "y<leader>l", '"+y$')
map("n", "c<leader>l", '"+c$')
map("n", "d<leader>l", '"+d$')

-- Map [{ and }] to [[ and ]]
--map('n', '[[', '[{')
--map('n', ']]', ']}')
--map('v', '[[', '[{')
--map('v', ']]', ']}')
map("n", "y[[", '"+y[{')
map("n", "y]]", '"+y]}')
map("n", "c[[", '"+c[{')
map("n", "c]]", '"+c]}')
map("n", "d[[", '"+d[{')
map("n", "d]]", '"+d]}')

-- Telescope keymaps
map("n", "<leader>j", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")

-- Harpoon keymaps
map("n", "<leader>o", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
map("n", "<leader><S-o>", "<cmd>lua require('harpoon.mark').add_file()<cr>")

map("n", "<leader>a", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
map("n", "<leader>s", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
map("n", "<leader>d", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
map("n", "<leader>f", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")

-- Nvim-tree keymaps
map("n", "<C-w><C-t>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
map("i", "<C-w><C-t>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
map("v", "<C-w><C-t>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
map("n", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
map("i", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
map("v", "<C-b>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

--map('n' ,'<C-t>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})
--map('n' ,'<C-t>', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- Search and replace the word under cursor
map("n", "<Leader>*", ":%s/<C-r><C-w>//gc<Left><Left><Left>")

-- Unmap DELETE button
map("n", "<Del>", "<NOP>")
map("i", "<Del>", "<NOP>")

-- Buffer navigation
map("n", "<Leader>,", "<C-^>", { noremap = true, silent = true })
map("n", "gB", ":bnext<CR>")
map("n", "gb", ":bprev<CR>")

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("i", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("i", "<C-l>", "<C-w>l")

map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")

-- Exchange window with neighbouring window
map("n", "<C-S-l>", "<C-w>x<C-w><C-l>")
map("n", "<C-S-h>", "<C-w>h<C-w>x")

-- Arrow keys to scroll
-- map('n', '<Down>', "<Cmd>lua require('neoscroll').scroll(0.10, false, 100)<CR>")
-- map('n', '<Up>', "<Cmd>lua require('neoscroll').scroll(-0.10, false, 100)<CR>")

-- t['<C-S-k>'] = {'scroll', {'-vim.wo.scroll', 'true', '100'}}
-- t['<C-S-j>'] = {'scroll', {'vim.wo.scroll', 'true', '100'}}
-- t['<C-k>'] = {'scroll', {'-0.20', 'true', '100'}}
-- t['<C-j>'] = {'scroll', {'0.20', 'true', '100'}}

-- Scroll by paragraph
-- map('n', '[', '}')
-- map('n', ']', '{')

-- Terminal
map("t", "<Esc>", "<C-\\><C-n>")

map("t", "<C-\\><C-N><C-w>h", "<C-w>h")
map("t", "<C-\\><C-N><C-w>j", "<C-w>j")
map("t", "<C-\\><C-N><C-w>k", "<C-w>k")
map("t", "<C-\\><C-N><C-w>l", "<C-w>l")

-- Add numbered navigation to jump list
map("n", "k", [[(v:count > 1 ? "m'" . v:count : '') . 'gk' ]], { noremap = true, expr = true })
map("n", "j", [[(v:count > 1 ? "m'" . v:count : '') . 'gj' ]], { noremap = true, expr = true })

-- Save as root
map("c", "w!!", "w !sudo tee % >/dev/null<CR>:e!<CR><CR>")

-- Clear search highlighting with <leader> and c
map("n", "<leader>c", ":nohl<CR>")

-- Emmet
-- map('n', '<C-y><C-y>', '<Plug>(emmet-expand-abbr)')
-- map('i', '<C-y><C-y>', '<Plug>(emmet-expand-abbr)')

return M
