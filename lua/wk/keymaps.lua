return {
    setup = function()
        local funs = require("wk.functions")
        local map = vim.keymap.set
        local leader = function(mapping)
            return string.format("<leader>%s", mapping)
        end

        map("", "gs", "<nop>")

        -- map("i", "<C-c>", function()
        --     vim.cmd.doautocmd("InsertLeavePre")
        --     return "<C-c>"
        -- end, { desc = "Trigger InsertLeave on Ctrl-c", expr = true })
        map("i", "<C-c>", "<nop>")

        map("n", "z", "<C-z>")

        -- map("n", "-", "%", { desc = "Remapped to percent (%)" })

        map({ "n", "x", "o" }, "<BS>", "/", { desc = "Search (/)" })
        map({ "n", "x", "o" }, "<leader><BS>", "?", { desc = "Search backwards (?)" })

        map("o", "w", "e", { desc = "w to e" })
        map("o", "W", "E", { desc = "W to E" })

        map("n", "<c-h>", "<c-w>h", { desc = "Navigate window left" })
        map("n", "<c-l>", "<c-w><c-l>", { desc = "Navigate window right" })

        map({ "n", "x", "o" }, "L", "$", { desc = "Go to end of line ($)" })
        map({ "n", "x", "o" }, "H", "^", { desc = "Go to first non-blank in line (^)" })

        map("n", "n", "n<cmd>set hlsearch<CR>", { desc = "Search with hlsearch" })
        map("n", "N", "N<cmd>set hlsearch<CR>", { desc = "Search with hlsearch" })
        map("n", "*", "*<cmd>set hlsearch<CR>", { desc = "Search with hlsearch" })
        map("n", "#", "#<cmd>set hlsearch<CR>", { desc = "Search with hlsearch" })
        map("n", "<esc>", "<esc><cmd>nohl<CR>", { desc = "Search with hlsearch" })
        map("n", leader("l"), funs.hlsearch, { desc = "Toggle hlsearch" })

        map("n", "X", "0dg$", { desc = "Delete contents of line" })

        map("n", "%", "%", { desc = "Fix for strange matchit issue" })

        map("n", "{", ':<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>', { desc = "Don't pollute my jumplist!" })
        map("n", "}", ':<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>', { desc = "Don't pollute my jumplist!" })

        map("n", leader("er"), funs.git_readme, { desc = "Shortcut to README" })

        map("n", leader("t"), "<c-^>", { desc = "Navigate to alternate file" })

        -- map("n", leader("xt"), "<cmd>TroubleToggle quickfix<cr>", { desc = "Trouble: toggle" })

        map({ "n", "v", "i" }, "<c-q>", function()
            vim.cmd.q({ bang = true })
        end, { desc = ":q!" })

        map({ "n", "v", "i" }, "<c-s>", "<esc><cmd>:w<cr>", { desc = "Save" })

        map("n", "J", "mzJ`z", { desc = "Join next line without moving" })

        for _, key in ipairs({ "c", "y", "g" }) do
            map("n", key .. "<leader>", key .. key, { desc = "Letter twice" })
        end

        map("n", "dd", funs.del_line_no_yank, { expr = true, desc = "Delete line" })
        map("n", "d<leader>", funs.del_line_no_yank, { expr = true, desc = "Delete line" })

        map("", '"<leader>', '"+', { desc = "Copy to clipboard +" })

        map("v", "<", "<gv", { desc = "Keep visual selection when indenting left" })
        map("v", ">", ">gv", { desc = "Keep visual selection when indenting right" })

        --~~~ Insert mode
        map("i", "<c-l>", "<del>", { desc = "Delete forward in insert mode" })

        map("i", "<c-k>", "<c-g>k",
            { desc = "Navigate up one line in insert mode. Stays in same column as insert-enter." })
        map(
            "i",
            "<c-j>",
            "<c-g>j",
            { desc = "Navigate down one line in insert mode. Stays in same column as insert-enter." }
        )

        -- map("n", "i", funs.indent_insert("i"), { expr = true, desc = "Indent after entering insert mode" })
        -- map("n", "a", funs.indent_insert("a"), { expr = true, desc = "Indent after entering insert mode" })

        map("n", "[o", ":put!=repeat(nr2char(10), v:count1)<cr>", { desc = "Append empty line(s) above" })
        map("n", "]o", ":put=repeat(nr2char(10), v:count1)<cr>", { desc = "Append empty line(s) below" })


        map("n", leader("si"), ":Inspect<cr>", { desc = "Inspect treesitter objects" })


        function GStatusMapping()
            vim.cmd(vim.fn.expand("%"):match("^fugitive://") and "q" or "G")
        end

        map("n", leader("gd"), "<cmd>Gvdiff<cr><c-w>x", { desc = "Git vdiff" })
        map("n", leader("m"), GStatusMapping, { desc = "Git status panel" })

        -- ~~~ NvimTree

        map({ "n", "v" }, "<C-u>", funs.scroll.big.up, { expr = true, desc = "Scroll by 20" })
        map({ "n", "v" }, "<C-d>", funs.scroll.big.down, { expr = true, desc = "Scroll by 20" })

        map({ "n", "v" }, "<C-y>", funs.scroll.small.up, { expr = true, desc = "Scroll by 10" })
        map({ "n", "v" }, "<C-e>", funs.scroll.small.down, { expr = true, desc = "Scroll by 10" })


        -- local function move(command)
        -- 	return function()
        -- 		local count = vim.v.count1
        --            local reg = vim.fn.getreg()
        --
        -- 		if count > 1 then
        --                reg = "m'"
        -- 			return table.concat({ "m'", count, command })
        -- 		else
        -- 			-- return table.concat({ command })
        -- 			return command
        -- 		end
        -- 	end
        -- end
        --
        -- map("n", "k", move("gk"), { expr = true, desc = "Move" })
        -- map("n", "j", move("gj"), { expr = true, desc = "Move" })
    end
}
