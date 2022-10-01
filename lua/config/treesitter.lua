require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
   'css', 'html', 'javascript', 'json', 'json5', 'lua', 'typescript', 'tsx', 'vim', 'bash', 'java'
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    -- Disable styled.tsx files
    --[[
    disable = function(lang, bufnr)
      local filetype = vim.fn.expand "%:t"
      local found = string.find(filetype, 'styled')
      local styled = lang == "tsx" and found
      return styled
    end
  ]]--
  },
  context_commentstring = {
    enable = true,
    config = {
      javascript = {
        --__default = '// %s',
        jsx_element = '{/* %s */}',
        jsx_fragment = '{/* %s */}',
        jsx_attribute = '// %s',
        comment = '// %s',
      },
    }
  },
  indent = {
    enable = true
  },
  autotag = {
    enable = true,
  },

  rainbow = {
      enable = true,
      extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
      colors = {
      --'#FFD100',
      -- '#8394b9',
      '#a3a4a8',
      -- '#EA68DB',
      -- '#e74bd4',

      },
  },
  refactor = {
    highlight_definitions = {
      enable = false,
      clear_on_cursor_move = true,
    },
    --[[
    highlight_current_scope = {
      enable = true,
    }
    ]]--
  },
}



