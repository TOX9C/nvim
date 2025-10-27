---@diagnostic disable: undefined-global
return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	lazy = false,
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"javascript",
			"typescript",
			"tsx",
			"python",
			"html",
			"css",
			"json",
			"yaml",
			"lua",
			"rust",
			"vhdl",
		},
		highlight = { enable = true, additional_vim_regex_highlighting = false },
		indent = { enable = true },
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
