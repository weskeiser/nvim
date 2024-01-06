local M = {}

function M.config()
    local funs = require("wk.functions")
    local map = vim.keymap.set

    map("n", "<leader>ab", require("nvim-tree.api").tree.close, { desc = "NvimTree: Close" })
    map("n", "<leader>]", funs.nav_file_sibling("next"), { desc = "NvimTree: go to next file" })
    map("n", "<leader>[", funs.nav_file_sibling("prev"), { desc = "NvimTree: go to next file" })
    map("n", "<C-w><C-d>", function()
        require("nvim-tree.api").tree.toggle()
    end, { desc = "NvimTree: Toggle" })

    require("nvim-tree").setup({
        -- root_dirs = { "~/code/" },
        -- prefer_startup_root = false, -- default false
        -- hijack_cursor = true, -- default false

        on_attach = M.on_attach,
        reload_on_bufenter = true,   -- default false
        respect_buf_cwd = false,     -- default false
        sync_root_with_cwd = true,   -- default false
        auto_reload_on_write = true, -- default true

        sort = {
            sorter = "suffix",
            folders_first = true,
        },

        view = {
            centralize_selection = true, -- default false
            signcolumn = "yes",          -- default true
            side = "right",
            -- preserve_window_proportions = true, -- default false
        },

        update_focused_file = {
            enable = true, -- default false
            -- update_root = true, -- default false
        },

        renderer = {
            -- special_files = {},
            -- highlight_git = true,

            indent_width = 2,
            highlight_opened_files = "name",
            root_folder_label = false,

            indent_markers = {
                enable = false,
                icons = {
                    none = "│",
                    edge = "│",
                    item = "├",
                    corner = "╰",
                    bottom = "",
                },
            },

            icons = {
                git_placement = "signcolumn",
                padding = " ",
                show = {
                    file = true,
                    folder = true,
                    folder_arrow = false,
                    git = true,
                },
                glyphs = {
                    folder = {
                        -- open = "▾",
                        -- default = "·",
                        default = "",
                        open = "",

                        empty = "·",
                        empty_open = "·",
                        symlink = "",
                        symlink_open = "",
                    },
                    git = {
                        unstaged = "~",
                        deleted = "⋯",
                        staged = "·",
                        untracked = "+",
                    },
                },
            },
        },

        git = {
            show_on_open_dirs = false,
            ignore = false,
        },

        filters = {
            dotfiles = false,
        },

        actions = {
            open_file = {
                quit_on_open = false,
                window_picker = {
                    enable = false,
                },
            },

            -- change_dir = {
            -- restrict_above_cwd = true,
            -- },

            -- use_system_clipboard = true,
        },
    })

    function M.highlight()
        local c = require("wk/colors")
        local hl = require("wk/util").hl

        -- hl("NvimTreeStatusLineNC", { fg = "#788988", bg = c.bg_darker })
        hl("NvimTreeNormal", { fg = "#788988", bg = c.bg })
        hl("NvimTreeNormalNC", { fg = "#788988", bg = c.bg_darker })
        hl("NvimTreeOpenedFile", { fg = "#98a9a8" })

        hl("NvimTreeFolderName", { fg = "#99aa86" })
        hl("NvimTreeOpenedFolderName", { fg = "#a9ca76" })
        hl("NvimTreeEmptyFolderName", { fg = "#697a56" })

        hl("NvimTreeOpenedFolderIcon", { fg = "#aabbaa" })
        hl("NvimTreeClosedFolderIcon", { fg = "#aabbaa" })

        hl("NvimTreeLineNr", { fg = c.bg })
        hl("NvimTreeCursorLineNr", { fg = "#4a4a4a", bg = "#4a4a4a" })
        hl("NvimTreeCursorLine", { bg = "#4a4a4a" })

        hl("NvimTreeSignColumn", { bg = c.none })

        hl("NvimTreeGitStaged", { fg = c.fun2 })
        hl("NvimTreeGitNew", { fg = c.green_soft })
        hl("NvimTreeGitDirty", { fg = c.blue_nice })
        hl("NvimTreeGitDeleted", { fg = "#a66687" })

        hl("NvimTreeSpecialFile", { bold = true })
        hl("NvimTreeExecFile", { bg = c.none, fg = c.bluebright, blend = 5 })
    end
