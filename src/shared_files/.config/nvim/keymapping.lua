local keymap = vim.api.nvim_set_keymap
local option = { noramp = true, silent = true }
local cmd = vim.cmd

# Toggle terminal
keymap('n', '<C-t>', ':terminal<CR>', option)