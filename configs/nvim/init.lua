require("jabuxas")
if vim.g.neovide then
	vim.o.guifont = "Cartograph CF Demi Bold:h13"
	vim.g.neovide_transparency = 0.95
	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_refresh_rate = 60
	-- vim.g.neovide_background_color = "#292522"
	-- vim.cmd("hi Normal guibg=#78997a")
end

vim.g.solarized_italic_comments = true
vim.g.solarized_italic_keywords = false
vim.g.solarized_italic_functions = true
vim.g.solarized_italic_variables = false
