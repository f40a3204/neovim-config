vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap('n', '<C-c>', '"+y', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-c>', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-v>', '"+p', { noremap = true })
vim.api.nvim_set_keymap('v', '<C-v>', '"+p', { noremap = true })


vim.api.nvim_set_keymap('n', 'f', 'cl', {})


vim.api.nvim_set_keymap('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<C-p>', '<C-r>', {noremap = true})

vim.api.nvim_set_keymap('t', '<C-x>', vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, true, true), {noremap = true})

