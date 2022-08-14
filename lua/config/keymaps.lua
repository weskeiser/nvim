function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Yank and paste to system clipboard
map("v", "y", '"+y')
map("n", "y", '"+y')
map("n", "Y", '"+y$')

map("v", "p", '"+p')
map("n", "p", '"+p')
map("n", "P", '"+P')

map("n", "d", '"+d')
map("v", "d", '"+d')
map("n", "dd", '"+dd')
map("n", "D", '"+D')

map("n", "c", '"+c')
map("v", "c", '"+c')
map("n", "C", '"+C')
map("v", "C", '"+C')

-- Saving and quitting
map("n", "<C-s>", ":w!<cr>")
map("i", "<C-s>", "<ESC>:w!<cr>")

map("n", "qq", "<Cmd>BufferClose<CR>")
map("v", "qq", "<Cmd>BufferClose<CR>")
map("n", "<C-q>", ":q!<cr>")
map("v", "<C-q>", ":q!<cr>")
map("i", "<C-q>", "<ESC>:q!<cr>")

-- Map macros to q5
map('n', 'q', '')
map('n', 'q5', 'q')

-- Map * to *`` | TODO: Fix due to jump list
map('n', '*', '*``')


-- Keep visual selection when indenting
map("v", "<", "<gv", { noremap = true, silent = true })
map("v", ">", ">gv", { noremap = true, silent = true })

-- Map # to be _
map('n', '#', '_')
map('v', '#', '_')
map('n', 'y#', '"+y0')
map('n', 'c#', '"+c0')
map('n', 'd#', '"+d0')


-- Map [{ and }] to [[ and ]]
map('n', '[[', '[{')
map('n', ']]', ']}')
map('v', '[[', '[{')
map('v', ']]', ']}')
map('n', 'y[[', '"+y[{')
map('n', 'y]]', '"+y]}')
map('n', 'c[[', '"+c[{')
map('n', 'c]]', '"+c]}')
map('n', 'd[[', '"+d[{')
map('n', 'd]]', '"+d]}')


-- Telescope keymaps
map("n", "<leader>j", "<cmd>lua require('telescope.builtin').find_files()<cr>")
map("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
map("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")
-- map("n", "<leader>fh", "<cmd>lua require('telescope.builtin').help_tags(require('telescope.themes').get_dropdown({}))<cr>", {noremap = true})

-- Harpoon keymaps
map("n", "<leader>k", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
map("n", "<leader>m", "<cmd>lua require('harpoon.mark').add_file()<cr>")
map("n", "<leader>hc", "<cmd>lua require('harpoon.cmd-ui').toggle_quick_menu()<cr>")

map("n", "<leader>a", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
map("n", "<leader>s", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
map("n", "<leader>d", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
map("n", "<leader>f", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")

-- Nvim-tree keymaps
map("n", "<C-w><C-t>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
map("i", "<C-w><C-t>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})

-- Search and replace the word under cursor
map("n", "<Leader>*", ":%s/<C-r><C-w>//<Left>")

-- Unmap DELETE button
map('n' ,'<DEL>', '')
map('i' ,'<DEL>', '')

-- Buffer navigation
map("n", "<Leader>,", "<C-^>")
--map("n", "<Leader>b", ":buffers<CR>")
map("n", "gB", ":bnext<CR>")
map("n", "gb", ":bprev<CR>")

map("n", '<A-1>', '<Cmd>BufferGoto 1<CR>')
map("n", '<A-2>', '<Cmd>BufferGoto 2<CR>')
map("n", '<A-3>', '<Cmd>BufferGoto 3<CR>')
map("n", '<A-4>', '<Cmd>BufferGoto 4<CR>')
map("n", '<A-5>', '<Cmd>BufferGoto 5<CR>')
map("n", '<A-6>', '<Cmd>BufferGoto 6<CR>')
map("n", '<A-7>', '<Cmd>BufferGoto 7<CR>')
map("n", '<A-8>', '<Cmd>BufferGoto 8<CR>')
map("n", '<A-9>', '<Cmd>BufferGoto 9<CR>')
map("n", '<A-0>', '<Cmd>BufferLast<CR>')




-- Window navigation

--[[
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-u>", "<C-w><C-k>")
map("n", "<C-d>", "<C-w><C-j>")
map("n", "<C-l>", "<C-w><C-l>")

map("i", "<C-h>", "<C-w><C-h>")
map("i", "<C-u>", "<C-w><C-k>")
map("i", "<C-d>", "<C-w><C-j>")
map("i", "<C-l>", "<C-w><C-l>")
]]--



-- Save as root
map("c", "w!!", "w !sudo tee % >/dev/null<CR>:e!<CR><CR>")

-- Clear search highlighting with <leader> and c
map('n', '<leader>c', ':nohl<CR>')

map('n', '<leader>h', "<cmd>lua require('telescope.builtin').find_files({cwd='~/code/' })<cr>")
