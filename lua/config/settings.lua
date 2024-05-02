vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.number = true
vim.wo.relativenumber = true

-- stolen from https://github.com/ThePrimeagen/init.lua/blob/ac393a29acb52069998b1eed51dd2c6adeca72fb/lua/theprimeagen/set.lua#L6
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

--vim.opt.hlsearch = false	-- not sure if I like this
vim.opt.incsearch = true

vim.opt.showmode = false

--vim.cmd([[set mousemodel=extend]])
vim.cmd([[set clipboard+=unnamedplus]])

vim.opt.cursorline = true

vim.opt.termguicolors = true

vim.opt.undofile = true

vim.opt.signcolumn = "yes"

vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
