require("plugins") -- packer.nvim

-- disable netrw (should be at the very start of init.lua)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- leader
vim.g.mapleader = ","
vim.g.maplocalleader = "-"

-- regular options
vim.opt.number = true             -- regular line numbers
vim.opt.relativenumber = true     -- relative line numbers
vim.opt.smartcase = true          -- ignore lowercase for the whole pattern
vim.opt.ignorecase = true         -- ignore case letters when search
vim.opt.mouse = "a"               -- enable mouse support (in all modes)
vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.swapfile = false          -- don't use swapfile
vim.opt.termguicolors = true      -- enable 24-bit RGB colors
vim.opt.laststatus = 3            -- set global statusline
vim.opt.expandtab = true          -- replace tabs with spaces
vim.opt.tabstop = 4               -- maximum tab width
vim.opt.softtabstop = 4           -- redefine tab as spaces
vim.opt.shiftwidth = 4            -- size of an indent
vim.opt.smartindent = true        -- indentation guessed based on syntax etc.
vim.wo.wrap = true                -- window-scope option(s)
vim.opt.termguicolors = true      -- enable 24-bit colour
vim.opt.signcolumn = "yes"        -- always draw the sign column (prevents flickering from lsp updates)

-- disable automatic comment on newline
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
    end,
})

-- default setup of nvim-tree
require("nvim-tree").setup()

require("mappings")
require("lsp")
require("treesitter")

