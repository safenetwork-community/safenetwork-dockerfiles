local keymap = vim.api.nvim_set_keymap
local option = { noremap = true, silent = true }

-- Toggle terminal
keymap('n', '<C-t>', ':terminal<CR>', option)
