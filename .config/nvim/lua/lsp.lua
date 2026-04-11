local cmp = require("cmp")

cmp.setup({
    enabled = false,
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    },
})

-- disabled by default, enabled only for filetypes which have language server configured
cmp.setup.filetype(
    { "python", "go", "rust", "c" }, -- to disable suggestions (but still keep the lsp running), remove ext from here
    { enabled = true }
)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.pyright = { capabilities = capabilities }       -- python
vim.lsp.config.clangd = { capabilities = capabilities }        -- c/cpp
vim.lsp.config.gopls = { capabilities = capabilities }         -- go
vim.lsp.config.rust_analyzer = { capabilities = capabilities } -- rust

-- auto enable lsp for correct filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"python", "c", "cpp", "go", "rust"},
    callback = function(args)
        vim.lsp.enable({
            "pyright",
            "clangd",
            "gopls",
            "rust_analyzer",
        })
    end,
})

-- diagnostics on demand
vim.keymap.set("n", "gh", vim.diagnostic.open_float)
vim.keymap.set("n", "gj", vim.diagnostic.goto_next)
vim.keymap.set("n", "gk", vim.diagnostic.goto_prev)

-- "grn" mapped to variable rename by default

