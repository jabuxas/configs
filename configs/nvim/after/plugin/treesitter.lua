require("nvim-treesitter.configs").setup({
	-- a list of parser names, or "all"
	ensure_installed = {
		"help",
		"python",
		"javascript",
		"c",
		"lua",
		"rust",
		"bash",
		"gitignore",
		"vim",
		"markdown",
		"html",
		"css",
	},

	-- install parsers synchronously (only applied to `ensure_installed`)
	sync_install = true,

	-- automatically install missing parsers when entering buffer
	-- recommendation: set to false if you don't have `tree-sitter` cli installed locally
	auto_install = true,

	highlight = {
		-- `false` will disable the whole extension
		enable = true,
		-- setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- using this option may slow down your editor, and you may see some duplicate highlights.
		-- instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},

	autotag = {
		enable = true,
	},

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<cr>",
			node_incremental = "<cr>",
			scope_incremental = "<s-cr>",
			node_decremental = "<bs>",
		},
	},
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
