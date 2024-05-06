require "config.keymaps.telescope"

local map = vim.keymap.set

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<c-up>", "<cmd>resize +2<cr>", { desc = "increase window height" })
map("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "decrease window height" })
map("n", "<c-left>", "<cmd>vertical resize -2<cr>", { desc = "decrease window width" })
map("n", "<C-right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "move up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "prev buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "switch to other buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "switch to other buffer" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "next search result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "prev search result" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "save file" })

--keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "new file" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "location list" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "quickfix list" })

map("n", "[q", vim.cmd.cprev, { desc = "previous quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "next quickfix" })

-- formatting
--map({ "n", "v" }, "<leader>cf", function()
--  LazyVim.format({ force = true })
--end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "line diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "next diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "prev diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "next error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "prev error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "next warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "prev warning" })

-- stylua: ignore start

-- toggle options
--map("n", "<leader>uf", function() LazyVim.format.toggle() end, { desc = "Toggle Auto Format (Global)" })
--map("n", "<leader>uF", function() LazyVim.format.toggle(true) end, { desc = "Toggle Auto Format (Buffer)" })
--map("n", "<leader>us", function() LazyVim.toggle("spell") end, { desc = "Toggle Spelling" })
--map("n", "<leader>uw", function() LazyVim.toggle("wrap") end, { desc = "Toggle Word Wrap" })
--map("n", "<leader>uL", function() LazyVim.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
--map("n", "<leader>ul", function() LazyVim.toggle.number() end, { desc = "Toggle Line Numbers" })
--map("n", "<leader>ud", function() LazyVim.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
--local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
--map("n", "<leader>uc", function() LazyVim.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
--if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
--  map( "n", "<leader>uh", function() LazyVim.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
--end
map("n", "<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" })
--map("n", "<leader>ub", function() LazyVim.toggle("background", false, {"light", "dark"}) end, { desc = "Toggle background" })

-- lazygit
--map("n", "<leader>gg", function() LazyVim.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
--map("n", "<leader>gG", function() LazyVim.lazygit() end, { desc = "Lazygit (cwd)" })

--map("n", "<leader>gf", function()
--  local git_path = vim.api.nvim_buf_get_name(0)
--  LazyVim.lazygit({args = { "-f", vim.trim(git_path) }})
--end, { desc = "Lazygit Current File History" })

-- quit
--map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- LazyVim Changelog
--map("n", "<leader>L", function() LazyVim.news.changelog() end, { desc = "LazyVim changelog" })

-- floating terminal
--local lazyterm = function() LazyVim.terminal(nil, { cwd = LazyVim.root() }) end
--map("n", "<leader>ft", lazyterm, { desc = "Terminal (Root Dir)" })
--map("n", "<leader>fT", function() LazyVim.terminal() end, { desc = "Terminal (cwd)" })
--map("n", "<c-/>", lazyterm, { desc = "Terminal (Root Dir)" })
--map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- terminal mappings
map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter normal mode" })
map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
map("n", "<leader>-", "<C-W>s", { desc = "Split window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })

-- tabs
map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
