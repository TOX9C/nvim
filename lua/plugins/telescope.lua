--@diagnostic disable: undefined-global
return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-telescope/telescope-live-grep-args.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local lga_actions = require("telescope-live-grep-args.actions")

		telescope.setup({
			defaults = {
				layout_config = {
					anchor = "center",
					height = 0.8,
					width = 0.9,
					prompt_position = "bottom",
				},
				mappings = {
					i = {
						["<esc>"] = actions.close, -- Close Telescope in insert mode
					},
				},
			},
			extensions = {
				live_grep_args = {
					auto_quoting = true, -- Auto quote multi-word search
					mappings = {
						i = {
							["<c-\\>"] = lga_actions.quote_prompt({ postfix = " --hidden " }), -- Add `--hidden` to grep
						},
					},
				},
				file_browser = {
					depth = false,
					auto_depth = true,
					hidden = true, -- Show hidden files/folders
					hide_parent_dir = false,
					collapse_dirs = false,
					prompt_path = false,
					quiet = false,
					dir_icon = "󰉓 ",
					dir_icon_hl = "Default",
					display_stat = { date = true, size = true, mode = true },
					git_status = true,
				},
			},
		})

		-- Load extensions
		telescope.load_extension("file_browser")
		telescope.load_extension("live_grep_args")

		local map = vim.keymap.set

		vim.api.nvim_create_user_command("LiveGrep", function()
			telescope.extensions.live_grep_args.live_grep_args({
				prompt_title = "Live Grep",
				additional_args = "-i", -- Case-insensitive grep
			})
		end, { desc = "Live grep with extra arguments" })
		map("n", "\\", "<cmd>LiveGrep<cr>", { desc = "Live grep" })

		map("n", "<leader>f", function()
			telescope.extensions.file_browser.file_browser()
		end, { desc = "Browse files" })
	end,
}
