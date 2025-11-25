return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    vim.g.lazygit_floating_window_scaling_factor = 0.8
    vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>")
    require("telescope").load_extension("lazygit")
    vim.keymap.set("n", "<leader>gt", ":lua require('telescope').extensions.lazygit.lazygit()<CR>")
  end
}
