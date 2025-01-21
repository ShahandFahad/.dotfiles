* **Plugin Manager:** Lazy nvim
* **lua/config:** Contains plugin manger setup
* **lua/iqsf/before:** Contains my remaps, vim options, and autocommand. And should be loaded before plugin manager.
* **lua/iqsf/after:** Contains plugins dependent setup, and should loaded after loading plugins.
* **lua/plugins:** Contains a bunch of plugins I use and my lsp.
* **init.lua:** The entry point and check out the `require` order in this file, If want to add something, use that require order.


* Folder structure of my `nvim` setup.

```
$HOME/.dotfiles/nvim
|
├── init.lua
├── lazy-lock.json
├── lua
│   ├── config
│   │   └── lazy.lua
│   ├── iqsf
│   │   ├── after
│   │   │   └── settheme.lua
│   │   └── before
│   │       ├── autocommand.lua
│   │       ├── option.lua
│   │       └── remap.lua
│   └── plugins
│       ├── cloak.lua
│       ├── colorscheme.lua
│       ├── harpoon.lua
│       ├── lsp.lua
│       ├── telescope.lua
│       ├── todocomments.lua
│       ├── treesitter.lua
│       ├── undotree.lua
│       └── vimfugitive.lua
└── README.md
```


