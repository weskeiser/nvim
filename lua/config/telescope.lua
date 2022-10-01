local actions = require("telescope.actions")

require('telescope').setup({
  defaults = {
    dynamic_preview_title = true,
    results_title = false,
    path_display = function(opts, path)
      local tail = require("telescope.utils").path_tail(path)
      local test = #tail
      newL = 25 - test
      local spaces = string.rep(" ", newL)
      return string.format("%s %s [%s]", tail, spaces, path)
    end,
    file_ignore_patterns = { "node_modules" },
    mappings = {
      i = {
        ["<C-o>"] = actions.select_vertical,
      },
      n = {
        ["<C-o>"] = actions.select_vertical,
      }
    },
    prompt_prefix = "    ",
    color_devicons = true,
    layout_strategy = 'center',
    sorting_strategy = 'ascending',
    layout_config = {
      center = {
        height = 0.6,
        width = 0.7,
      },
      mirror = true,
    },
  },

  pickers = {

    jumplist = {
      initial_mode = "normal",
      path_display = {"tail"},
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          height = 0.9,
          width = 0.9,
          preview_width = 0.7,
        },
        mirror = false,
      },
    },

    lsp_references = {
      initial_mode = "normal",
      layout_strategy = 'horizontal',
      layout_config = {
        horizontal = {
          height = 0.9,
          width = 0.9,
          preview_width = 0.7,
        },
        mirror = false,
      },
    },

    live_grep = {
      prompt_title = ">>> Grep",
    },

    buffers = {
      prompt_title = ">>> Buffers",
      mappings = {
        n = {
          ['dd'] = actions.delete_buffer,
        },
      },
    },

    find_files = {
      prompt_title = ">>> Files",
      mappings = {
        n = {
          ['qq'] = actions.close,
          ['o'] = actions.select_vertical,
          ["cd"] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent cd %s", dir))
            vim.cmd([[lua require("telescope.builtin").find_files()]])
          end,
          [".."] = function(prompt_bufnr)
            local selection = require("telescope.actions.state").get_selected_entry()
            local dir = vim.fn.fnamemodify(selection.path, ":p:h")
            require("telescope.actions").close(prompt_bufnr)
            -- Depending on what you want put `cd`, `lcd`, `tcd`
            vim.cmd(string.format("silent cd ..", dir))
            vim.cmd([[lua require("telescope.builtin").find_files()]])
          end,
        },
        i = {
          ['<C-w>'] = actions.select_vertical,
          ['qq'] = actions.close
        }
      },
    },
  },

})

