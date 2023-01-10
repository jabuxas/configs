-- vim.opt.guicursor = ""
vim.opt.mouse = 'a'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.clipboard:append { 'unnamedplus' }
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.completeopt = 'menuone,noselect'
vim.o.smartcase = true
