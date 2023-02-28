local status, cmp = pcall(require, "cmp")
if not status then
	return
end
local lspkind = require("lspkind")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.scroll_docs(-4),
		["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
        { name = 'luasnip'},
        { name = 'path'}
	}),
	formatting = {
		format = lspkind.cmp_format({ with_text = false, maxwidth = 40 }),
	},
})

vim.api.nvim_set_keymap('i', '<Tab>', 'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : "<Tab>"', {expr=true, silent=true})
vim.api.nvim_set_keymap('i', '<S-Tab>', '<cmd>lua require("luasnip").jump(-1)<CR>', {silent=true})
vim.api.nvim_set_keymap('s', '<Tab>', '<cmd>lua require("luasnip").jump(1)<CR>', {silent=true})
vim.api.nvim_set_keymap('s', '<S-Tab>', '<cmd>lua require("luasnip").jump(-1)<CR>', {silent=true})
vim.api.nvim_set_keymap('i', '<C-F>', 'luasnip#choice_active() ? "<Plug>luasnip-next-choice" : "<C-E>"', {expr=true, silent=true})
vim.api.nvim_set_keymap('s', '<C-F>', 'luasnip#choice_active() ? "<Plug>luasnip-next-choice" : "<C-E>"', {expr=true, silent=true})

vim.cmd([[
  set completeopt=menuone,noinsert,noselect
  highlight! default link CmpItemKind CmpItemMenuDefault
]])
