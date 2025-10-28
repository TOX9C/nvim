return {
	"xiyaowong/transparent.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("transparent").setup({
			groups = {
				"Normal",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement",
				"PreProc",
				"Type",
				"Underlined",
				"Todo",
				"String",
				"Function",
				"Conditional",
				"Repeat",
				"Operator",
				"Structure",
				"LineNr",
				"NonText",
				"SignColumn",
				"CursorLine",
				"CursorLineNr",
				"StatusLine",
				"StatusLineNC",
				"EndOfBuffer",
			},
			extra_groups = {
				"NormalFloat",
				"Pmenu",
				"TelescopeNormal",
			},
			exclude_groups = {},
		})

		-- Add this line to clear cokeline highlights
		require("transparent").clear_prefix("Cokeline")
	end,
}
