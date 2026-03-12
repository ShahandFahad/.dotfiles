-- ~/.config/nvim/lua/plugins/conform.lua
-- Drop this file into your plugins folder and run :Lazy sync

return {
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },

        config = function()
            local conform = require("conform")

            conform.setup({

                -- ── Per-filetype formatters ────────────────────────────────
                formatters_by_ft = {
                    lua        = { "stylua" },
                    python     = { "isort", "black" },    -- isort first, then black
                    go         = { "goimports", "gofumpt" },
                    c          = { "clang_format" },
                    cpp        = { "clang_format" },
                    rust       = { "rustfmt" },
                    javascript = { "prettierd" },
                    typescript = { "prettierd" },
                    json       = { "prettierd" },
                    yaml       = { "prettierd" },
                    markdown   = { "prettierd" },
                    sh         = { "shfmt" },
                    bash       = { "shfmt" },
                    zsh        = { "shfmt" },
                    -- fallback: try LSP format if no formatter matched
                    ["_"]      = { "trim_whitespace" },
                },

                -- ── Format on save ─────────────────────────────────────────
                -- Async so it never blocks your typing
                format_on_save = {
                    timeout_ms = 2000,
                    lsp_fallback = true,   -- falls back to LSP if no conform formatter
                },

                -- ── Formatter options ──────────────────────────────────────
                formatters = {
                    black = {
                        prepend_args = { "--line-length", "88" },
                    },
                    shfmt = {
                        prepend_args = { "-i", "4" },  -- 4-space indent, matches your option.lua
                    },
                    clang_format = {
                        prepend_args = {
                            "--style",
                            "{BasedOnStyle: Google, IndentWidth: 4, ColumnLimit: 80}",
                        },
                    },
                    stylua = {
                        -- stylua reads .stylua.toml if present, otherwise these apply
                        prepend_args = {
                            "--indent-type", "Spaces",
                            "--indent-width", "4",
                            "--column-width", "80",
                        },
                    },
                    gofumpt = {
                        prepend_args = { "-extra" },
                    },
                },
            })

            -- ── Keymaps ────────────────────────────────────────────────────
            -- <leader>f  →  format whole file (replaces your old lsp.buf.format)
            -- <leader>F  →  format a visual selection only
            vim.keymap.set("n", "<leader>f", function()
                conform.format({
                    async = true,
                    lsp_fallback = true,
                })
            end, { desc = "Format file" })

            vim.keymap.set("v", "<leader>f", function()
                conform.format({
                    async = true,
                    lsp_fallback = true,
                    range = {
                        ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
                        ["end"]   = vim.api.nvim_buf_get_mark(0, ">"),
                    },
                })
            end, { desc = "Format selection" })

        end,
    },
}
