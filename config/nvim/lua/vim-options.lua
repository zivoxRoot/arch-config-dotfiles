-- General options
vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true

vim.opt.swapfile = false

vim.o.undofile = true

-- Keymaps
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", {silent = true, desc = "Clear search highlight"})
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Noice dismiss
vim.api.nvim_set_keymap("n", "<leader>nn", ":Noice dismiss<CR>", {noremap=true})
