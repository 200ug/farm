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
    -- to disable suggestions (but still keep the lsp running), simply remove the ext from here
    { "python", "go", "rust", "c", "typescript", "typescriptreact", "javascript", "javascriptreact" },
    { enabled = true }
)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.basedpyright = { capabilities = capabilities }   -- python
vim.lsp.config.clangd = { capabilities = capabilities }         -- c/cpp
vim.lsp.config.gopls = { capabilities = capabilities }          -- golang
vim.lsp.config.rust_analyzer = { capabilities = capabilities }  -- rustlang
vim.lsp.config.ts_ls = { capabilities = capabilities }          -- typescript/javascript

-- auto enable lsp for correct filetypes
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"python", "c", "cpp", "go", "rust", "typescript", "typescriptreact", "javascript", "javascriptreact"},
    callback = function(args)
        vim.lsp.enable({
            "basedpyright",
            "clangd",
            "gopls",
            "rust_analyzer",
            "ts_ls",
        })
    end,
})

-- diagnostics on demand
vim.keymap.set("n", "gh", vim.diagnostic.open_float)
vim.keymap.set("n", "gj", vim.diagnostic.goto_next)
vim.keymap.set("n", "gk", vim.diagnostic.goto_prev)

-- "grn" mapped to variable rename by default

