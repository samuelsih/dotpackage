-- leader = <Space>  (vim.g.mapleader in init.lua)
--   <leader>w   save file
--   <leader>q   quit window
--   <leader>e   toggle file explorer (netrw)
--
-- insert mode:  jj = exit to normal mode
-- visual mode:  < / > = indent, keep selection
--               J / K = move line down / up
-- normal mode:  <Esc><Esc> = clear search highlight

local map = vim.keymap.set

-- basics
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>e", "<cmd>Explore<cr>", { desc = "Toggle file explorer" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })

-- better navigation in insert mode
map("i", "jj", "<Esc>", { desc = "Exit insert mode" })

-- keep selection when indenting
map("v", "<", "<gv", { desc = "Indent left, keep selection" })
map("v", ">", ">gv", { desc = "Indent right, keep selection" })

-- move lines in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move line up" })

-- no highlight after search
map("n", "<Esc><Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