end

function M.on_attach(bufnr)
    local api = require("nvim-tree.api")
    local node, tree, fs = api.node, api.tree, api.fs
    local map = vim.keymap.set

    vim.schedule(M.highlight)

    api.events.subscribe(api.events.Event.TreeRendered, function()
        if api.tree.is_tree_buf() then
            vim.opt_local.statuscolumn = "%s"
        end
    end)

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    map("n", "<C-]>", tree.change_root_to_node, opts("CD"))
    map("n", "+", tree.change_root_to_node, opts("CD"))
    map("n", "<C-e>", node.open.replace_tree_buffer, opts("Open: In Place"))
    map("n", "<C-k>", node.show_info_popup, opts("Info"))
    map("n", "<C-r>", fs.rename_sub, opts("Rename: Omit Filename"))
    map("n", "<C-t>", node.open.tab, opts("Open: New Tab"))
    map("n", "<C-v>", node.open.vertical, opts("Open: Vertical Split"))
    map("n", "<C-x>", node.open.horizontal, opts("Open: Horizontal Split"))
    map("n", "<BS>", node.navigate.parent_close, opts("Close Directory"))
    map("n", "<CR>", node.open.edit, opts("Open"))
    map("n", "<Tab>", node.open.preview, opts("Open Preview"))

    map("n", "h", node.open.preview, opts("Open Preview"))

    map("n", "J", node.navigate.sibling.next, opts("Next Sibling"))
    map("n", "K", node.navigate.sibling.prev, opts("Previous Sibling"))
    map("n", ".", node.run.cmd, opts("Run Command"))
    map("n", "-", tree.change_root_to_parent, opts("Up"))
    map("n", "a", fs.create, opts("Create"))
    map("n", "bmv", api.marks.bulk.move, opts("Move Bookmarked"))
    map("n", "B", tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
    map("n", "c", fs.copy.node, opts("Copy"))
    map("n", "C", tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
    map("n", "[c", node.navigate.git.prev, opts("Prev Git"))
    map("n", "]c", node.navigate.git.next, opts("Next Git"))
    map("n", "d", fs.remove, opts("Delete"))
    map("n", "D", fs.trash, opts("Trash"))
    map("n", "E", tree.expand_all, opts("Expand All"))
    map("n", "e", fs.rename_basename, opts("Rename: Basename"))
    map("n", "]e", node.navigate.diagnostics.next, opts("Next Diagnostic"))
    map("n", "[e", node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
    map("n", "F", api.live_filter.clear, opts("Clean Filter"))
    map("n", "f", api.live_filter.start, opts("Filter"))
    map("n", "g?", tree.toggle_help, opts("Help"))
    map("n", "gy", fs.copy.absolute_path, opts("Copy Absolute Path"))
    map("n", "H", tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
    map("n", "I", tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
    map("n", ">", node.navigate.sibling.last, opts("Last Sibling"))
    map("n", "<", node.navigate.sibling.first, opts("First Sibling"))
    map("n", "m", api.marks.toggle, opts("Toggle Bookmark"))
    map("n", "o", node.open.edit, opts("Open"))
    map("n", "O", node.open.no_window_picker, opts("Open: No Window Picker"))
    map("n", "p", fs.paste, opts("Paste"))
    map("n", "P", node.navigate.parent, opts("Parent Directory"))
    map("n", "q", tree.close, opts("Close"))
    map("n", "<ESC>", tree.close, opts("Close"))
    map("n", "r", fs.rename, opts("Rename"))
    map("n", "R", tree.reload, opts("Refresh"))
    map("n", "s", node.run.system, opts("Run System"))
    map("n", "S", tree.search_node, opts("Search"))
    map("n", "U", tree.toggle_custom_filter, opts("Toggle Hidden"))
    map("n", "W", tree.collapse_all, opts("Collapse"))
    map("n", "x", fs.cut, opts("Cut"))
    map("n", "y", fs.copy.filename, opts("Copy Name"))
    map("n", "Y", fs.copy.relative_path, opts("Copy Relative Path"))
    map("n", "<2-LeftMouse>", node.open.edit, opts("Open"))
    map("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
end

return M
