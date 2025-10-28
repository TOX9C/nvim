return {
	"willothy/nvim-cokeline",
	-- Ensure cokeline loads after your colorscheme
	-- If using a colorscheme plugin, you could add: `after = "your-colorscheme-name"`
	config = function()
		local get_hex = require("cokeline.hlgroups").get_hl_attr

		-- A safe function to get a color, with a fallback
		local function get_color_safe(hl_group, attribute, fallback)
			local color_ok, color = pcall(get_hex, hl_group, attribute)
			if color_ok and color then
				return color
			end
			-- Fallback color if the group doesn't exist. You can change these.
			vim.notify(
				"Highlight group '" .. hl_group .. "' not found, using fallback for cokeline.",
				vim.log.levels.WARN
			)
			return fallback or "#FFFFFF"
		end

		require("cokeline").setup({
			sidebar = {
				filetype = { "NvimTree", "neo-tree", "NvimTree_1" },
				components = {
					{
						text = "  NvimTree",
						fg = get_color_safe("Comment", "fg", "#888888"),
						-- Using 'NONE' for background is a safe choice for transparency
						bg = "NONE",
						bold = true,
					},
				},
			},

			default_hl = {
				fg = function(buffer)
					if buffer.is_focused then
						return get_color_safe("Normal", "fg", "#FFFFFF")
					else
						return get_color_safe("Comment", "fg", "#888888")
					end
				end,
				bg = "NONE",
			},

			-- ... (your existing components configuration can follow here)
			components = {
				-- Your component definitions from earlier.
				-- Consider adding `bg = 'NONE'` to each component for full transparency.
			},
		})
	end,
}
