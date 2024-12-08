vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ctrl-s save
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
