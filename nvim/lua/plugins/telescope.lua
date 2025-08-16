-- plugins/telescope.lua
return {
    -- Fuzzy Finder

    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    tag = "0.1.8",
    -- or
    -- branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },

    -- Add your configuration
    config = function()
        -- The easiest way to use Telescope, is to start by doing something like:
        --  :Telescope help_tags

        -- [[ Configure Telescope ]]
        -- See `:help telescope` and `:help telescope.setup()`
        require("telescope").setup({
        })
    end,

    keys = {
        {
            -- keymap to browse files (pf: project files)
            "<leader>pf",
            function()
                require("telescope.builtin").find_files()
            end,
            desc = "Search Files",
        },
        {
            -- keymap to browse files within git repositry
            "<C-p>",
            function()
                require("telescope.builtin").git_files()
            end,
            desc = "Search Files Within Git Directory",
        },
        {
            -- keymap to live grep within files
            "<leader>ps",
            function()
                require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
            end,
            desc = "GREP Within files",
        },
    },
}
