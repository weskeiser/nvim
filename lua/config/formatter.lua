-- requires npm i -g @fsouza/prettierd
function format_prettierd()
   return {
     exe = "prettierd",
     args = {vim.api.nvim_buf_get_name(0)},
     stdin = true
   }
end

local util = require "formatter.util"

require('formatter').setup {
  logging = true,
  filetype = {
    typescript = { format_prettierd },
    typescriptreact = { format_prettierd },
    ["*"] = {
      -- "formatter.filetypes.any" defines default configurations for any
      -- filetype
      require("formatter.filetypes.any").remove_trailing_whitespace
    }
  }
}

vim.cmd [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]]
