return {
  "jakobkhansen/journal.nvim",
  config = function()
    require("journal").setup({
      journal = {
        format = '%Y/%m-%B-daily',
        template = function()
          return "# %Y %B %d"
        end
      }
    })
  end,
}
