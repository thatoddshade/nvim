vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.opt.number = true
vim.wo.relativenumber = true

vim.opt.showmode = false

vim.cmd([[set mousemodel=extend]])
vim.cmd([[set clipboard+=unnamedplus]])

vim.opt.cursorline = true

vim.opt.termguicolors = true

vim.opt.undofile = true

vim.opt.signcolumn = "yes"

vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

require("config")

require("lualine").setup()

vim.cmd([[colorscheme flexoki-dark]])
