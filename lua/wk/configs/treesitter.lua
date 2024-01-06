M = {}

function M.config()
    require("nvim-treesitter.configs").setup({
        sync_install = false,

        ensure_installed = {
            "javascript",
            "typescript",
            "tsx",
            "svelte",
            "css", -- "scss", "sass",
            "html",
            "jsdoc",
            "json",
            "json5",
            "lua",
            "vim",
            "vimdoc",
            "markdown",
            "markdown_inline",
            "bash",
            "regex",
            "rust",
            "toml",
            "java",
            "c",
            "cpp",
            "arduino",
            "graphql"
            -- "awk",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
        autotag = {
            enable = true,
        },
        -- textobjects = M.textobjects,
    })
end

M.textobjects = {
    select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        include_surrounding_whitespace = true,

        keymaps = {
            ["if"] = { query = "@function.inner", desc = "Select inner part of a function" },
            ["af"] = { query = "@function.outer", desc = "Select outer part of a function" },
            ["im"] = { query = "@class.inner", desc = "Select inner part of a class" },
            ["am"] = { query = "@class.outer", desc = "Select outer part of a class" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },

        selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V",  -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
        },
    },

    move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist

        -- Go to closest
        goto_next = {},
        goto_previous = {},

        -- Go to end
        goto_next_end = {
            ["]S"] = "@class.outer",
            ["]d"] = "@conditional.outer",
        },
        goto_previous_end = {
            ["[S"] = "@class.outer",
        },

        -- Go to start
        goto_next_start = {
            ["]i"] = "@number.inner",
            ["]s"] = { query = "@class.outer", desc = "Next class start" },
            ["]a"] = "@assignment.rhs",
            [")"] = {
                query = { "@parameter.inner" },
                desc = "Next ",
            },
            ["]f"] = {
                query = { "@function.outer" },
                desc = "Next function.outer ",
            },
        },
        goto_previous_start = {
            ["("] = {
                query = { "@parameter.inner" },
                desc = "Next ",
            },
            ["[{"] = {
                query = { "@function.outer" },
                desc = "Previous function.outer",
            },

            ["[f"] = "@function.outer",
            ["[s"] = "@class.outer",
            ["[i"] = "@number.inner",
            ["[a"] = "@assignment.lhs",
            ["[d"] = "@conditional.outer",
        },
    },

    lsp_interop = {
        enable = true,
        border = "rounded",
        peek_definition_code = {
            ["<leader>K"] = "@function.outer",
            ["gK"] = "@class.outer",
        },
        floating_preview_opts = {},
    },

};

return M
