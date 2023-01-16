local keymap = vim.keymap
local nvim_tmux_nav = require('nvim-tmux-navigation')


keymap.set("n", "<leader>pv", vim.cmd.Ex)
keymap.set("i", "jk", "<Esc>")

vim.g.mapleader = " "
keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- keymap.set("n", "<leader>e", vim.cmd.NreeToggle)

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("x", "<leader>p", [["_dP]])
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set({ "n", "v" }, "<leader>d", [["_d]])
keymap.set("i", "<C-c>", "<Esc>")

keymap.set("n", "Q", "<nop>")
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
keymap.set("n", "<leader>f", vim.lsp.buf.format)

keymap.set("n", "<A-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<A-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

keymap.set("t", "<leader><Esc>", [[<C-\><C-n>]])

keymap.set("n", "<leader>sv", "<C-w>v")
keymap.set("n", "<leader>sh", "<C-w>s")
keymap.set("n", "<leader>se", "<C-w>=")
keymap.set("n", "<leader>sx", ":close<CR>")

keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)
keymap.set('n', '<Leader>sm', "<Cmd>lua require('maximize').toggle()<CR>")

