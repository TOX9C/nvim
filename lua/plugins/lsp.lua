local map = vim.keymap.set

---@diagnostic disable: undefined-global
return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = {
    "saghen/blink.cmp",        -- LSP completion capabilities
    "mrcjkb/rustaceanvim",     -- Rust setup
    "SmiteshP/nvim-navic",     -- Code context in winbar
  },
  config = function()
    local lspconfig = require("lspconfig")
    local navic = require("nvim-navic")

    -- Helper: on_attach for keymaps + navic
    local function on_attach(client, bufnr)
      local buf_map = function(keys, func, desc)
        map("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
      end

      buf_map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
      buf_map("g?", require("telescope.builtin").lsp_references, "References")
      buf_map("grI", require("telescope.builtin").lsp_implementations, "Goto Implementation")
      buf_map("grT", require("telescope.builtin").lsp_type_definitions, "Goto Type")
      buf_map("grS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
      buf_map("grN", vim.lsp.buf.rename, "Rename")
      buf_map("grA", vim.lsp.buf.code_action, "Code Action")
      buf_map("K", vim.lsp.buf.hover, "Hover Documentation")
      buf_map("<C-s>", vim.lsp.buf.signature_help, "Signature Help")
      buf_map("gD", vim.lsp.buf.declaration, "Goto Declaration")

      -- Highlight references under cursor
      if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end

      -- Attach navic if supported
      if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end

      -- Set omnifunc for LSP completion
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end

    -- LSP capabilities (for completion)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

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
      ts_ls = {},
      rust_analyzer = {},
      bashls = {},
      clangd = {},
      cssls = {},
      html = {},
      marksman = {},
      yamlls = {},
      jsonls = {},
    }

    -- Setup all servers
    for name, config in pairs(servers) do
      config = config or {}
      config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})
      config.on_attach = on_attach
      lspconfig[name].setup(config)
    end
  end,
}

