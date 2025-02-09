local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = false })<CR>', opts)
keymap('n', '<leader>ff', ':Telescope find_files<CR>', opts)
keymap('n', '<leader>u', ':UndotreeToggle<CR>', opts)
keymap('n', '<leader>fb', ':Telescope buffers<CR>', opts)
