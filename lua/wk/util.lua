local M = {}

function M.hl(k, v)
	vim.api.nvim_set_hl(0, k, v)
end

return M
