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

-----

--[[]]
local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

-- dapui.setup()
dapui.setup {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has "nvim-0.7",
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
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
    ]]--
    {
      elements = {
        "console",
      },
      size = 40,
      position = "right",
    },
    --[[
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
    ]]--
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
  },
}

--local icons = require "user.icons"
--vim.fn.sign_define("DapBreakpoint", { text = 'h', texthl = "DiagnosticSignError", linehl = "", numhl = "" })

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open {}
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close {}
  dapui.open {}
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close {}
end
--[[
]]--

dap.defaults.fallback.external_terminal = {
    command = '/usr/bin/alacritty';
    args = {'-e'};
  }

--dap.defaults.fallback.force_external_terminal = true

-----


-- Determine OS
local home = os.getenv "HOME"
if vim.fn.has "mac" == 1 then
  WORKSPACE_PATH = home .. "/code/java/"
  CONFIG = "mac"
elseif vim.fn.has "unix" == 1 then
  WORKSPACE_PATH = home .. "/code/java/"
  CONFIG = "linux"
elseif vim.fn.has "win32" == 1 then
  WORKSPACE_PATH = home .. "/code/java/"
  CONFIG = "windows"
else
  print "Unsupported system"
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = WORKSPACE_PATH .. project_name

-----

local status, jdtls = pcall(require, "jdtls")

if not status then
  return
end

--

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return
end

capabilities.textDocument.completion.completionItem.snippetSupport = false
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

--

JAVA_DAP_ACTIVE = true

local bundles = {}

if JAVA_DAP_ACTIVE then
  vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.config/nvim/vscode-java-test/server/*.jar"), "\n"))
  vim.list_extend(
    bundles,
    vim.split(
      vim.fn.glob(
        home .. "/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
      ),
      "\n"
    )
  )
end


-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    '/usr/lib/jvm/java-18-openjdk/bin/java', -- or '/path/to/java17_or_newer/bin/java'
            -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar', '/home/weskeiser/.config/nvim/jdtls/src/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
         -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
         -- Must point to the                                                     Change this to
         -- eclipse.jdt.ls installation                                           the actual version


    -- 💀
    '-configuration', home .. '/.config/nvim/jdtls/src/config_' .. CONFIG,
                    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
                    -- Must point to the                      Change to one of `linux`, `win` or `mac`
                    -- eclipse.jdt.ls installation            Depending on your system.


    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_dir
  },


    on_attach = function()
    require("jdtls").setup_dap { hotcodereplace = "auto" }
    require("jdtls.dap").setup_dap_main_class_configs()

    nnoremap("gd", function() vim.lsp.buf.definition() end)
    nnoremap("gD", function() vim.lsp.buf.declaration() end)
    nnoremap("gt", function() vim.lsp.buf.type_definition() end)
    nnoremap("gi", function() vim.lsp.buf.implementation() end)
    nnoremap("<leader>3", function() vim.diagnostic.goto_next() end)
    nnoremap("<leader>#", function() vim.diagnostic.goto_prev() end)
    nnoremap("<leader>e", function() vim.diagnostic.goto_next({
      severity = vim.diagnostic.severity.ERROR
    }) end)
    nnoremap("<leader>E", function() vim.diagnostic.goto_prev({
      severity = vim.diagnostic.severity.ERROR
    }) end)
    --nnoremap("<C-i>", function() vim.diagnostic.open_float() end)
    nnoremap("<leader>i", function() vim.lsp.buf.hover() end)
    nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
    nnoremap("<leader>r", function() vim.lsp.buf.code_action() end)
    nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
    nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
  end,


  capabilities = capabilities,


  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}),


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

      signatureHelp =  {
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
      ]]--

      format = {
        enabled = false,
      },
    }
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
]]--





require('jdtls').start_or_attach(config)


local cl = {
  black = '#000000',
  text = '#a0afd9',
  var = '#a88bb6',
  orange = '#de7621',
  yellow = '#fec671',
}

local highlightList = {
  TSType = { fg = cl.text },

  TSVariable = { fg = cl.var },
  TSField = { fg = cl.var },

  TSTypeBuiltin = { fg = cl.orange },
  TSVariableBuiltin = { fg = cl.orange },
  TSKeywordOperator = { fg = cl.orange },
  TSException = { fg = cl.orange },
  TSRepeat = { fg = cl.orange },

  --[[
  javaExternal = { fg = cl.orange },
  storageClass = { fg = cl.orange },
  Type = { fg = cl.orange },
  Typedef = { fg = cl.orange },
  Variable = { bg = cl.black },
  Field = { bg = cl.black },
  Method = { bg = cl.black },
  ]]--

}

for k, v in pairs(highlightList) do
  vim.api.nvim_set_hl(0, k, v)
end


local autocmd = vim.api.nvim_create_autocmd

--autocmd('BufLeave', {
  --command = "lua require('dapui').toggle()"
--})
