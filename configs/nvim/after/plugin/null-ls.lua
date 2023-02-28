local status, null_ls = pcall(require, "null-ls")
if not status then
	return
end

require("mason-null-ls").setup({
	automatic_setup = true,
	ensure_installed = { "rust", "javascript", "typescript", "html", "css", "python", "ruby" },
})

require("mason-null-ls").setup_handlers({
	function(source_name, methods)
		-- all sources with no handler get passed here

		-- To keep the original functionality of `automatic_setup = true`,
		-- please add the below.
		require("mason-null-ls.automatic_setup")(source_name, methods)
	end,
	stylua = function(source_name, methods)
		null_ls.register(null_ls.builtins.formatting.stylua)
	end,
})

-- will setup any installed and configured sources above
null_ls.setup()
