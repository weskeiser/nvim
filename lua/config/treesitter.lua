require'nvim-treesitter.configs'.setup {
  ensure_installed = {
   'css', 'html', 'javascript', 'json', 'lua', 'typescript', 'tsx', 'vim', 'bash',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    -- Disable styled.tsx files
    disable = function(lang, bufnr)
      local filetype = vim.fn.expand "%:t"
      local found = string.find(filetype, 'styled')
      return lang == "tsx" and found
    end
  },
  indent = {
    enable = true
  },
  --[[
  rainbow = {
      enable = true,
      extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      colors = {
      "#5bb3b3",
      --"#98C379",
      --"#bb80b3",
      --"#dca7ec",
      }, -- table of hex strings
  },
  ]]--
  refactor = {
    highlight_definitions = {
      enable = true,
      clear_on_cursor_move = true,
    },
  },
}


