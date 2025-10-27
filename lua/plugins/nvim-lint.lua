---@diagnostic disable: undefined-global
return {
	"mfussenegger/nvim-lint",
	event = { "BufWritePost", "InsertLeave", "BufReadPost" },
	config = function()
		local lint = require("lint")

		-- Define which linters to run per filetype
		lint.linters_by_ft = {
			-- adjust these to suit your needs
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			python = { "pylint" },
			lua = { "luacheck" },
			sh = { "shellcheck" },
			yaml = { "yamllint" },
		}

		-- Create autocommand to trigger linting
		local lint_au = vim.api.nvim_create_augroup("nvim-lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_au,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Optional keymap to manually trigger lint
		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Run linter for current file" })
	end,
}
