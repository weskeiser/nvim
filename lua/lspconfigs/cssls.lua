local paths = require("config.paths")
local lspconfig = require("lspconfig")
local lsp = require("config/lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup({
	capabilities = capabilities,
})
