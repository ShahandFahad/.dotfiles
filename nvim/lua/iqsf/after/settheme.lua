-- @after loading colorscheme function
-- set the theme and background transparency
--
-- and this function should be called in the 'init.lua' file after loading the plugins
-- check 'colorscheme.lua' file for more configuration, as I have defined other colorschemes there,
--
-- press :colorscheme and tab, to checkout other colorscheme as well
-- for enabling and disabling theme, read below comments
--
function SetColorTheme(theme, transparent)
	-- set theme
	-- theme = theme or "tokyonight-night"
	theme = theme or "rose-pine"
    transparent = transparent or "yes"

	-- set colorscheme
	vim.cmd.colorscheme(theme)

    -- early return incase of no transparent bg, theme is already set
    if (transparent == "no") then
        print("Transparency disabled")
        return
    end

	-- enable transparent background
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end


-- YES, IAMMMMM STUPIDDD 🗣️, But sometime I don't want it to be Transparent though 🤌
-- Use :lua functionName() and If want some other theme, then pass it name also
-- e.g :lua DisableTransparentBG() 
-- And YES, I should use BOOLEANS as well...

-- just an alias function which call the 'SetColorTheme' function but DISABLE transparency
function DisableTransparentBG(theme)
    SetColorTheme(theme or "rose-pine", "no") -- disbale transparency
end

-- just an alias function which call the 'SetColorTheme' function but ENABLE transparency
function EnableTransparentBG(theme)
    SetColorTheme(theme or "rose-pine", "yes") -- yes, stupidity
end


-- THIS FUNCTION is CALLED by DEFAULT WHEN nvim is LOADED
-- IF want to enable or diable or change the theme, call the above functions i.e, (:lua functionName)
SetColorTheme()

