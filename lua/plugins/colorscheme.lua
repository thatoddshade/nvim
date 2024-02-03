require("lazy").setup({
	{ "kepano/flexoki-neovim", name = "flexoki" },
})

return {
	{ "kepano/flexoki-neovim", name = "flexoki" },
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "flexoki-dark",
		},
	},
}
