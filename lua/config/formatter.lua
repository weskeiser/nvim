-- requires npm i -g @fsouza/prettierd
function format_prettierd()
	return {
		exe = "prettierd",
		args = { vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

function format_google_java_format()
	return {
		exe = "java",
		args = {
			"-jar",
			"/home/weskeiser/.config/nvim/misc/google-java-format/google-java-format-1.15.0-all-deps.jar",
			"-", -- 4 spaces
		},
		stdin = true,
	}
end

local util = require("formatter.util")

require("formatter").setup({
	logging = true,
	filetype = {
		java = { format_google_java_format },
		typescript = { format_prettierd },
		typescriptreact = { format_prettierd },
		-- lua = { format_prettierd },
		-- ["*"] = {
		--   -- "formatter.filetypes.any" defines default configurations for any
		--   -- filetype
		--   require("formatter.filetypes.any").remove_trailing_whitespace
		-- },
		-- lua = {
		-- 	require("formatter.filetypes.lua").stylua,
		--
		-- 	function()
		-- 		-- Supports conditional formatting
		-- 		if util.get_current_buffer_file_name() == "special.lua" then
		-- 			return nil
		-- 		end
		--
		-- 		-- Full specification of configurations is down below and in Vim help
		-- 		-- files
		-- 		return {
		-- 			exe = "stylua",
		-- 			args = {
		-- 				"--search-parent-directories",
		-- 				"--stdin-filepath",
		-- 				util.escape_path(util.get_current_buffer_file_path()),
		-- 				"--",
		-- 				"-",
		-- 			},
		-- 			stdin = true,
		-- 		}
		-- 	end,
		-- },
	},
})

vim.cmd([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * FormatWrite
augroup END
]])
