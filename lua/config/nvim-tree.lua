require("nvim-tree").setup({
	sort_by = "case_sensitive",
	root_dirs = { "~/code/" },
	prefer_startup_root = false,
	auto_reload_on_write = true,
	reload_on_bufenter = true,
	respect_buf_cwd = true,
	sync_root_with_cwd = true,
	create_in_closed_folder = true,
	view = {
		adaptive_size = true,
		preserve_window_proportions = true,
		side = "bottom",
		centralize_selection = true,
		relativenumber = true,
		signcolumn = "yes",
		mappings = {
			list = {
				{ key = "<C-o>", action = "vsplit" },

				{ key = "<ESC>", action = "close" },
				{ key = "..", action = "dir_up" },
				{ key = "cd", action = "cd" },

				{ key = "w", action = "expand_all" },
				{ key = "e", action = "collapse_all" },

				{ key = "<C-k>", action = "" }, -- unset default
			},
		},
	},
	update_focused_file = {
		enable = true,
	},
	renderer = {
		highlight_git = false,
		highlight_opened_files = none,
		indent_markers = {
			enable = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				none = " ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
			},
		},
		group_empty = false,
	},
	filters = {
		dotfiles = false,
	},
	filesystem_watchers = {
		enable = true,
		debounce_delay = 50,
	},
	actions = {
		open_file = {
			quit_on_open = true,
			window_picker = {
				enable = false,
			},
		},
		use_system_clipboard = true,
		change_dir = {
			enable = true,
			global = false,
		},
	},
})
