-- In normal mode
-- yap = yank around paragraph
-- dap = delete around paragraph
-- <leader>yap yank and copy to clipboard also
-- <Ctrl> + 6, Go to previous file, entered via fuzzy finder

-- SUPER CUSTOM REMAPS

-- Exit file and go back to directory i.e, :Ex
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) -- custom Ex setup

-- Write changes to file i.e, pressing :w to write to file
-- vim.keymap.set("n", "<C-s>", vim.cmd.write)

-- Select and Move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Append below lines to the end and cursor remain at beginning of line
vim.keymap.set("n", "J", "mzJ`z")

-- Half page jumps - Alternative to <Shift> + { or } paragraph jumps and cursor remain at center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- n or N - Look for search results down and below and cursor remain at center
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Keep the pasted buffer unlike simple pasting 'p'
vim.keymap.set("x", "<leader>p", '"_dp')

-- Copy to System Clip Board - mode: normal & visual
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')

-- Delete items without storing it to the buffer
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')

-- Save changes vertically in insert mode when ctrl + c pressed
vim.keymap.set("i", "<C-c>", "<Esc>")

-- On <shift> + Q no command should execute
vim.keymap.set("n", "Q", "<nop>")

-- FIX: set this tmux-sessionizer
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")

-- Format file
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- Cursor movement in diagnostic menu
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
