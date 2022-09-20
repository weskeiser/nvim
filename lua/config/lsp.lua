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
      require('luasnip').lsp_expand(args.body)
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
  }
})

local on_attach = function()
  nnoremap("gd", function() vim.lsp.buf.definition() end)
  nnoremap("gD", function() vim.lsp.buf.implementation() end)
  nnoremap("gt", function() vim.lsp.buf.type_definition() end)
  nnoremap("<leader>i", function() vim.lsp.buf.hover() end)
  nnoremap("<leader>r", function() vim.lsp.buf.code_action() end)

  nnoremap("<leader>3", function() vim.diagnostic.goto_next() end)
  nnoremap("<leader>#", function() vim.diagnostic.goto_prev() end)
  nnoremap("<leader>e", function() vim.diagnostic.goto_next({
    severity = vim.diagnostic.severity.ERROR
  }) end)
  nnoremap("<leader>E", function() vim.diagnostic.goto_prev({
    severity = vim.diagnostic.severity.ERROR
  }) end)

  nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
  nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
  nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
end


local function config(_config)
	return vim.tbl_deep_extend("force", {
		capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		on_attach = on_attach,
  }, _config or {})
end
			-- inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)



local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

lspconfig.tsserver.setup(config())
lspconfig.cssls.setup(config())

local opts = {
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
