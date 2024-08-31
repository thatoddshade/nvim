vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.clipboard = 'unnamedplus'

vim.o.number = true
vim.o.relativenumber = true

vim.o.signcolumn = 'yes'

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.opt.smartindent = true

-- disable mode printing in line on mode change
vim.o.showmode = false

vim.o.updatetime = 300

vim.o.cursorline = true

-- save undo information in a file
vim.o.undofile = true

vim.o.mouse = 'a'

vim.opt.listchars = { tab = "» ", extends = "|", trail = "·", nbsp = "␣" }
