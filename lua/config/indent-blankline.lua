require('indent_blankline').setup{
  show_end_of_line = false,
  use_treesitter = true,
  show_current_context = true,
  space_char_blankline = " ",
  --max_indent_increase = 1,
  context_patterns = {'switch', '^if', '^func', 'class', 'method', 'while', 'for', 'with', 'try', 'except', 'arguments', 'argument_list', 'object', 'dictionary', 'element', 'table', 'tuple', 'do_block', 'array', 'import', 'var'
  }
}
