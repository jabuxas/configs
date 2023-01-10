local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Simple plugins can be specified as strings
    use 'rstacruz/vim-closer'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        -- config = function()
        --     vim.cmd('colorscheme rose-pine')
        -- end
    })
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use('theprimeagen/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'jay-babu/mason-null-ls.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            -- Snippet Collection (Optional)
            { 'rafamadriz/friendly-snippets' },
        }
    }
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    use 'nvim-tree/nvim-web-devicons'
    use { 'romgrk/barbar.nvim', wants = 'nvim-web-devicons' }
    use 'feline-nvim/feline.nvim'
    use 'xiyaowong/nvim-transparent'
    -- use {
    --     "windwp/nvim-autopairs",
    --     config = function() require("nvim-autopairs").setup ({}) end
    -- }
    use({
        'nyoom-engineering/oxocarbon.nvim',
        as = 'oxocarbon',
        config = function()
            vim.opt.background = "dark"
            -- vim.cmd('colorscheme oxocarbon')
        end
    })
    use({
        "neanias/everforest-nvim",
        -- Optional; default configuration will be used if setup isn't called.
        config = function()
            -- vim.cmd('colorscheme everforest')
            require("everforest").setup()
        end,
    })

    use({
        "svrana/neosolarized.nvim",
        requires = {
            'tjdevries/colorbuddy.nvim'
        }
    })

    use({
        "aurum77/live-server.nvim",
        run = function()
            require "live_server.util".install()
        end,
        cmd = { "LiveServer", "LiveServerStart", "LiveServerStop" },
    })

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    use 'windwp/nvim-ts-autotag'

    use 'norcalli/nvim-colorizer.lua'
    use 'ThePrimeagen/vim-be-good'

    if packer_bootstrap then
        require('packer').sync()
    end
end)
