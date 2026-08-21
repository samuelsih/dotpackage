vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.pack")
require("config.options")
require("config.nvimtree")
require("config.keymaps")
require("config.autocmds")

vim.cmd.colorscheme("kitty")
