-- FIX: check lsp-zero-for-lazy-vim
-- LSP Plugins
-- This file contains the following
--
-- 1: LSP Configuration
-- 2: Autocompletion
-- 3: AutoFormat
--

return {
    {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },

        { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

        {                                        -- optional completion source for require statements and module annotations
            "hrsh7th/nvim-cmp",
            opts = function(_, opts)
                opts.sources = opts.sources or {}
                table.insert(opts.sources, {
                    name = "lazydev",
                    group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                })
            end,
        },

        -- Main LSP Configuration
        {

            -- LSP Support
            "neovim/nvim-lspconfig",
            dependencies = {
                -- Automatically install LSPs and related tools to stdpath for Neovim
                -- LSP Support
                { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
                "williamboman/mason-lspconfig.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                -- Allows extra capabilities provided by nvim-cmp
                "hrsh7th/cmp-nvim-lsp",
            },
            config = function()
                --
                -- LSP provides Neovim with features like:
                --  - Go to definition
                --  - Find references
                --  - Autocompletion
                --  - Symbol Search
                --  - and more!
                --
                --  This function gets run when an LSP attaches to a particular buffer.
                --  That is to say, every time a new file is opened that is associated with
                --  an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
                --  function will be executed to configure the current buffer
                vim.api.nvim_create_autocmd("LspAttach", {
                    group = vim.api.nvim_create_augroup("iqsf-lsp-attach", { clear = true }),
                    callback = function(event)
                        local opts = { buffer = event.buf, remap = false }

                        vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                        vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                        vim.keymap.set("n", "<leader>vws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)
                        vim.keymap.set("n", "<leader>vd", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
                        vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
                        vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
                        vim.keymap.set("n", "<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
                        vim.keymap.set("n", "<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                        vim.keymap.set("n", "<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
                        vim.keymap.set("n", "<C-h>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
                    end,
                })
                -- Lsp Attach Callback Ends Here

                -- LSP servers and clients are able to communicate to each other what features they support.
                --  By default, Neovim doesn't support everything that is in the LSP specification.
                --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
                --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities =
                    vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

                -- servers
                local servers = {
                    clangd = {},
                    gopls = {},
                    pyright = {},
                    rust_analyzer = {},
                    lua_ls = {},
                }

                -- Ensure the servers and tools above are installed
                --  To check the current status of installed tools and/or manually install
                --  other tools, you can run
                --    :Mason
                --
                --  You can press `g?` for help in this menu.
                require("mason").setup()

                -- You can add other tools here that you want Mason to install
                -- for you, so that they are available from within Neovim.
                local ensure_installed = vim.tbl_keys(servers or {})
                vim.list_extend(ensure_installed, {})

                require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
                require("mason-lspconfig").setup({
                    -- ensure_installed = { 'tsserver', 'eslint', 'rust_analyzer', 'lua_ls', 'gopls', 'clangd', },
                    ensure_installed = ensure_installed,
                    automatic_installation = true,
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}
                            -- This handles overriding only values explicitly passed
                            -- by the server configuration above. Useful when disabling
                            -- certain features of an LSP (for example, turning off formatting for tsserver)
                            server.capabilities =
                                vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                            require("lspconfig")[server_name].setup(server)
                        end,
                    },
                })
            end,
        },
        --nvim-lspconfig ends here
    },
    -- LSP setup ends here

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            -- Snippet Engine & its associated nvim-cmp source
            {
                "L3MON4D3/LuaSnip",

                -- Build Step is needed for regex support in snippets.
                build = (function()
                    return "make install_jsregexp"
                end)(),

                dependencies = {
                    -- `friendly-snippets` contains a variety of premade snippets.
                    --    See the README about individual language/framework/plugin snippets:
                    --    https://github.com/rafamadriz/friendly-snippets
                    {
                        "rafamadriz/friendly-snippets",
                        config = function()
                            require("luasnip.loaders.from_vscode").lazy_load()
                        end,
                    },
                },
            },
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
        },

        config = function()
            -- See `:help cmp`
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            -- local cmp_select = {behavior = cmp.SelectBehavior.Select}
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },

                -- See`:help ins-completion` to understand the mappings
                mapping = cmp.mapping.preset.insert({
                    -- Completion key bindings
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete({}),

                    -- `Back & Forward` Scroll the info window
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                }),

                sources = {
                    {
                        name = "lazydev",
                        -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
                        group_index = 0,
                    },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                },
            })
        end,
    },
    -- Autocompletion ends here
}
