---@diagnostic disable: undefined-global
local map = vim.keymap.set
return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"SmiteshP/nvim-navic",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local navic = require("nvim-navic")

		-- on_attach helper
		local on_attach = function(client, bufnr)
			local nmap = function(keys, fn, desc)
				vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
			end
			nmap("gd", vim.lsp.buf.definition, "Goto Definition")
			nmap("gD", vim.lsp.buf.declaration, "Goto Declaration")
			nmap("K", vim.lsp.buf.hover, "Hover")
			nmap("gr", vim.lsp.buf.references, "References")
			nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
			nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
		end

		-- Capabilities for nvim-cmp
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
		if has_cmp then
			capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
		end

		-- servers table
		local servers = {
			lua_ls = {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
			},
			pyright = {},
			tsserver = {}, -- note: lspconfig name is tsserver (mason installs tsserver). you can still configure tsserver; if you choose ts_ls instead, change here.
			rust_analyzer = {},
			clangd = {},
			cssls = {},
			html = {},
			marksman = {},
			yamlls = {},
			jsonls = {},
			-- VHDL: many setups use `ghdl_ls` or `vhdl_ls` if available; check your install
			-- if using ghdl-ls via system install, change below to the server name exposed by lspconfig
		}

		for name, cfg in pairs(servers) do
			cfg = cfg or {}
			cfg.on_attach = on_attach
			cfg.capabilities = vim.tbl_deep_extend("force", capabilities, cfg.capabilities or {})
			-- protect against servers not present in lspconfig
			if lspconfig[name] then
				lspconfig[name].setup(cfg)
			else
				vim.schedule(function()
					vim.notify("lspconfig: server not available: " .. name, vim.log.levels.WARN)
				end)
			end
		end

		-- Global diagnostics keymaps
		map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
		map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
	end,
}
