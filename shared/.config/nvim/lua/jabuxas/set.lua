vim.opt.mouse = "a"

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

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

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- colorcolumn
vim.opt.colorcolumn = "80"
local autocmd = vim.api.nvim_create_autocmd
autocmd({ "WinLeave" }, { pattern = "*", callback = function() vim.opt.colorcolumn = "0" end, })
autocmd({ "WinEnter" }, { pattern = "*", callback = function() vim.opt.colorcolumn = "80" end, })

-- disable bar any%
-- vim.opt.laststatus = 0


autocmd("Filetype", {
    pattern = "*",
    callback = function()
        vim.o.formatoptions = "jql"
    end
})

autocmd("Filetype", {
    pattern = { "markdown", "tex" },
    callback = function()
        vim.opt.wrap = true
        vim.o.formatoptions = "l"
        vim.o.breakindent = true
        vim.o.lbr = true
    end
})

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

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.g.python3_host_prog = "/usr/bin/python3"
