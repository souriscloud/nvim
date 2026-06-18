local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- File tree (rebound to <leader>e to avoid <leader>f collision with telescope)
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
keymap.set("n", "<leader>E", ":NvimTreeFocus<CR>", opts)

-- Window splits
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts)
keymap.set("n", "<leader>sh", ":split<CR>", opts)

-- Buffers
keymap.set("n", "<leader>bd", ":bdelete<CR>", opts)
keymap.set("n", "[b", ":bprevious<CR>", opts)
keymap.set("n", "]b", ":bnext<CR>", opts)

-- Quickfix list (the :grep results buffer)
keymap.set("n", "]q", ":cnext<CR>", opts)
keymap.set("n", "[q", ":cprevious<CR>", opts)
keymap.set("n", "]Q", ":clast<CR>", opts)
keymap.set("n", "[Q", ":cfirst<CR>", opts)
keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", opts)

-- Visual indent: keep selection
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- Move selected lines (visual mode)
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Keep cursor centered on big jumps
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- Clear search highlight
keymap.set("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Note: <C-h/j/k/l> for split navigation are provided by vim-tmux-navigator.
-- Note: gc / gcc / visual gc commenting is built into Neovim (0.10+), no plugin.
