-- Highlight, edit, and navigate code
-- ~/.config/nvim/lua/plugins/treesitter.lua

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            -- Systems
            "c",
            "cpp", -- you code C/C++, was missing
            "rust",
            "go",
            "gomod",
            "gosum", -- go.sum file highlighting

            -- Web
            "javascript",
            "typescript",
            "tsx", -- React JSX/TSX
            "html",
            "css", -- was missing
            "json", -- was missing
            "yaml", -- was missing

            -- Scripting
            "python", -- was missing
            "bash",

            -- Nvim / Lua
            "lua",
            "luadoc",
            "vim",
            "vimdoc",
            "query",

            -- Docs
            "markdown",
            "markdown_inline",
        },

        sync_install = false,
        auto_install = true,

        -- ── Syntax highlighting ───────────────────────────────────────────
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },

        -- ── Indentation ───────────────────────────────────────────────────
        -- Treesitter-based indent — smarter than vim's default
        -- Uncomment if you want treesitter to handle = indenting
        -- indent = { enable = true },

        -- ── Incremental selection ─────────────────────────────────────────
        -- Start on a word, keep pressing Enter to expand selection outward
        -- (variable → expression → block → function → file)
        -- Very useful alternative to visual mode + text objects
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<Enter>", -- start selection on current node
                node_incremental = "<Enter>", -- expand to parent node
                node_decremental = "<BS>", -- shrink back down
                scope_incremental = false,
            },
        },
    },

    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
