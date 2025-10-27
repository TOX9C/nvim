---@diagnostic disable: undefined-global
return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = { ui = { border = "rounded" } },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "tsserver", "lua-language-server", "rust-analyzer", "ghdl" },
			})
		end,
	},
}
