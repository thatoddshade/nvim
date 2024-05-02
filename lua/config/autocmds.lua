local augroup = vim.api.nvim_create_augroup
local lsp_attach_group = augroup("lsp-attach", {})

local autocmd = vim.api.nvim_create_autocmd

-- stolen from https://github.com/ThePrimeagen/init.lua/blob/ac393a29acb52069998b1eed51dd2c6adeca72fb/lua/theprimeagen/init.lua#L49
autocmd('LspAttach', {
    group = lsp_attach_group,
    callback = function(e)
	local opts = { buffer = e.buf }
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    end
})
