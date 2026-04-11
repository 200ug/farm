require("nvim-treesitter").setup({
    ensure_installed = { "c", "python", "go", "markdown", "markdown_inline" },
    highlight = {
        enable = true,
    },
})

vim.cmd("colorscheme kanagawa")

