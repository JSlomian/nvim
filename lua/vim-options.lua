vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.g.mapleader = " "

vim.api.nvim_set_keymap("n", "<M-p>", ":", { noremap = true, silent = false })
vim.api.nvim_set_option("clipboard", "unnamedplus")

