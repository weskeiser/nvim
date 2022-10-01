require ('plugins')
require ('config/nvim-web-devicons')
require ('config/material')
vim.cmd 'colorscheme material' -- after theme and before statusline
require ('config/statusline')
require ('config/highlights')
require ('config/lsp')
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
--require ('config/eyeliner')
require ('config/scrollbar')
require ('config/neodim')
require ('config/treesitter_context')
require ('config/nvim_comment')
require ('config/autocommands')

require('gitsigns').setup({
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },  
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>ms', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>mr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>mS', gs.stage_buffer)
    map('n', '<leader>mu', gs.undo_stage_hunk)
    map('n', '<leader>mR', gs.reset_buffer)
    map('n', '<leader>mp', gs.preview_hunk)
    map('n', '<leader>mb', function() gs.blame_line{full=true} end)
    map('n', '<leader>mtb', gs.toggle_current_line_blame)
    map('n', '<leader>md', gs.diffthis)
    map('n', '<leader>mD', function() gs.diffthis('~') end)
    map('n', '<leader>mtd', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'im', ':<C-U>Gitsigns select_hunk<CR>')
  end
})


-- Highlight on yank
vim.cmd 'au TextYankPost * silent! lua vim.highlight.on_yank({ higroup = "IncSearch", timeout = 250 })'
