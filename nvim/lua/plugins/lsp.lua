-- FIX: check lsp-zero-for-lazy-vim
-- LSP Plugins
-- This file contains the following
--
-- 1: LSP Configuration
-- 2: Autocompletion
-- 3: AutoFormat
--
-- ~/.config/nvim/lua/plugins/lsp.lua

return {
    {
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },

        { "Bilal2453/luvit-meta", lazy = true },

        {
            "hrsh7th/nvim-cmp",
            opts = function(_, opts)
                opts.sources = opts.sources or {}
                table.insert(opts.sources, {
                    name = "lazydev",
                    group_index = 0,
                })
            end,
        },

        {
            "neovim/nvim-lspconfig",
            dependencies = {
                { "williamboman/mason.nvim", config = true },
                "williamboman/mason-lspconfig.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                "hrsh7th/cmp-nvim-lsp",
            },
            config = function()
                vim.api.nvim_create_autocmd("LspAttach", {
                    group = vim.api.nvim_create_augroup(
                        "iqsf-lsp-attach",
                        { clear = true }
                    ),
                    callback = function(event)
                        local opts = { buffer = event.buf, remap = false }
                        vim.keymap.set(
                            "n",
                            "gd",
                            "<cmd>lua vim.lsp.buf.definition()<CR>",
                            opts
                        )
                        vim.keymap.set(
                            "n",
                            "K",
                            "<cmd>lua vim.lsp.buf.hover()<CR>",
                            opts
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>vws",
                            "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>",
                            opts
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>vd",
                            "<cmd>lua vim.diagnostic.open_float()<CR>",
                            opts
                        )
                        vim.keymap.set(
                            "n",
                            "[d",
                            "<cmd>lua vim.diagnostic.goto_next()<CR>",
                            opts
                        )
                        vim.keymap.set(
                            "n",
                            "]d",
                            "<cmd>lua vim.diagnostic.goto_prev()<CR>",
                            opts
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>vca",
                            "<cmd>lua vim.lsp.buf.code_action()<CR>",
                            opts
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>vrr",
                            "<cmd>lua vim.lsp.buf.references()<CR>",
                            opts
                        )
                        vim.keymap.set(
                            "n",
                            "<leader>vrn",
                            "<cmd>lua vim.lsp.buf.rename()<CR>",
                            opts
                        )
                        vim.keymap.set(
                            "n",
                            "<C-h>",
                            "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                            opts
                        )
                    end,
                })

                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities = vim.tbl_deep_extend(
                    "force",
                    capabilities,
                    require("cmp_nvim_lsp").default_capabilities()
                )

                -- ── LSP SERVERS ───────────────────────────────────────────────
                -- ONLY lsp server names here, no formatters
                local servers = {
                    clangd = {
                        cmd = {
                            "clangd",
                            "--background-index",
                            "--clang-tidy",
                            "--header-insertion=iwyu",
                            "--completion-style=detailed",
                            "--function-arg-placeholders",
                        },
                    },
                    gopls = {
                        settings = {
                            gopls = {
                                analyses = {
                                    unusedparams = true,
                                    shadow = true,
                                    unusedwrite = true,
                                    useany = true,
                                },
                                staticcheck = true,
                                gofumpt = true,
                                hints = {
                                    assignVariableTypes = true,
                                    compositeLiteralFields = true,
                                    compositeLiteralTypes = true,
                                    constantValues = true,
                                    functionTypeParameters = true,
                                    parameterNames = true,
                                    rangeVariableTypes = true,
                                },
                            },
                        },
                    },
                    pyright = {
                        settings = {
                            python = {
                                analysis = {
                                    typeCheckingMode = "basic",
                                    autoSearchPaths = true,
                                    useLibraryCodeForTypes = true,
                                    autoImportCompletions = true,
                                    diagnosticMode = "workspace",
                                    reportMissingImports = "error",
                                    reportUndefinedVariable = "error",
                                    reportMissingModuleSource = "warning",
                                },
                            },
                        },
                    },
                    rust_analyzer = {
                        settings = {
                            ["rust-analyzer"] = {
                                checkOnSave = { command = "clippy" },
                                inlayHints = {
                                    enable = true,
                                    parameterHints = { enable = true },
                                    typeHints = { enable = true },
                                    chainingHints = { enable = true },
                                },
                                diagnostics = {
                                    enable = true,
                                    experimental = { enable = true },
                                },
                            },
                        },
                    },
                    ts_ls = {
                        settings = {
                            typescript = {
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                                    includeInlayFunctionParameterTypeHints = true,
                                    includeInlayVariableTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                },
                            },
                            javascript = {
                                inlayHints = {
                                    includeInlayParameterNameHints = "all",
                                    includeInlayVariableTypeHints = true,
                                    includeInlayFunctionLikeReturnTypeHints = true,
                                },
                            },
                        },
                    },
                    -- ── lua_ls: fixed — lazydev handles vim global properly ──
                    lua_ls = {
                        settings = {
                            Lua = {
                                runtime = { version = "LuaJIT" },
                                diagnostics = {
                                    -- explicitly tell lua_ls that `vim` is a valid global
                                    globals = { "vim" },
                                },
                                workspace = {
                                    -- stop lua_ls from asking "configure as luarc?"
                                    checkThirdParty = false,
                                },
                                telemetry = { enable = false },
                                hint = {
                                    enable = true,
                                    setType = true,
                                    paramName = "All",
                                    arrayIndex = "Enable",
                                },
                            },
                        },
                    },
                }

                -- ── MASON TOOL INSTALLER ──────────────────────────────────────
                -- Formatters and linters go here — NOT in mason-lspconfig
                local formatter_tools = {
                    -- Lua
                    "stylua",
                    -- Python
                    "black",
                    "isort",
                    -- Go
                    "goimports",
                    "gofumpt",
                    -- C / C++
                    "clang-format",
                    -- JS / TS
                    "prettierd",
                    -- Shell
                    "shfmt",
                    -- Rust: managed by rustup, not Mason
                    -- run: rustup component add rustfmt
                }

                require("mason").setup()

                -- mason-tool-installer gets BOTH lsp servers + formatter tools
                local all_tools = vim.tbl_keys(servers)
                vim.list_extend(all_tools, formatter_tools)
                require("mason-tool-installer").setup({
                    ensure_installed = all_tools,
                })

                -- mason-lspconfig gets ONLY lsp server names
                require("mason-lspconfig").setup({
                    ensure_installed = vim.tbl_keys(servers),
                    automatic_installation = true,
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}

                            -- disable LSP formatting for servers conform handles
                            local disable_format = {
                                gopls = true,
                                lua_ls = true,
                                ts_ls = true,
                                pyright = true,
                            }
                            if disable_format[server_name] then
                                server.on_attach = function(client, _)
                                    client.server_capabilities.documentFormattingProvider =
                                        false
                                    client.server_capabilities.documentRangeFormattingProvider =
                                        false
                                end
                            end

                            server.capabilities = vim.tbl_deep_extend(
                                "force",
                                {},
                                capabilities,
                                server.capabilities or {}
                            )
                            require("lspconfig")[server_name].setup(server)
                        end,
                    },
                })
            end,
        },
    },

    -- ── AUTOCOMPLETION ────────────────────────────────────────────────────────
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                build = (function()
                    return "make install_jsregexp"
                end)(),
                dependencies = {
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
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            luasnip.config.setup({})

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = { completeopt = "menu,menuone,noinsert" },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete({}),
                    ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-d>"] = cmp.mapping.scroll_docs(4),
                }),
                sources = {
                    { name = "lazydev", group_index = 0 },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                },
            })
        end,
    },
}
