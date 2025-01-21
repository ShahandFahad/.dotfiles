-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- set fat cursor
-- vim.opt.guicursor = ""

-- set line number and relative line number
vim.opt.number = true
vim.opt.relativenumber = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- disable line wraps
vim.opt.wrap = false

-- disable backup and enable undo for undo tree plugin to have access to long running undo, to undo things from very long ago
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- disable search highlight and enable incremental search
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")
vim.opt.colorcolumn = "80"

-- Do not showmode, as it is already in status line
-- vim.opt.showmode = false

-- Sync System Clipboard and Neo
-- Yanking will copy text to system clipboard also
-- Well, I do not want this,
-- I want it to be independent,
-- So, setting up custom key map for it in the remap.lua file check it
-- Uucomment this bellow code
vim.schedule(function()
	vim.opt.clipboard = "unnamed"
end)

-- Enable Break Indent
vim.opt.breakindent = true

-- Case Insensitive Searching is Not On
vim.opt.ignorecase = false
vim.opt.smartcase = false

-- Singn column is on by default
vim.opt.signcolumn = "yes"

-- Decrease update time : flush swapfile after this many milliseconds
vim.opt.updatetime = 50
