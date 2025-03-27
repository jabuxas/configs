return {
  "folke/zen-mode.nvim",
  opts = {
    plugins = {
      kitty = {
        enabled = true,
        font = "+3",
      },
      wezterm = {
        enabled = true,
        font = "+3"
      },
      tmux = { enabled = true },
    },
    on_open = function()
      vim.fn.system("kitty @ set-font-size +5")
      vim.fn.system("tmux set status off")
      vim.fn.system("tmux set -w pane-border-status off")
    end,
    on_close = function()
      vim.fn.system("kitty @ set-font-size +0")
      vim.fn.system("tmux set status on")
      vim.fn.system("tmux set -w pane-border-status on")
    end,
  },
  config = function()
    vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { silent = true })
  end
}
