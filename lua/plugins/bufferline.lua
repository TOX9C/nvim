return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    priority = 1000,
    opts = {
        options = {
            numbers = "none",
            close_command = "bdelete! %d",
            right_mouse_command = "bdelete! %d",
            left_mouse_command = "buffer %d",
            indicator = { icon = "▎", style = "icon" },
            modified_icon = "●",
            separator_style = "slant",
            diagnostics = "nvim_lsp",
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            always_show_bufferline = true,
        },
    },
    config = function(_, opts)
        vim.o.termguicolors = true
        require("bufferline").setup(opts)

        local map = vim.keymap.set

        local function set_transparent()
            local groups = {
                "BufferLineFill",
                "BufferLineBackground",
                "BufferLineBuffer",
                "BufferLineBufferSelected",
                "BufferLineTab",
                "BufferLineSeparator",
                "BufferLineIndicatorSelected",
                "TabLine",
            }
            for _, g in ipairs(groups) do
                vim.api.nvim_set_hl(0, g, { bg = "none" })
            end
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        end

        vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
            callback = set_transparent,
        })
    end,
}

