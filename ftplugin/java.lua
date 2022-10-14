vim.opt_local.cmdheight = 1

local utils = require("config.utils")
local paths = require("config.paths")
local lspDefaults = require("config.lsp")

local nnoremap = utils.bind("n")
local inoremap = utils.bind("i")

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
	return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
	return
end

--[[
]]
--

dap.defaults.fallback.external_terminal = {
	command = "/usr/bin/alacritty",
	args = { "-e" },
}

--dap.defaults.fallback.force_external_terminal = true

if vim.fn.has("mac") == 1 then
	WORKSPACE_PATH = paths.HOME .. "/code/java/"
	CONFIG = "mac"
elseif vim.fn.has("unix") == 1 then
	WORKSPACE_PATH = paths.HOME .. "/code/java/"
	CONFIG = "linux"
elseif vim.fn.has("win32") == 1 then
	WORKSPACE_PATH = paths.HOME .. "/code/java/"
	CONFIG = "windows"
else
	print("Unsupported system")
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = jdtls.setup.find_root(root_markers)

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

JAVA_DAP_ACTIVE = true

local bundles = {}

if JAVA_DAP_ACTIVE then
	vim.list_extend(
		bundles,
		vim.split(vim.fn.glob(paths.HOME .. "/.config/nvim/misc/vscode-java-test/server/*.jar"), "\n")
	)
	vim.list_extend(
		bundles,
		vim.split(
			vim.fn.glob(
				paths.HOME
					.. "/.config/nvim/misc/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
			),
			"\n"
		)
	)
end

local config = {
	cmd = {

		-- 💀
		"/usr/lib/jvm/java-18-openjdk/bin/java", -- or '/path/to/java17_or_newer/bin/java'
		-- depends on if `java` is in your $PATH env variable and if it points to the right version.

		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- 💀
		"-jar",
		paths.HOME .. "/.config/nvim/misc/jdtls/src/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
		-- Must point to the                                                     Change this to
		-- eclipse.jdt.ls installation                                           the actual version

		-- 💀
		"-configuration",
		paths.HOME .. "/.config/nvim/misc/jdtls/src/config_" .. CONFIG,
		-- Must point to the                      Change to one of `linux`, `win` or `mac`
		-- eclipse.jdt.ls installation            Depending on your system.

		-- 💀
		-- See `data directory configuration` section in the README
		"-data",
		workspace_dir,
	},

	on_attach = function()
		require("jdtls.dap").setup_dap_main_class_configs()
		require("jdtls").setup_dap({ hotcodereplace = "auto" })

		lspDefaults.on_attach()
	end,
	capabilities = capabilities,

	root_dir = root_dir,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {

			extendedClientCapabilities = extendedClientCapabilities,

			eclipse = {
				downloadSources = true,
			},

			configuration = {
				updateBuildConfiguration = "interactive",
			},

			maven = {
				downloadSources = true,
			},

			signatureHelp = {
				enabled = true,
			},

			contentProvider = { preferred = "fernflower" },

			flags = {
				allow_incremental_sync = true,
			},

			--[[
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      ]]
			--

			format = {
				enabled = false,
			},
		},
	},

	-- Language server `initializationOptions`
	-- You need to extend the `bundles` with paths to jar files
	-- if you want to use additional eclipse.jdt.ls plugins.
	--
	-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
	--
	-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
	init_options = {
		bundles = bundles,
	},
}
-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.

--[[
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"
]]
--

require("jdtls").start_or_attach(config)

local c = require("config.colors")

local cl = {
	black = "#000000",
	text = "#a0afd9",
	var = "#a88bb6",
	orange = "#de7621",
	yellow = "#fec671",
}

local highlightList = {
	-- TSType = { fg = cl.text },
	--
	TSType = { fg = c.identifier },
	TSVariable = { fg = c.variable },
	TSTypeBuiltin = { fg = c.const },
	TSOperator = { fg = c.identifier },
	TSPunctDelimiter = { fg = c.identifier },
	TSPunctBracket = { fg = c.identifier },
	-- TSField = { fg = cl.var },
	--
	-- TSVariableBuiltin = { fg = cl.orange },
	-- TSKeywordOperator = { fg = cl.orange },
	-- TSException = { fg = cl.orange },
	-- TSRepeat = { fg = cl.orange },

	--[[
  javaExternal = { fg = cl.orange },
  storageClass = { fg = cl.orange },
  Type = { fg = cl.orange },
  Typedef = { fg = cl.orange },
  Variable = { bg = cl.black },
  Field = { bg = cl.black },
  Method = { bg = cl.black },
  ]]
	--
}

for k, v in pairs(highlightList) do
	vim.api.nvim_set_hl(0, k, v)
end

local map = require("config/keymaps")

local function dapmap(_fn, _src)
	local req = '<Cmd>lua require("' .. _src .. '").'
	local command = req .. _fn .. "<CR>"

	return command
end
map("n", "<A-6>", dapmap("toggle({reset = true})", "dapui"))

map("n", "<A-8>", dapmap("continue()", "dap"))
map("n", "<A-i>", dapmap("run_last()", "dap"))

map("n", "<A-j>", dapmap("eval()", "dapui"))
map("v", "<A-j>", dapmap("eval()", "dapui"))
map("n", "<A-u>", dapmap("eval(vim.fn.input('[Expression] > '))", "dapui"))

map("n", "<A-h>", dapmap("toggle_breakpoint()", "dap"))
map("n", "<A-k>", dapmap("step_over()", "dap"))
map("n", "<A-l>", dapmap("step_into()", "dap"))
map("n", "<A-;>", dapmap("step_out()", "dap"))

map("n", "<A-0>", "<Cmd>DapTerminate<CR>")
-- map("n", "<A-6>", dapmap("toggle({reset = true})", "dapui"))
--
-- map("n", "<A-8>", dapmap("continue()", "dap"))
-- map("n", "<A-e>", dapmap("run_last()", "dap"))
--
-- map("n", "<A-f>", dapmap("eval()", "dapui"))
-- map("v", "<A-f>", dapmap("eval()", "dapui"))
-- map("n", "<A-r>", dapmap("eval(vim.fn.input('[Expression] > '))", "dapui"))
--
-- map("n", "<A-g>", dapmap("toggle_breakpoint()", "dap"))
-- map("n", "<A-d>", dapmap("step_over()", "dap"))
-- map("n", "<A-s>", dapmap("step_out()", "dap"))
-- map("n", "<A-a>", dapmap("step_into()", "dap"))
--
-- map("n", "<A-0>", "<Cmd>DapTerminate<CR>")

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	expand_lines = vim.fn.has("nvim-0.7"),
	layouts = {
		--[[
    {
      elements = {
        -- Elements can be strings or table with id and size keys.
       --{ id = "scopes", size = 0.25 },
        --"scopes",
        "repl",
        "breakpoints",
        -- "stacks",
        -- "watches",
      },
      size = 40, -- 40 columns
      position = "right",
    },
    ]]
		--
		{
			elements = {
				"console",
			},
			size = 40,
			position = "right",
		},
		{
			elements = {
				"repl",
				"breakpoints",
				-- "console",
			},
			size = 40,
			position = "right",
			-- size = 0.25, -- 25% of total lines
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = 0.25, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
	},
})

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close({})
	-- dapui.open({})
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close({})
end

require("nvim-dap-virtual-text").setup()
