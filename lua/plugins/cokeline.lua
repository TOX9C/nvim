-- lua/plugins/cokeline.lua
return {
	"willothy/nvim-cokeline",
	config = function()
		local get_hex = require("cokeline.hlgroups").get_hl_attr

		require("cokeline").setup({
			-- Enable if you use a sidebar plugin like nvim-tree
			sidebar = {
				filetype = { "NvimTree", "neo-tree", "NvimTree_1" },
				components = {
					{
						text = "  NvimTree",
						fg = get_hex("Comment", "fg"),
						bg = get_hex("NvimTreeNormal", "bg"),
						bold = true,
					},
				},
			},

			default_hl = {
				fg = function(buffer)
					return buffer.is_focused and get_hex("Normal", "fg") or get_hex("Comment", "fg")
				end,
				bg = "NONE",
			},

			components = {
				{
					text = function(buffer)
						return " " .. buffer.index .. " "
					end,
					bold = function(buffer)
						return buffer.is_focused
					end,
				},
				{
					text = function(buffer)
						return buffer.devicon.icon
					end,
					fg = function(buffer)
						return buffer.devicon.color
					end,
				},
				{
					text = function(buffer)
						return buffer.unique_prefix
					end,
					fg = get_hex("Comment", "fg"),
					italic = true,
				},
				{
					text = function(buffer)
						return buffer.filename .. " "
					end,
					bold = function(buffer)
						return buffer.is_focused
					end,
					underline = function(buffer)
						return buffer.is_hovered and not buffer.is_focused
					end,
				},
				{
					text = function(buffer)
						return buffer.is_modified and "● " or ""
					end,
					fg = function(buffer)
						return buffer.is_modified and get_hex("Error", "fg") or nil
					end,
				},
				{
					text = "  ",
					fg = get_hex("Error", "fg"),
					on_click = function(_, _, _, _, buffer)
						buffer:delete()
					end,
				},
			},
		})
	end,
}
