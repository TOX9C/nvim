---@diagnostic disable: undefined-global
return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = { ui = { border = "rounded" } },
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" }, -- Ensure mason is loaded first
		opts = {
			ensure_installed = { "lua_ls" }, -- Use the correct name here
		},
	},
}
