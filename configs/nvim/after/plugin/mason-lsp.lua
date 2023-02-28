require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "rust_analyzer", "pyright", "cssls", "hls", "html", "tsserver" },
})

local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
	return
end

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"rust_analyzer",
		"tsserver",
        "html",
        "pyright"
	},
})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lsp_attach = function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
	-- Create your keybindings here...
    if client.name == "eslint" then
        vim.cmd.LspStop("eslint")
        return
    end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end

require("luasnip.loaders.from_vscode").lazy_load()

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			on_attach = lsp_attach,
			capabilities = lsp_capabilities,
		})
	end,
})
