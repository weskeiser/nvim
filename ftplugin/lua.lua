local paths = require("config.paths")
local lsp = require("config/lsp")

local root_path = paths.HOME .. "/.config/nvim/misc/lua-language-server"
local server_path = root_path .. "/bin/lua-language-server"

vim.lsp.start(lsp.config({
	name = "lua",
	cmd = { server_path, "-E", root_path .. "/main.lua" },
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				path = server_path,
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
}))
