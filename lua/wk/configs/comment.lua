return {
    config = function()
        require("Comment").setup({

            padding = true,                   ---Add a space b/w comment and the line
            sticky = true,                    ---Whether the cursor should stay at its position
            -- ignore = nil, ---Lines to be ignored while (un)comment
            toggler = {                       ---LHS of toggle mappings in NORMAL mode
                line = "<leader>c<leader>",   ---Line-comment toggle keymap
                block = "<leader>cc<leader>", ---Block-comment toggle keymap
            },

            ---LHS of operator-pending mappings in NORMAL and VISUAL mode
            opleader = {
                line = "<leader>c",  ---Line-comment keymap
                block = "<leader>C", ---Block-comment keymap
            },

            ---LHS of extra mappings
            extra = {
                above = "<leader>cN", ---Add comment on the line above
                below = "<leader>cn", ---Add comment on the line below
                eol = "<leader>cA",   ---Add comment at the end of line
            },

            ---Enable keybindings
            ---NOTE: If given `false` then the plugin won't create any mappings
            mappings = {
                basic = true, ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
                extra = true, ---Extra mapping; `gco`, `gcO`, `gcA`
            },
            -- -Function to call before (un)comment
            pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            ---Function to call after (un)comment
            -- post_hook = nil,
        })
    end
}
