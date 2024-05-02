local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "live grep" })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "help tags" })
