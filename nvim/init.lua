-- Loaded before plugins in this order: vim options, remaps, autocommands.
require("iqsf.before.option")
require("iqsf.before.remap")
require("iqsf.before.autocommand")

-- Load Plugin Manager and Deifferent Plugins:
-- Defining a plugin manage (lazy). Plugins are loaded with in lazy.setup
require("config.lazy")

-- Loaded after pluigns:
-- Should be loaded after loading  plugin manager and plugins (as it depends on them)
-- set colorscheme
require("iqsf.after.settheme")

-- remove netrw banner
vim.g.netrw_banner = 0
