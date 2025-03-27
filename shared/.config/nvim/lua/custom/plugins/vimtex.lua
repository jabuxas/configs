return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_compiler_method = "tectonic"
  end,
  config = function()
    vim.api.nvim_create_autocmd({ "Filetype" }, {
      pattern = "tex",
      callback = function()
        vim.keymap.set("n", "<leader>cc", "<cmd>VimtexCompile<CR>", { desc = "Compile latex file" })
      end
    })
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      pattern = "*.tex",
      callback = function()
        vim.cmd [[VimtexCompile]]
      end
    })
  end
}
