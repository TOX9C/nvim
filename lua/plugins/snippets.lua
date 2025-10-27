---@diagnostic disable: undefined-global
return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			local luasnip = require("luasnip")
			luasnip.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})
			-- keymaps if you didn't set them in cmp file
			vim.keymap.set({ "i", "s" }, "<Tab>", function()
				if luasnip.expand_or_jumpable() then
					return luasnip.expand_or_jump()
				else
					return "<Tab>"
				end
			end, { expr = true, silent = true })
			vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
				if luasnip.jumpable(-1) then
					return luasnip.jump(-1)
				else
					return "<S-Tab>"
				end
			end, { expr = true, silent = true })
		end,
	},

	{
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
