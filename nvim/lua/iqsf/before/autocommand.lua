-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("iqsf-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({
			timeout = 80,
		})
	end,
})
