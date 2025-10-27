--@diagnostic disable: undefined-global
return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "debugloop/telescope-undo.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local undo_actions = require("telescope-undo.actions")
        local lga_actions = require("telescope-live-grep-args.actions")

        -- Telescope setup
        telescope.setup({
            defaults = {
                layout_config = {
                    anchor = "center",
                    height = 0.8,
                    width = 0.9,
                    prompt_position = "bottom",
                },
                mappings = {
                    i = {
                        ["<esc>"] = actions.close, -- Close Telescope in insert mode
                    },
                },
            },
            extensions = {
                undo = {
                    use_delta = true, -- Use delta to show diffs
                    side_by_side = true, -- Show additions/deletions side by side
                    entry_format = "󰣜  #$ID, $STAT, $TIME", -- Undo entry format
                    layout_strategy = "flex",
                    mappings = {
                        i = {
                            ["<cr>"] = undo_actions.yank_additions, -- Yank additions
                            ["<c-\\>"] = undo_actions.yank_deletions, -- Yank deletions
                            ["<tab>"] = undo_actions.restore, -- Restore this undo entry
                        },
                    },
                },
                live_grep_args = {
                    auto_quoting = true, -- Auto quote multi-word search
                    mappings = {
                        i = {
                            ["<c-\\>"] = lga_actions.quote_prompt({ postfix = " --hidden " }), -- Add `--hidden` to grep
                        },
                    },
                },
                file_browser = {
                    depth = false,
                    auto_depth = true,
                    hidden = true, -- Show hidden files/folders
                    hide_parent_dir = false,
                    collapse_dirs = false,
                    prompt_path = false,
                    quiet = false,
                    dir_icon = "󰉓 ",
                    dir_icon_hl = "Default",
                    display_stat = { date = true, size = true, mode = true },
                    git_status = true,
                },
            },
        })

        -- Load extensions
        telescope.load_extension("undo")
        telescope.load_extension("file_browser")
        telescope.load_extension("live_grep_args")

        -- Keymap helper
        local map = vim.keymap.set

        -- 1. Undo Tree
        map("n", "<leader>u", function()
            vim.notify("<cr> yank additions\n<c-\\> yank deletions\n<tab> restore", 
                vim.log.levels.INFO, { title = "Undo Keybinds", timeout = 15000 })
            telescope.extensions.undo.undo()
        end, { desc = "Undo tree" })

        -- 2. Live Grep with Arguments
        vim.api.nvim_create_user_command("LiveGrep", function()
            telescope.extensions.live_grep_args.live_grep_args({
                prompt_title = "Live Grep",
                additional_args = "-i", -- Case-insensitive grep
            })
        end, { desc = "Live grep with extra arguments" })
        map("n", "\\", "<cmd>LiveGrep<cr>", { desc = "Live grep" })

        -- 3. Recent Files
        map("n", "<leader>o", "<cmd>Telescope oldfiles<cr>", { desc = "Open recent files" })

        -- 4. File Browser
        map("n", "<leader>f", function()
            telescope.extensions.file_browser.file_browser()
        end, { desc = "Browse files" })

        -- 5. Neovim Config Browser
        map("n", "<leader>.", function()
            telescope.extensions.file_browser.file_browser({ path = vim.fn.stdpath("config") })
        end, { desc = "Browse Neovim config" })
    end,
}

