---@diagnostic disable: undefined-global
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",  -- automatically update parsers after install
    lazy = false,
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "javascript",
            "typescript",
            "lua",
            "python",
            "html",
            "css",
            "json",
            "yaml",
            "vim",
        },
        highlight = {
            enable = true,              -- enable syntax highlighting
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,              -- smart indentation
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gnn",     -- start selection
                node_incremental = "grn",   -- increment to next node
                scope_incremental = "grc",  -- increment to scope
                node_decremental = "grm",   -- decrement node
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- automatically jump forward to textobj
                keymaps = {
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- update jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}

