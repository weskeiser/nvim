-- Darker
vim.cmd("hi BlanklineDarkGrey guifg=#323234 gui=nocombine")
-- Dark
vim.cmd("hi Blankline3 guifg=#3e3e41")

vim.cmd("hi BlanklineGreen guifg=#40512f gui=nocombine")


--vim.cmd("hi BlanklineYellowLight guifg=#645827" )
vim.cmd("hi BlanklineYellowLight guifg=#413d2a" )
--vim.cmd("hi BlanklinePinkLight guifg=#673c65" )
vim.cmd("hi BlanklinePinkLight guifg=#392d38" )

--vim.cmd("hi BlanklineYellow guifg=#FFD100" )
vim.cmd("hi BlanklineYellow guifg=#7d6e31" )
--vim.cmd("hi BlanklinePink guifg=#EA68DB" )
vim.cmd("hi BlanklinePink guifg=#673c65" )

vim.cmd("hi BlanklineLightGrey guifg=#727279" )

require('indent_blankline').setup{
  show_end_of_line = false,
  use_treesitter = true,
  show_current_context = true,
  --show_current_context_start = true,
  show_current_context_start_on_current_line = false,
  show_trailing_blankline_indent = false,
  space_char_blankline = " ",
  char_highlight_list = {'BlanklineGreen', 'BlanklineYellowLight', 'BlanklinePinkLight', 'BlanklineYellowLight', 'BlanklinePinkLight', 'BlanklineYellowLight', 'BlanklinePinkLight', 'BlanklineYellowLight', 'BlanklinePinkLight', 'BlanklineYellowLight', 'BlanklinePinkLight', },
  context_highlight_list = {'BlanklineGreen', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink',},
  context_char_list = {'┫', '▎', '▎', '▎', '▎', '▎', '▎', '▎', '▎', '▎', },
  char_list = {'┫', '▎', '▎', '▎', '▎', '▎', '▎', '▎', '▎', '▎', },
  --space_char_blankline = "█",
  --max_indent_increase = 1,
  context_patterns = {'switch', '^if', '^func', 'class', 'method', 'while', 'for', 'with', 'try', 'except', 'arguments', 'argument_list', 'object', 'dictionary', 'element', 'table', 'tuple', 'do_block', 'array', 'import', 'var', 'fragment', 'return', 'fetch'
  },
 --use_treesitter_scope = true,
  }
-- ║

-- ╂
