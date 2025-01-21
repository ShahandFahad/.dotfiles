-- @after loading colorscheme function
-- set the theme and background transparency
--
-- and this function should be called in the 'init.lua' file after loading the plugins
-- check 'colorscheme.lua' file for more configuration, as I have defined other colorschemes there,
--
-- press :colorscheme and tab, to checkout other colorscheme as well
--
function SetColorTheme(theme)
	-- set theme
	theme = theme or "tokyonight-night"

	-- set colorscheme
	vim.cmd.colorscheme(theme)

	-- enable transparent background
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- function call
SetColorTheme()
