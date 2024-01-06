local HOME = os.getenv("HOME")
-- vim.opt.matchpairs = [[(:),{:},[:],=:;]]

vim.keymap.set("i", "<C-_><c-_>", "System.out.println()<left>", { buffer = 0 })
vim.keymap.set("n", "<C-_><c-_>", "oSystem.out.println()<left>", { buffer = 0 })

local c = require("wk/colors")

local setHl = function(k, v)
	vim.api.nvim_set_hl(0, k, v)
end

-- Java
setHl("@method.java", { link = "Function" })
setHl("@lsp.typemod.method.declaration.java", { link = "Function" })
setHl("@keyword.java", { fg = c.orange_java })
setHl("@include.java", { fg = c.orange_java })
setHl("@attribute.java", { fg = c.funkygreen2 })
setHl("@operator.java", { link = "Identifier" })
setHl("@lsp.type.class.java", { link = "Type" })
setHl("@method.call.java", { link = "@method" })
setHl("@lsp.type.modifier.java", { link = "Keyword" })
setHl("@lsp.type.property.java", { link = "Identifier" })
-- setHl("@variable.java", { fg = c.identifier })
-- setHl("@variable.builtin.java", { fg = c.identifier })
-- setHl("@constructor.java", { fg = c.identifier })
--
-- setHl("@parameter.java", { fg = c.identifier_lighter })
--
-- setHl("@field.java", { fg = c.variable })
--
--
-- setHl("@type.qualifier.java", { fg = c.orange_java })
--
-- setHl("@constant.java", { fg = c.yellow_bright })
--
-- setHl("@constant.builtin.java", { fg = c.orange_faded })
--
-- setHl("@type.builtin.java", { fg = c.brown_light })
-- setHl("@type.java", { fg = c.brown_light })
-- setHl("@punctuation.bracket.java", { fg = c.identifier })

-- setHl("@lsp.type.enum.java", { fg = c.green_sea })
-- setHl("@lsp.type.interface.java", { fg = c.green_sea })
-- setHl("@lsp.typemod.annotation.public.java", { fg = c.funkygreen2 })
setHl("@lsp.typemod.class.declaration.java", { link = "Function" })
-- setHl("@lsp.type.namespace.java", { fg = c.identifier })
-- setHl("@lsp.type.method.java", {})
-- setHl("@lsp.type.enumMember.java", { fg = c.type })
-- setHl("@constant.builtin.java", { fg = "#c0694e" })

-- local PROJECT_NAME = vim.fn.fnamemodify(fn.getcwd(), ":p:h:t")
local WORKSPACE_DIR = vim.fn.fnamemodify(vim.fn.getcwd(), ":s?/server/src.*?/.jdtconfig?")

---~~~~~~~~~~~~~~~~~ JDTLS

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

---~~~~~~~~~~~~~~~~~ CMP

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

capabilities.textDocument.semanticTokensProvider = nil

---~~~~~~~~~~~~~~~~~ Bundles / dap

local bundles = {}

vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(HOME .. "/.config/language-servers/vscode-java-test/server/*.jar", true), "\n")
)

local debug_bundle = vim.split(
	vim.fn.glob(
		HOME
			.. "/.config/language-servers/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
		true
	),
	"\n"
)

vim.list_extend(bundles, debug_bundle)

---~~~~~~~~~~~~~~~~~ Config

local lombok_jar = HOME .. "/.m2/repository/org/projectlombok/lombok/1.18.24/lombok-1.18.24.jar"

local configCmd = {

	"java",

	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-javaagent:" .. lombok_jar,
	"-Xmx1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",

	"-jar",
	vim.fn.glob(HOME .. "/.config/language-servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),

	"-configuration",
	HOME .. "/.config/language-servers/jdtls/config_linux",

	"-data",
	WORKSPACE_DIR,
}

---~~~~~~~~~~~~~~~~~

local root_dir = jdtls.setup.find_root({ "mvnw", "gradlew", "pom.xml", "build.gradle" })

if root_dir == "" then
	return
end

local config = {

	cmd = configCmd,
	-- on_attach = on_attach,
	capabilities = capabilities,
	root_dir = root_dir,
	-- root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),

	settings = {

		java = {

			runtimes = {
				{
					name = "JavaSE-20",
					path = "/usr/lib/jvm/java-20-openjdk/",
				},
			},

			import = { enabled = true },
			rename = { enabled = true },
			eclipse = { downloadSources = true },
			configuration = { updateBuildConfiguration = "interactive" },
			maven = { downloadSources = true },
			contentProvider = { preferred = "fernflower" },
			references = { includeDecompiledSources = true },
			format = { enabled = false },

			codeGeneration = {
				toString = {
					template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
				},
				useBlocks = true,
			},

			-- implementationsCodeLens = {
			-- 	enabled = true,
			-- },
			--
			-- referencesCodeLens = {
			-- 	enabled = true,
			-- },
			completion = {
				favoriteStaticMembers = {
					"org.hamcrest.MatcherAssert.assertThat",
					"org.hamcrest.Matchers.*",
					"org.hamcrest.CoreMatchers.*",
					"org.junit.jupiter.api.Assertions.*",
					"java.util.Objects.requireNonNull",
					"java.util.Objects.requireNonNullElse",
					"org.mockito.Mockito.*",
				},
				importOrder = {
					"java",
					"javax",
					"no",
					"com",
					"org",
				},
			},
			-- inlayHints = {
			-- 	parameterNames = {
			-- 		enabled = "all", -- literals, all, none
			-- 	},
			-- },
		},

		extendedClientCapabilities = extendedClientCapabilities,
		-- signatureHelp = { enabled = true },
		init_options = { bundles = bundles },

		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
	},
	flags = {
		allow_incremental_sync = true,
		server_side_fuzzy_completion = true,
	},
}

config["on_attach"] = function(client, bufnr)
	require("jdtls.dap").setup_dap_main_class_configs()
	-- require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require("jdtls").setup_dap()

	-- require("lsp_signature").on_attach(client, bufnr)

	-- map("n", "<leader>tc", "<cmd>lua require(jdtls).test_class()<cr>", opts)
	-- map("n", "<leader>tm", "<cmd>lua require(jdtls).test_nearest_method()<cr>", opts)

	vim.cmd([[
  command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
  ]])
	vim.cmd([[
  command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
  ]])
	vim.cmd([[ command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config() ]])
	vim.cmd([[ command! -buffer JdtJol lua require('jdtls').jol() ]])
	vim.cmd([[ command! -buffer JdtBytecode lua require('jdtls').javap() ]])
	vim.cmd([[ command! -buffer JdtJshell lua require('jdtls').jshell() ]])
end

require("jdtls").start_or_attach(config)

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
-- 	pattern = { "*.java" },
-- 	callback = function()
-- 		local _, _ = pcall(vim.lsp.codelens.refresh)
-- 	end,
-- })

---~~~~~~~~~~~~~~~~~ opts
-- vim.opt_local.signcolumn = "yes:1"

vim.opt_local.cmdheight = 1
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2
vim.opt_local.shiftwidth = 2
