require("transparent").setup({
	-- enable = true, -- boolean: enable transparent
	-- extra_groups = { -- table/string: additional groups that should be cleared
	-- 	"all",
	-- },
	-- exclude = {}, -- table: groups you don't want to clear
	-- ignore_linked_group = true, -- boolean: don't clear a group that links to another group
})

vim.cmd[[TransparentEnable]]
