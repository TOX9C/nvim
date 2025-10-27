return {
	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*", -- optional but recommended
		build = "make install_jsregexp", -- so regex snippets work
		config = function()
			local luasnip = require("luasnip")

			-- This makes LuaSnip remember snippets for jumping back
			luasnip.config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
				enable_autosnippets = true,
			})

			-- Keymaps for snippet navigation
			vim.keymap.set({ "i", "s" }, "<Tab>", function()
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					return "<Tab>"
				end
			end, { expr = true })

			vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					return "<S-Tab>"
				end
			end, { expr = true })
		end,
	},

	-- Friendly-snippets collection
	{
		"rafamadriz/friendly-snippets",
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
}
