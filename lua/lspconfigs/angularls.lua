local lsp = require("config/lsp")
local paths = require("config.paths")
local lspconfig = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local project_library_path = paths.HOME .. "/.local/lib/node_modules/"
local cmd =
	{ "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations", project_library_path }

-- vim.lsp.start(lsp.config({
-- 	name = "angularls",
-- 	capabilities = capabilities,
-- 	cmd = cmd,
-- 	on_new_config = function(new_config, new_root_dir)
-- 		new_config.cmd = cmd
-- 	end,
-- }))

lspconfig.angularls.setup({
	capabilities = capabilities,
	cmd = cmd,
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = cmd
	end,
})

-- Install global devdependency for @angular/language-service, @angular/language-server and typescript
