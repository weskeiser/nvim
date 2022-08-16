local function bind(op, outer_opts)
    outer_opts = outer_opts or {noremap = true}
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end

local nnoremap = bind("n")
local inoremap = bind("i")




local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup nvim-cmp.
local cmp = require("cmp")
local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	path = "[Path]",
}
local lspkind = require("lspkind")

cmp.setup({
	snippet = {
		expand = function(args)
			-- For `luasnip` user.
			--require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
		--["<C-k>"] = cmp.mapping.scroll_docs(-4),
		--["<C-j>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
    --["<C-K>"] = cmp.mapping.select_prev_item(),
    --["<NL>"] = cmp.mapping.select_next_item(),
	}),

	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			vim_item.menu = menu
			return vim_item
		end,
	},

	sources = {
		{ name = "nvim_lsp" },

		-- For luasnip user.
	--	{ name = "luasnip" },

    --
		{ name = "buffer" },

	},
})


local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = function()
			nnoremap("gd", function() vim.lsp.buf.definition() end)
			nnoremap("gD", function() vim.lsp.buf.declaration() end)
			nnoremap("gt", function() vim.lsp.buf.type_definition() end)
			nnoremap("gi", function() vim.lsp.buf.implementation() end)
			nnoremap("<leader>e", function() vim.diagnostic.goto_next() end)
			nnoremap("<leader>E", function() vim.diagnostic.goto_prev() end)
			--nnoremap("<C-i>", function() vim.diagnostic.open_float() end)
			--nnoremap("<C-K><C-I>", function() vim.lsp.buf.hover() end)
			nnoremap("<leader>i", function() vim.lsp.buf.hover() end)
			nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
			nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
			nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
			nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
		end,
	}, _config or {})
end
			-- inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)




require("lspconfig").tsserver.setup(config())

require("lspconfig").cssls.setup(config())

local opts = {
	-- whether to highlight the currently hovered symbol
	-- disable if your cpu usage is higher than you want it
	-- or you just hate the highlight
	-- default: true
	highlight_hovered_item = true,

	-- whether to show outline guides
	-- default: true
	show_guides = true,
}

require("symbols-outline").setup(opts)


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
]]--
