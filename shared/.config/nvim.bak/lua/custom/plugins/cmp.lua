return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    {
      'onsails/lspkind.nvim',
      config = function()
        require('lspkind').init({
          mode = "symbol",
          preset = "default",
          symbol_map = {
            Text = "",
            Method = " ",
            Function = " ",
            Constructor = " ",
            Field = " ",
            Variable = " ",
            Class = "ﴯ ",
            Interface = " ",
            Module = " ",
            Property = "ﰠ ",
            Unit = " ",
            Value = " ",
            Enum = " ",
            Keyword = " ",
            --     Snippet = " ",
            Color = " ",
            File = " ",
            Reference = " ",
            Folder = " ",
            EnumMember = " ",
            Constant = " ",
            Struct = " ",
            Event = " ",
            Operator = " ",
            TypeParameter = " "
          },
        })
      end
    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',

    -- Adds a number of user-friendly snippets
    'rafamadriz/friendly-snippets',
  },
  config = function()
    local cmp = require 'cmp'
    local winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel"
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      preselect = cmp.PreselectMode.None,
      completion = {
        completeopt = "menu,menuone,noinsert"
      },
      -- sorting = {
      --   -- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
      --   comparators = {
      --     cmp.config.compare.offset,
      --     cmp.config.compare.exact,
      --     cmp.config.compare.score,
      --
      --     -- copied from cmp-under, but I don't think I need the plugin for this.
      --     -- I might add some more of my own.
      --     function(entry1, entry2)
      --       local _, entry1_under = entry1.completion_item.label:find("^_+")
      --       local _, entry2_under = entry2.completion_item.label:find("^_+")
      --       entry1_under = entry1_under or 0
      --       entry2_under = entry2_under or 0
      --       if entry1_under > entry2_under then
      --         return false
      --       elseif entry1_under < entry2_under then
      --         return true
      --       end
      --     end,
      --
      --     cmp.config.compare.kind,
      --     cmp.config.compare.sort_text,
      --     cmp.config.compare.length,
      --     cmp.config.compare.order,
      --   },
      -- },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        {
          name = 'lazydev',
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'buffer' },
      },
      -- formatting = {
      --   fields = { "abbr", "menu", "kind" },
      --   format = require('lspkind').cmp_format({
      --     mode = 'symbol_text', -- show only symbol annotations
      --     maxwidth = 50,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      --     -- can also be a function to dynamically calculate max width such as
      --     -- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
      --     ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
      --     show_labelDetails = true, -- show labelDetails in menu. Disabled by default
      --
      --     -- The function below will be called before any actual modifications from lspkind
      --     -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      --   })
      -- },
      -- window = {
      --   completion = cmp.config.window.bordered(winhighlight),
      --   documentation = cmp.config.window.bordered(winhighlight),
      -- },

      experimental = {
        ghost_text = true,
      },
    }

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )
  end,
}
