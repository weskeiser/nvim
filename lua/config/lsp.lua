local utils = require("config.utils")
local nnoremap = utils.bind("n")
local inoremap = utils.bind("i")

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
}

local lspkind = require("lspkind")

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-j>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping.confirm({ select = true }),
		--["<C-k>"] = cmp.mapping.scroll_docs(-4),
		--["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		--["<C-K>"] = cmp.mapping.select_prev_item(),
		--["<NL>"] = cmp.mapping.select_next_item(),
	}),

	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
			local strings = vim.split(kind.kind, "%s", { trimempty = true })
			kind.kind = " " .. strings[1] .. " "
			kind.menu = "    (" .. strings[2] .. ")"

			return kind
		end,
	},

	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
	},

	window = {
		completion = {
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		},
	},
})

local lspbuf = vim.lsp.buf

M.on_attach = function()
	nnoremap("gd", function()
		lspbuf.definition()
	end)

	nnoremap("gD", function()
		lspbuf.implementation()
	end)

	nnoremap("gr", function()
		require("telescope.builtin").lsp_references()
	end)

	nnoremap("gt", function()
		lspbuf.type_definition()
	end)

	nnoremap("<leader>i", function()
		lspbuf.hover()
	end)

	nnoremap("<leader>r", function()
		lspbuf.code_action()
	end)

	nnoremap("<leader>3", function()
		vim.diagnostic.goto_next()
	end)

	nnoremap("<leader>#", function()
		vim.diagnostic.goto_prev()
	end)

	nnoremap("<leader>e", function()
		vim.diagnostic.goto_next({
			severity = vim.diagnostic.severity.ERROR,
		})
	end)

	nnoremap("<leader>E", function()
		vim.diagnostic.goto_prev({
			severity = vim.diagnostic.severity.ERROR,
		})
	end)

	nnoremap("<leader>vrn", function()
		lspbuf.rename()
	end)

	nnoremap("<leader>vws", function()
		lspbuf.workspace_symbol()
	end)
end

M.config = function(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = M.on_attach,
	}, _config or {})
end

local lspconfig = require("lspconfig")
lspconfig.tsserver.setup(M.config())
require("symbols-outline").setup({
	highlight_hovered_item = true,
	-- whether to show outline guides
	-- default: true
	show_guides = true,
})

--[[
local snippets_paths = function()
	local plugins = { "friendly-snippets" }
	local paths = {}
	local path
	local root_path = vim.env.HOME .. "/.vim/plugged/"
	for _, plug in ipairs(plugins) do
		path = root_path .. plug
		if vim.fn.isdirectory(path) ~= 0 then
			table.insert(paths, path)
		end
	end
	return paths
end

require("luasnip.loaders.from_vscode").lazy_load({
	paths = snippets_paths(),
	include = nil, -- Load all languages
	exclude = {},
})
]]
--

return M
