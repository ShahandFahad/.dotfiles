-- Highlight, edit, and navigate code
return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "c",
            "lua",
            "rust",
            "javascript",
            "typescript",
            "bash",
            "html",
            "luadoc",
            "markdown",
            "markdown_inline",
            "query",
            "vim",
            "vimdoc",
            "go",
            "gomod"
        },

        -- Install parsers synchronously (only applied to ensure_installed)
        sync_install = false,

        -- Autoinstall languages that are not installed
        auto_install = true,

        highlight = {
            enable = true,

            -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
            --  If you are experiencing weird indenting issues, add the language to
            --  the list of additional_vim_regex_highlighting and disabled languages for indent.
            additional_vim_regex_highlighting = false,
        },

        -- indent = { enable = true },
    },

    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
