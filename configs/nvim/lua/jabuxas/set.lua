-- vim.opt.guicursor = ""
vim.opt.mouse = "a"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.clipboard:append({ "unnamedplus" })
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- vim.opt.colorcolumn = "80"

vim.g.mapleader = " "

-- Case insensitive searching UNLESS /C or capital in search
vim.opt.ignorecase = true
vim.opt.completeopt = "menuone,noselect"
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.cmd([[let &t_Cs = "\e[4:3m"]])
vim.cmd([[let &t_Ce = "\e[4:0m"]])

-- vim.o.foldcolumn = 1
-- vim.o.foldlevel = 99
-- vim.o.foldlevelstart= 0
-- vim.o.foldenable = true
