-- * installation handled automagically with the bootstrapping function *

-- :PackerCompile after plugin config changes
-- :PackerClean to remove disabled/unused plugins
-- :PackerInstall to clean and install new/missing plugins
-- :PackerUpdate to clean, update, and install plugins
-- :PackerStatus to list installed plugins

-- automatically run :PackerCompile whenever this file is updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- automatic bootstrapping on fresh systems (https://github.com/wbthomason/packer.nvim#bootstrapping)
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    -- packer can manage itself
    use "wbthomason/packer.nvim"

    -- file tree
    use {
        "nvim-tree/nvim-tree.lua",
        requires = {
            "nvim-tree/nvim-web-devicons", -- optional
        },
    }

    -- tabline
    use "romgrk/barbar.nvim"

    -- autopairs
    use {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup {}
        end,
    }

    -- git gutter change indicators
    use {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    }

    -- syntax highlighting (configs in treesitter.lua)
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }

    -- treesitter supported colorscheme
    use "rebelot/kanagawa.nvim"

    -- lsp (configs in lsp.lua)
    use "neovim/nvim-lspconfig"

    -- autocompletion (configs in lsp.lua)
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"

    -- fuzzy finder
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    mappings = {
                        n = {
                            ["q"] = require("telescope.actions").close,
                        }
                    }
                }
            })
        end,
    }

    -- automatically setup configs after cloning packer.nvim (during bootstrapping)
    if packer_bootstrap then
        require('packer').sync()
    end
end)

