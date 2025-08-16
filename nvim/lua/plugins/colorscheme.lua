-- These are some of themes I set time to time, that's why there are multiple there
-- In future, I will let the one I am most comfortable with
-- colorscheme is set via custom function in 'iqsf' directory
return {
    -- Tokyonight
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins

        -- configure multiple option like transparency etc
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
    },

    -- Nightfox
    {
        "EdenEast/nightfox.nvim",

        -- config
        --		config = function()
        -- set colorscheme
        --			vim.cmd("colorscheme carbonfox")

        -- enable transparent background
        --			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        --			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        --		end,
    },

    -- Dracula
    { "Mofiqul/dracula.nvim" },

    -- Rose-Pine
    {
        "rose-pine/neovim",
        name = "rose-pine",

        -- options
        opts = {
            -- styles
            -- spend hours here just to enable the transparency to true to get my telescope window to be transparent
            -- this transparency is required in rose-pine theme as it does not explicitly make floats transparent
            -- the them is set via special function in '/iqsf/after/settheme.lua' file
            styles = { italic = false, transparency = true, },

            -- highlight groups
            highlight_groups = {
                Comment = { italic = true },
                ["@constant"] = { fg = "text", bold = true },
                ["@variable.builtin"] = { fg = "text", bold = true },
            },
        },

        -- config
        config = function(_, opts)
            -- setup options
            require("rose-pine").setup(opts)

            -- set colorscheme
            -- vim.cmd("colorscheme rose-pine")

            -- enable transparent background
            -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },
}
