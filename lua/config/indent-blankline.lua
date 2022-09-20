vim.cmd("hi BlanklineYellow guifg=#7d6e31" )
vim.cmd("hi BlanklinePink guifg=#673c65" )
vim.cmd("hi BlanklineLightGrey guifg=#727279" )

require('indent_blankline').setup{
  use_treesitter = true,
  show_current_context = true,
  --show_current_context_start = true,
  show_current_context_start_on_current_line = false,
  show_trailing_blankline_indent = false,
  space_char_blankline = " ",
  char_highlight_list = {'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', },
  context_highlight_list = {'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink', 'BlanklineYellow', 'BlanklinePink',},
  context_char_list = {'┫', '▎', '▎', '▎', '▎', '▎', '▎', '▎', '▎', '▎', },
  char_list = {'┫', '▎', '▎', '▎', '▎', '▎', '▎', '▎', '▎', '▎', },
  --max_indent_increase = 1,
  context_patterns = {'switch', '^if', '^func', 'class', 'method', 'while', 'for', 'with', 'try', 'except', 'arguments', 'argument_list', 'object', 'dictionary', 'element', 'table', 'tuple', 'do_block', 'array', 'import', 'var', 'fragment', 'return', 'fetch'
  },
 --use_treesitter_scope = true,
  }
-- ║

-- ╂
