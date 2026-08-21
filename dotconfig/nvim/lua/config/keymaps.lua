local map = vim.keymap.set

-- basics
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
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
