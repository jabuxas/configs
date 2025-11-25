return {
  "ThePrimeagen/harpoon",
  opts = {},
  config = function()
    vim.keymap.set("n", "<leader>m", [[<cmd>lua require("harpoon.mark").add_file()<CR>]],
      { desc = "add harpoon mark to current file" })
    vim.keymap.set("n", "<leader>M", [[<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>]],
      { desc = "open harpoon quick menu" })
    for i = 1, 5 do
      local keybinding = string.format("<A-%s>", i)
      local command = string.format("<cmd>lua require('harpoon.ui').nav_file(%s)<CR>", i)
      vim.keymap.set("n", keybinding, command, { desc = string.format("go to %s° mark", i) })
    end
  end
}
