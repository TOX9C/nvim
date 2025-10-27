---@diagnostic disable: undefined-global
return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local keymap = vim.keymap
		local api = require("nvim-tree.api")

		require("nvim-tree").setup({
			auto_reload_on_write = true,
			disable_netrw = false,
			hijack_netrw = true,
			hijack_cursor = false,
			hijack_unnamed_buffer_when_opening = false,
			open_on_tab = false,
			sort_by = "name",
			update_cwd = true, -- follow cwd

			view = {
				width = 30,
				side = "left",
				preserve_window_proportions = false,
				number = false,
				relativenumber = false,
				signcolumn = "yes",
			},

			renderer = {
				indent_markers = {
					enable = true,
					icons = {
						corner = "└ ",
						edge = "│ ",
						none = "  ",
					},
				},
				icons = {
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					webdev_colors = true,
				},
			},

			hijack_directories = {
				enable = true,
				auto_open = true,
			},

			update_focused_file = {
				enable = true,
				update_cwd = true,
				ignore_list = {},
			},

			system_open = { cmd = "", args = {} },

			diagnostics = {
				enable = true,
				show_on_dirs = false,
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},

			filters = { dotfiles = false, custom = {}, exclude = {} },

			git = { enable = true, ignore = true, timeout = 400 },

			actions = {
				use_system_clipboard = true,
				change_dir = { enable = true, global = false, restrict_above_cwd = false },
				open_file = {
					quit_on_open = false,
					resize_window = false,
					window_picker = {
						enable = true,
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
			},

			trash = { cmd = "trash", require_confirm = true },

			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					diagnostics = false,
					git = false,
					profile = false,
				},
			},
		})

		keymap.set("n", "<space>e", api.tree.toggle, { silent = true, desc = "Toggle nvim-tree" })
		keymap.set("n", "<CR>", api.node.open.edit, { desc = "Open file" })

		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			callback = function()
				local stat = vim.loop.fs_stat(vim.fn.getcwd())
				if stat and stat.type == "directory" then
					api.tree.open()
				end
			end,
		})
	end,
}
