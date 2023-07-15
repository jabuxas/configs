return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("theprimeagen/harpoon")
	use("nvim-lua/plenary.nvim")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"svrana/neosolarized.nvim",
		requires = {
			"tjdevries/colorbuddy.nvim",
		},
	})
	use({
		"aurum77/live-server.nvim",
	})
	use({
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	})
	use({ "alexghergh/nvim-tmux-navigation" })
	use({
		"windwp/nvim-ts-autotag",
		"windwp/nvim-autopairs",
	})
	use("norcalli/nvim-colorizer.lua")
	use("ThePrimeagen/vim-be-good")
	use({
		"declancm/maximize.nvim",
		config = function()
			require("maximize").setup()
		end,
	})
	use("andweeb/presence.nvim")
	use("nvim-lualine/lualine.nvim")
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use({
		"onsails/lspkind-nvim",
		"L3MON4D3/LuaSnip",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/nvim-cmp",
	})
	use("nvim-telescope/telescope.nvim")
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
	})
	use({
		"jose-elias-alvarez/null-ls.nvim",
		"jay-babu/mason-null-ls.nvim",
	})
	use("rafamadriz/friendly-snippets")
	use("saadparwaiz1/cmp_luasnip")
	use({
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	})
	use({
		"xiyaowong/nvim-transparent",
		-- config = function()
		-- 	require("transparent").setup({ enable = true })
		-- 	vim.g.transparent_percentage = 80
		-- end,
	})
	use("folke/zen-mode.nvim")
	use("folke/lsp-colors.nvim")
	use("AlexvZyl/nordic.nvim")
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				-- Optional
				"williamboman/mason.nvim",
				run = function()
					pcall(vim.cmd, "MasonUpdate")
				end,
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "jay-babu/mason-null-ls.nvim" },
		},
	})
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
	use("shaunsingh/nord.nvim")
	use("sindrets/diffview.nvim")
	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use("mattn/emmet-vim")
end)
