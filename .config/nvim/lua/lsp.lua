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
    { "python", "go", "rust", "c", "cpp", "zig", "zon", "typescript", "typescriptreact", "javascript", "javascriptreact" },
    { enabled = true }
)

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.basedpyright = { capabilities = capabilities }   -- python
vim.lsp.config.clangd = { capabilities = capabilities }         -- c/cpp
vim.lsp.config.gopls = { capabilities = capabilities }          -- golang
vim.lsp.config.rust_analyzer = { capabilities = capabilities }  -- rustlang
vim.lsp.config.ts_ls = { capabilities = capabilities }          -- ts/js
vim.lsp.config.zls = {                                          -- ziglang
    capabilities = capabilities,
    cmd = { "zls" },
    filetypes = { "zig", "zon" },
    root_markers = { "build.zig", "build.zig.zon", ".git" },
    settings = {
        zls = {
            zig_exe_path = "/home/dev/.bin/zig", -- NOTE: only compatible with stormdrain containers!
        },
    },
}

local ft_to_server = {
    python = "basedpyright",
    c = "clangd",
    cpp = "clangd",
    go = "gopls",
    rust = "rust_analyzer",
    typescript = "ts_ls",
    typescriptreact = "ts_ls",
    javascript = "ts_ls",
    javascriptreact = "ts_ls",
    zig = "zls",
    zon = "zls",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = vim.tbl_keys(ft_to_server),   -- automatically use all keys from the table
    callback = function(args)
        local ft = vim.bo[args.buf].filetype
        local server = ft_to_server[ft]
        if server then
            vim.lsp.enable(server)
        end
    end,
})

-- on-demand diagnostics
-- "grn" mapped to variable rename by default
vim.keymap.set("n", "gh", vim.diagnostic.open_float)
vim.keymap.set("n", "gj", vim.diagnostic.goto_next)
vim.keymap.set("n", "gk", vim.diagnostic.goto_prev)

