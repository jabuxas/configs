local home = os.getenv("HOME")
local colorscheme = {}
local open = io.open

local function read_file(path)
  local file = open(path, "rb")
  if not file then return nil end
  local content = file:read "*l"
  file:close()
  return content
end

local fileContent = read_file(string.format("%s/colorscheme", home));

if fileContent == "white" then
  colorscheme = {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'light'
      vim.opt.termguicolors = true
      vim.g.material_style = 'lighter'
      require('material').setup({})
      vim.cmd.colorscheme 'material'
      -- vim.cmd [[highlight ColorColumn ctermbg=235 guibg=#435156]]
    end,
  }
elseif fileContent == "red" then
  colorscheme = {
    "water-sucks/darkrose.nvim",
    lazy = false,
    dependencies = { "tjdevries/colorbuddy.vim" },
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("darkrose")
      vim.cmd [[highlight ColorColumn ctermbg=235 guibg=#262626]]
      local Color, colors, Group, groups, styles = require('colorbuddy').setup()

      Color.new("red", "#9E4244")
      Color.new("dark_red", "#6D0011")
      Color.new("light_red", "#F85149")
      Color.new("orange", "#A26B35")
      Color.new("light_orange", "#F0883E")
      Color.new("dark_purple", "#281C2B")
      Color.new("magenta", "#8B2950")
      Color.new("dark_pink", "#B76E79")
      Color.new("pink", "#FF7979")
      Color.new("light_pink", "#F6ACA7")
      Color.new("gray", "#8B8B8B")
      Color.new("bg", "#000000")
      Color.new("bg_float", "#101010")
      Color.new("bg_float_bright", "#121212")
      Color.new("fg", "#C9C1C9")
      Color.new("fg_gutter", "#8A95A2")
      Color.new("fg_dark", "#4D5566")


      Group.new("@neorg.links.file", colors.magenta, colors.none, styles.bold)
      Group.new("@comment", colors.gray, colors.none, styles.italic)
    end
  }
elseif fileContent == "melange" then
  colorscheme = {
    "savq/melange-nvim",
    lazy = false,
    dependencies = { "tjdevries/colorbuddy.vim" },
    priority = 1000,
    config = function()
      vim.opt.termguicolors = true
      vim.o.background = 'light'
      vim.cmd.colorscheme 'melange'
    end,

  }
elseif fileContent == "monochrome" then
  colorscheme = {
    'jesseleite/nvim-noirbuddy',
    dependencies = {
      { 'tjdevries/colorbuddy.nvim' }
    },
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        secondary = "#CCB901",
        primary = "#ccc04c"
      }
    },
  }
elseif fileContent == "rose" then
  colorscheme = {
    'jesseleite/nvim-noirbuddy',
    dependencies = {
      { 'tjdevries/colorbuddy.nvim' }
    },
    lazy = false,
    priority = 1000,
    opts = {
      colors = {
        primary = "#e57474",
        secondary = "#c96666"
      }
    },
  }
elseif fileContent == "forest" then
  colorscheme = {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      vim.o.termguicolors = true
      require("everforest").setup({
        background = "hard",
        italics = true,
        ui_contrast = "high",
        dim_inactive_windows = true,
      })

      vim.cmd.colorscheme("everforest")
    end,
  }
elseif fileContent == "solarized" then
  colorscheme = {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    ---@type solarized.config
    opts = {
      palette = 'solarized',
      styles = {
        comments = { italic = true, bold = false }
      },
    },
    config = function(_, opts)
      vim.o.termguicolors = true
      require('solarized').setup(opts)
      vim.o.background = 'dark'
      vim.cmd.colorscheme 'solarized'
    end,
  }

elseif fileContent == "wal" then
  colorscheme = {
    'uZer/pywal16.nvim',
    -- for local dev replace with:
    -- dir = '~/your/path/pywal16.nvim',
    config = function()
      vim.cmd.colorscheme("pywal16")
    end,
  }
else
  colorscheme = {
    'marko-cerovac/material.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'dark'
      vim.opt.termguicolors = true
      vim.g.material_style = 'darker'
      require('material').setup({})
      vim.cmd.colorscheme 'material'
    end,
  }
end

return colorscheme
