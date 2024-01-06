local M = {}

function M.config()
    M.setup()
    M.set_keymaps()
    vim.schedule(M.set_highlights)
end

function M.setup()
    require("telescope").setup({
        defaults = {
            selection_caret = "  ",
            dynamic_preview_title = true,
            results_title = false,

            file_ignore_patterns = {
                "package.json",
                "package%-lock.json",
                "jsconfig.json",
                "tsconfig.json",
                "prettierrc.json",
                "node_modules",
                "README.md",

                "vite.config.*",
                "svelte.config.*",

                "fonts/*",
                "*.png",
                "*.jpeg",
                "*.jpg",
                "*.webp",
            },

            prompt_prefix = "    ",
            color_devicons = true,
            sorting_strategy = "ascending",
            borderchars = { " ", "│", " ", " ", " ", " ", " ", " " },
            layout_strategy = "horizontal",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                    results_width = 0.8,
                },
                width = 0.7,
                height = 0.8,
                preview_cutoff = 120,
            },
        },

        pickers = {
            find_files = {
                prompt_title = "FIND",
                preview = false,
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close,
                    },
                },

                jumplist = {
                    prompt_title = "Jumplist",
                },

                lsp_references = {
                    prompt_title = "LSP References",
                },

                live_grep = {
                    prompt_title = "Live Grep",
                },

                quickfix = {
                    prompt_title = "Quickfix",
                },

                quickfixhistory = {
                    prompt_title = "Quickfix History",
                },

                buffers = {
                    prompt_title = "Buffers",
                    mappings = {
                        n = {
                            ["dd"] = require("telescope.actions").delete_buffer,
                        },
                    },
                },
            },

            extensions = {
                fzf = {
                    fuzzy = true,                   -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true,    -- override the file sorter
                    case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                },

                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
            },
        },
    })
end

M.set_keymaps = function()
    local map, leader = vim.keymap.set, function(mapping)
        return string.format("<leader>%s", mapping)
    end

    map("n", "<leader>h", function()
        require("telescope.builtin").find_files({ entry_maker = M.entry_maker(), })
    end, { desc = "Telescope find" })

    map("n", leader(leader("h")), function()
        require("telescope.builtin").find_files({ cwd = require("telescope.utils").buffer_dir() })
    end, { desc = "Telescope find files in current dir" })

    map("n", leader("sf"), function()
        require("telescope.builtin").live_grep({ cwd = require("telescope.utils").buffer_dir() })
    end, { desc = "Telescope live grep in current dir" })

    map("n", leader("ss"), function()
        require("telescope.builtin").lsp_document_symbols({ symbols = "function" })
    end, { desc = "Telescope lsp references" })

    map(
        "n",
        leader("s<leader>"),
        require("telescope.builtin").resume,
        { desc = "Telescope resume last opened floating interface" }
    )

    map("n", leader("sr"), require("telescope.builtin").lsp_references, { desc = "Telescope lsp references" })

    map("n", leader("f"), require("telescope.builtin").live_grep, { desc = "Telescope live grep" })
    map("n", leader("sd"), require("telescope.builtin").diagnostics, { desc = "Telescope diagnostics" })
    map("n", leader("s?"), require("telescope.builtin").help_tags, { desc = "Telescope help tags" })
    map("n", leader("sp"), require("telescope.builtin").registers, { desc = "Telescope registers" })
    map("n", leader("sm"), require("telescope.builtin").keymaps, { desc = "Telescope keymaps" })
    map("n", leader("so"), require("telescope.builtin").oldfiles, { desc = "Telescope oldfiles" })
    map("n", leader("b"), require("telescope.builtin").buffers, { desc = "Telescope buffers" })
    map("n", leader("sq"), require("telescope.builtin").quickfix, { desc = "Telescope quickfix" })
    map("n", leader("sbq"), require("telescope.builtin").quickfixhistory, { desc = "Telescope quickfix history" })
    map("n", leader("sh"), require("telescope.builtin").highlights, { desc = "Telescope highlights" })

    map(
        "n",
        leader("st"),
        "<cmd>lua require('telescope').extensions.git_worktree.git_worktrees()<cr>",
        { desc = "Git worktrees" }
    )
    map(
        "n",
        leader("sT"),
        "<cmd>lua require('telescope').extensions.git_worktree.create_git_worktree()<cr>",
        { desc = "Git new worktree" }
    )
end

M.set_highlights = function()
    local hl = require("wk/util").hl
    local c = require("wk/colors")
    local c_dark = "#1f2022"
    local c_darker = c.bg_mid_dark
    local c_path = "#98a9a8"
    local c_text = c.green_soft

    hl("TelescopePath", { fg = c_path, italic = false })
    hl("TelescopeFilename", { fg = c_text })

    hl("TelescopeNormal", { fg = c_text, bg = c_darker })
    hl("TelescopePromptNormal", { fg = c.cyan, bg = c_dark })

    hl("TelescopeSelection", { bg = "#202123" })

    hl("TelescopePromptTitle", { fg = c_text })
    hl("TelescopeResultsTitle", { fg = c_text })
    hl("TelescopePreviewTitle", { fg = c_text })

    hl("TelescopeBorder", { fg = c_darker, bg = c_darker })
    hl("TelescopePreviewBorder", { fg = c_dark, bg = c_dark })

    hl("TelescopePromptCounter", { fg = c_text })
    hl("TelescopePreviewMessage", { fg = "#555555" })

    -- hl("TelescopeMatching", { fg = c.green_soft })
end

M.entry_maker = function(opts)
    local utils = require("telescope.utils")
    local Path = require("plenary.path")

    opts = opts or {}

    local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())

    local disable_devicons = opts.disable_devicons

    local mt_file_entry = {}

    mt_file_entry.cwd = cwd

    mt_file_entry.display = function(entry)
        local display = utils.transform_path(opts, entry.value)
        local highlights = {}

        local icon_hl, icon
        display, icon_hl, icon = utils.transform_devicons(entry.value, display, disable_devicons)

        if icon_hl then
            table.insert(highlights, { { 0, #icon }, icon_hl })
        end

        local fname_len = display:reverse():find("/")

        if fname_len ~= nil then
            local pathEnd = #display - fname_len + 1
            table.insert(highlights, { { #icon + 1, pathEnd }, "TelescopePath" })
            table.insert(highlights, { { pathEnd + 1, pathEnd + fname_len }, "TelescopeFilename" })
        end

        return #highlights and display, highlights or display
    end

    mt_file_entry.__index = function(t, k)
        local override = M.handle_entry_index(opts, t, k)
        if override then
            return override
        end

        local raw = rawget(mt_file_entry, k)
        if raw then
            return raw
        end

        if k == "path" then
            local retpath = Path:new({ t.cwd, t.value }):absolute()
            if not vim.loop.fs_access(retpath, "R") then
                retpath = t.value
            end
            return retpath
        end

        return rawget(t, rawget(M.lookup_keys, k))
    end

    if opts.file_entry_encoding then
        return function(line)
            line = vim.iconv(line, opts.file_entry_encoding, "utf8")
            return setmetatable({ line }, mt_file_entry)
        end
    else
        return function(line)
            return setmetatable({ line }, mt_file_entry)
        end
    end
end

M.lookup_keys = {
    ordinal = 1,
    value = 1,
    filename = 1,
    cwd = 2,
}

M.handle_entry_index = function(opts, t, k)
    local override = ((opts or {}).entry_index or {})[k]
    if not override then
        return
    end

    local val, save = override(t, opts)
    if save then
        rawset(t, k, val)
    end
    return val
end

return M
