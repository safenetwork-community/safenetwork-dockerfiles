local keymap = vim.api.nvim_set_keymap
local option = { noramp = true, silent = true }

-- Toggle terminal
keymap('n', '<C-t>', ':terminal<CR>', option)
