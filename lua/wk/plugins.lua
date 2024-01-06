local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = {
    dev = {
        path = "/home/weskeiser/.config/dev_nvim"
    },
    checker = {
        enabled = true,
        notify = false,
        concurrency = 1,
        frequency = 10000
    },
    -- profiling = {
    --     loader = true,
    --     require = true
    -- }
}

local links = {
    svelte_hop = "/home/weskeiser/.config/nvim_dev/svelte-hop.nvim",
    popup = "nvim-lua/popup.nvim",
    plenary = "nvim-lua/plenary.nvim",

    nvim_cmp = "hrsh7th/nvim-cmp",
    cmp_nvim_lsp = "hrsh7th/cmp-nvim-lsp",
    cmp_buffer = "hrsh7th/cmp-buffer",
    luasnip = "L3MON4D3/LuaSnip",

    lsp_zero = "VonHeikemen/lsp-zero.nvim",
    mason = "williamboman/mason.nvim",
    mason_lspconfig = "williamboman/mason-lspconfig.nvim",
    lspkind_nvim = "onsails/lspkind-nvim",
    nvim_lspconfig = "neovim/nvim-lspconfig",

    rust_tools = "simrat39/rust-tools.nvim",
    neodev = "folke/neodev.nvim",
    vscode_js_debug = "microsoft/vscode-js-debug",

    nvim_tree = "nvim-tree/nvim-tree.lua",

    telescope = "nvim-telescope/telescope.nvim",
    telescope_ui_select = "nvim-telescope/telescope-ui-select.nvim",
    telescope_media_files = "nvim-telescope/telescope-media-files.nvim",
    telescope_fzf_native = "nvim-telescope/telescope-fzf-native.nvim",
    git_worktree = "ThePrimeagen/git-worktree.nvim",

    treesitter = "nvim-treesitter/nvim-treesitter",
    treesitter_textobjects = "nvim-treesitter/nvim-treesitter-textobjects",
    ts_context_commentstring = "JoosepAlviste/nvim-ts-context-commentstring",

    colorizer = "norcalli/nvim-colorizer.lua",
    nvim_web_devicons = "nvim-tree/nvim-web-devicons",
    material = "marko-cerovac/material.nvim",

    nvim_ts_autotag = "windwp/nvim-ts-autotag",
    nvim_autopairs = "windwp/nvim-autopairs",
    nvim_lastplace = "ethanholz/nvim-lastplace",

    gitsigns = "lewis6991/gitsigns.nvim",
    markdown_preview = "iamcco/markdown-preview.nvim",
    trouble = "folke/trouble.nvim",
    comment = "numToStr/Comment.nvim",

    harpoon = "ThePrimeagen/harpoon",
    copilot = "zbirenbaum/copilot.lua",
    fugitive = "tpope/vim-fugitive",
    nvim_surround = "kylechui/nvim-surround",

    nvim_dap = "mfussenegger/nvim-dap",
    nvim_dap_ui = "rcarriga/nvim-dap-ui",
    nvim_dap_vscode_js = "mxsdev/nvim-dap-vscode-js",
    nvim_dap_virtual_text = "theHamsta/nvim-dap-virtual-text",

    dadbod = "tpope/vim-dadbod",
    dadbod_ui = "kristijanhusak/vim-dadbod-ui",
    dadbod_completion = "kristijanhusak/vim-dadbod-completion",
}

require("lazy").setup({
    {
        dir = links.svelte_hop,
        dev = true,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("svelte-hop").setup({
                statusline = { enabled = true },
            })
        end,
    },
    { links.popup },
    { links.plenary },
    {
        links.nvim_cmp,
        event = "VimEnter",
        dependencies = {
            links.cmp_nvim_lsp,
            links.cmp_buffer,
            links.luasnip,
        },
        config = require("wk.configs.cmp").config,
    },

    {
        links.lsp_zero,
        dependencies = {
            { links.mason },
            { links.mason_lspconfig },
            { links.lspkind_nvim },
            { links.nvim_lspconfig },
            { links.nvim_cmp },
            { links.luasnip },
        },
        config = require("wk.configs.lsp").config,
    },

    {
        links.telescope,
        config = require("wk.configs.telescope").config,
        dependencies = { links.plenary },
    },

    {
        links.git_worktree,
        lazy = true,
        config = function()
            require("git-worktree").setup()
        end,
        dependencies = { links.telescope },
    },

    {
        links.telescope_fzf_native,
        config = function()
            require("telescope").load_extension("fzf")
        end,
        build = "make",
    },
    {
        links.telescope_ui_select,
        config = function()
            require("telescope").load_extension("ui-select")
        end,
        dependencies = { links.telescope },
    },
    {
        links.telescope_media_files,
        config = function()
            require("telescope").load_extension("media_files")
        end,
        dependencies = { links.telescope },
    },
    {
        links.nvim_ts_autotag,
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        links.nvim_autopairs,
        opts = {
            check_ts = true,
            map_cr = true,
        },
    },
    {
        links.treesitter,
        build = ":TSUpdate",
        config = require("wk.configs.treesitter").config,
        -- lazy = true,
    },
    {
        links.treesitter_textobjects,
        dependencies = { links.treesitter },
    },
    {
        links.nvim_tree,
        config = require("wk.configs.nvim-tree").config,
    },
    {
        links.nvim_lastplace,
        config = function()
            require("nvim-lastplace").setup()
        end,
    },
    {
        links.material,
        priority = 1000,
        lazy = false,
        -- config = require("wk.configs.material").config,
    },

    { links.neodev,     ft = "lua" },
    {
        links.colorizer,
        event = "VimEnter",
        ft = { "lua", "svelte" },
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        links.nvim_web_devicons,
        opts = {
            default = true,
            override = {
                svelte = {
                    icon = "S",
                    cterm_color = "1",
                    name = "svelte",
                    color = "#c68687",
                },
            },
        },
    },
    { links.trouble,    dependencies = "nvim-tree/nvim-web-devicons" },
    { links.rust_tools, ft = "rust" },
    {
        links.nvim_dap,
        config = require("wk.configs.dap").config,
        lazy = true,
        keys = {
            { "<leader>dl", "<leader>da" },
        },
        dependencies = {
            links.nvim_dap_ui,
            links.nvim_dap_vscode_js,
            links.nvim_dap_virtual_text,
            {
                links.vscode_js_debug,
                version = "1.x",
                build = "npm i && npm run compile vsDebugServerBundle && rm -rf out && mv dist out",
            },
        },
    },
    {
        links.markdown_preview,
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = require("wk.configs.markdownpreview").config,
    },
    {
        links.gitsigns,
        config = require("wk.configs.gitsigns").config,
    },
    { links.fugitive },
    { links.ts_context_commentstring },
    {
        links.comment,
        config = require("wk.configs.comment").config,
        dependencies = { links.ts_context_commentstring },
    },
    {
        links.nvim_surround,
        config = function()
            require("nvim-surround").setup()
        end,
    },
    {
        links.harpoon,
        opts = require("wk.configs.harpoon").config,
    },
    {
        links.copilot,
        lazy = true,
        -- cmd = "Copilot",
        -- event = "VeryLazy",
        event = "VimEnter",
        opts = require("wk.configs.copilot").config,
    },
    { links.dadbod,            ft = "sql" },
    { links.dadbod_ui,         dependencies = links.dadbod },
    { links.dadbod_completion, dependencies = links.dadbod },
}, lazy_config)
