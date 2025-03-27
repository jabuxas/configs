return {
  "mattn/emmet-vim",
  config = function()
    local autocmd = vim.api.nvim_create_autocmd
    autocmd("FileType", { pattern = { "html", "php", "css", "vue", "js", "htmldjango" }, command = [[EmmetInstall]] })

    vim.keymap.set("n", "<leader>le", function()
      vim.cmd(string.format("Emmet %s", vim.fn.input("Emmet: ")))
    end)
  end,
}
