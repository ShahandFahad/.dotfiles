-- ~/.config/nvim/lua/plugins/telescope.lua

return {
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.8",
    dependencies = {
        "nvim-lua/plenary.nvim",

        -- Native FZF sorter — makes telescope dramatically faster
        -- and scoring much smarter (fuzzy ranking, not just substring)
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            -- only load if make is available
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },

        -- Lets telescope show you file icons (requires a Nerd Font — you have one)
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                -- ── Layout ────────────────────────────────────────────────
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        preview_width = 0.55, -- preview takes 55% of width
                        results_width = 0.45,
                    },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120, -- hide preview on narrow terminals
                },

                -- ── Appearance ────────────────────────────────────────────
                prompt_prefix = "   ",
                selection_caret = "  ",
                entry_prefix = "  ",
                border = true,
                borderchars = {
                    "─",
                    "│",
                    "─",
                    "│",
                    "╭",
                    "╮",
                    "╯",
                    "╰",
                },

                -- ── Behaviour ─────────────────────────────────────────────
                -- Don't include gitignored files, node_modules etc
                file_ignore_patterns = {
                    "node_modules",
                    ".git/",
                    "dist/",
                    "build/",
                    "%.lock",
                    "__pycache__",
                    "%.pyc",
                    "target/", -- Rust build dir
                },

                -- Search hidden files (dotfiles) but not .git internals
                find_command = {
                    "rg",
                    "--files",
                    "--hidden",
                    "--glob",
                    "!.git/*",
                },

                -- ── Keymaps inside telescope window ───────────────────────
                mappings = {
                    i = {
                        -- Ctrl+k/j to move up/down results (vim style)
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-j>"] = actions.move_selection_next,

                        -- Ctrl+q to send ALL results to quickfix list
                        ["<C-q>"] = actions.send_to_qflist
                            + actions.open_qflist,

                        -- Ctrl+x to send SELECTED results to quickfix
                        ["<C-x>"] = actions.send_selected_to_qflist
                            + actions.open_qflist,

                        -- Esc closes telescope instead of going to normal mode
                        ["<esc>"] = actions.close,

                        -- Scroll the preview window
                        ["<C-u>"] = actions.preview_scrolling_up,
                        ["<C-d>"] = actions.preview_scrolling_down,
                    },
                },
            },

            pickers = {
                find_files = {
                    hidden = true, -- show dotfiles
                },
                live_grep = {
                    additional_args = { "--hidden" },
                },
                buffers = {
                    sort_mru = true, -- most recently used first
                    ignore_current_buffer = true,
                },
            },

            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true, -- use fzf for everything
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        })

        -- Load fzf extension if it built successfully
        pcall(telescope.load_extension, "fzf")
    end,

    keys = {
        -- ── Files ─────────────────────────────────────────────────────────
        {
            "<leader>pf",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Find Files",
        },
        {
            "<C-p>",
            function()
                require("telescope.builtin").git_files()
            end,
            desc = "Find Git Files",
        },

        -- ── Search / Grep ──────────────────────────────────────────────────
        {
            "<leader>ps",
            function()
                require("telescope.builtin").grep_string({
                    search = vim.fn.input("Grep > "),
                })
            end,
            desc = "Grep String",
        },
        {
            -- Live grep — results update as you type, no input prompt
            "<leader>lg",
            function()
                require("telescope.builtin").live_grep()
            end,
            desc = "Live Grep",
        },
        {
            -- Grep the word under your cursor instantly
            "<leader>pw",
            function()
                require("telescope.builtin").grep_string()
            end,
            desc = "Grep Word Under Cursor",
        },

        -- ── Buffers ───────────────────────────────────────────────────────
        {
            "<leader>pb",
            function()
                require("telescope.builtin").buffers()
            end,
            desc = "Open Buffers",
        },

        -- ── LSP ───────────────────────────────────────────────────────────
        {
            "<leader>pd",
            function()
                require("telescope.builtin").diagnostics()
            end,
            desc = "Workspace Diagnostics",
        },
        {
            "<leader>pr",
            function()
                require("telescope.builtin").lsp_references()
            end,
            desc = "LSP References",
        },

        -- ── Nvim internals ────────────────────────────────────────────────
        {
            "<leader>ph",
            function()
                require("telescope.builtin").help_tags()
            end,
            desc = "Help Tags",
        },
        {
            "<leader>pk",
            function()
                require("telescope.builtin").keymaps()
            end,
            desc = "Keymaps",
        },
        {
            "<leader>po",
            function()
                require("telescope.builtin").oldfiles()
            end,
            desc = "Recent Files",
        },
    },
}
