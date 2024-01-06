local M = {}

M.indent_insert = function(mode)
    return function()
        return #vim.fn.getline(".") == 0 and [["_cc]] or mode
    end
end

M.nav_file_sibling = function(direction)
    return function()
        vim.cmd.NvimTreeFocus()
        require("nvim-tree.api").node.navigate.sibling[direction]()
        require("nvim-tree.api").node.open.edit()
    end
end

function M.scrollie(command, lines)
    if not lines then
        local win_lines = vim.fn.winheight(0)

        if win_lines < 10 then
            lines = 5
            goto continue
        end

        lines = math.floor((win_lines / 2))
    end

    ::continue::
    return table.concat({ "m'", lines, command })
end

M.scroll = {
    big = {
        down = function()
            return M.scrollie("gj")
        end,
        up = function()
            return M.scrollie("gk")
            -- return vim.cmd.norm(vim.v.count1 * 10 .. "gj")
        end,
    },
    small = {
        down = function()
            return M.scrollie("gj", 10)
        end,
        up = function()
            return M.scrollie("gk", 10)
        end,
    },
    tiny = {
        down = function()
            return M.scrollie("gj", 5)
        end,
        up = function()
            return M.scrollie("gk", 5)
        end,
    },
}

M.git_readme = function()
    vim.cmd.e(table.concat({ vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]), "/README.md" }))
end

M.hlsearch = function()
    if vim.v.hlsearch ~= 1 then
        vim.opt.hlsearch = true
    else
        vim.opt.hlsearch = false
    end
end

M.del_line_no_yank = function()
    return vim.api.nvim_get_current_line():match("^%s*$") and '"_dd' or "dd"
end

TScopeBuiltIn, TScopeUtils = require("telescope.builtin"), require("telescope.utils")
M.find_in_current = function()
    TScopeBuiltIn.find_files({ cwd = TScopeUtils.buffer_dir() })
end
M.grep_in_current = function()
    TScopeBuiltIn.live_grep({ cwd = TScopeUtils.buffer_dir() })
end

return M
