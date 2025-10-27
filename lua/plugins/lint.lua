---@diagnostic disable: undefined-global
return {
	"mfussenegger/nvim-lint",
	event = { "BufEnter", "BufWritePost", "InsertLeave" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			javascript = { "eslint" },
			typescript = { "eslint" },
			python = { "ruff" },
			lua = { "luacheck" },
			sh = { "shellcheck" },
			yaml = { "yamllint" },
		}
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
			callback = function()
				lint.try_lint()
			end,
		})
		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Run linter" })
	end,
}
