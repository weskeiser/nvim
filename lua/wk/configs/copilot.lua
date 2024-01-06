return {
    copilot_node_command = "node",     -- Node.js version must be > 16.x
    server_opts_overrides = {},

    panel = {
        enabled = false,
        auto_refresh = true,

        layout = {
            position = "right",     -- | top | left | right
            ratio = 0.5,
        },

        keymap = {
            jump_prev = "<F9>",
            jump_next = "<F10>",
            accept = "<C-F>",
            -- refresh = "gr",
            open = "<C-CR>",
        },
    },

    suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 25,

        keymap = {
            next = "<F9>",
            prev = "<F10>",
            accept = "<C-F>",
            accept_word = false,
            accept_line = false,
            dismiss = "<C-E>",
        },
    },

    filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
    },
}
