local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- general
map("i", "jk", "<Esc>", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- barbar.nvim navigation
map("n", "<M-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<M-.>", "<Cmd>BufferNext<CR>", opts)
map("n", "<M-x>", "<Cmd>BufferClose<CR>", opts)

-- nvim-tree toggling
map("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>", opts)

-- telescope fuzzyfinder (todo)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

