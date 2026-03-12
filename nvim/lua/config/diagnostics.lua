-- ~/.config/nvim/lua/config/diagnostics.lua
-- Require this in your init.lua with: require("config.diagnostics")
-- Or paste the vim.diagnostic.config() block directly into your lsp.lua
-- inside the config = function() block, after require("mason").setup()

-- ── Signs in the gutter (the icons on the left column) ────────────────────────
local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {
        text = icon,
        texthl = hl,
        numhl = hl,
    })
end

-- ── Core diagnostic display ────────────────────────────────────────────────────
vim.diagnostic.config({

    -- Show inline virtual text like VSCode
    -- e.g.  x  undefined: 'foo'
    virtual_text = {
        enabled = true,
        spacing = 4,
        prefix = "●", -- dot before the message
        severity = {
            min = vim.diagnostic.severity.HINT, -- show everything
        },
    },

    -- Underline the actual offending code
    underline = {
        severity = {
            min = vim.diagnostic.severity.HINT,
        },
    },

    -- Show signs in the gutter (signcolumn)
    signs = {
        severity = {
            min = vim.diagnostic.severity.HINT,
        },
    },

    -- Update diagnostics while you are still typing
    update_in_insert = false, -- true = updates as you type (can feel noisy)
    -- false = updates when you leave insert mode

    -- Most severe diagnostic floats to top when multiple on same line
    severity_sort = true,

    -- Floating window when you do <leader>vd
    float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always", -- always show which LSP the error came from
        header = "",
        prefix = "",
    },
})

-- ── Hover + signature help window style ───────────────────────────────────────
-- Makes K and <C-h> pop up with rounded borders instead of plain boxes
vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", max_width = 80 })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = "rounded", max_width = 80 }
)

-- ── Auto open float on cursor hold ────────────────────────────────────────────
-- When you stop moving for `updatetime` ms (you have 50ms set),
-- the diagnostic float pops up automatically under your cursor.
-- Remove this block if you find it annoying — <leader>vd still works manually.
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, {
            focusable = false,
            close_events = {
                "BufLeave",
                "CursorMoved",
                "InsertEnter",
                "FocusLost",
            },
            border = "rounded",
            source = "always",
            prefix = "",
            scope = "cursor", -- only show diagnostic under cursor, not whole line
        })
    end,
})
