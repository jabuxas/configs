-- https://learnxinyminutes.com/docs/lua/

vim.g.mapleader = ' '
vim.g.user_emmet_install_global = 0
vim.g.user_emmet_leader_key = ","
vim.g.maplocalleader = ' '

-- this is for my personal config, i cant bother seeing every TJ's default and changing it to my own
require("jabuxas")

if not vim.g.vscode then
    local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
    if not vim.loop.fs_stat(lazypath) then
        vim.fn.system {
            'git',
            'clone',
            '--filter=blob:none',
            'https://github.com/folke/lazy.nvim.git',
            '--branch=stable', -- latest stable release
            lazypath,
        }
    end
    vim.opt.rtp:prepend(lazypath)

    require('lazy').setup({
        -- Git related plugins
        'tpope/vim-fugitive',
        'tpope/vim-rhubarb',
        -- Detect tabstop and shiftwidth automatically
        'tpope/vim-sleuth',
        {
            -- LSP Configuration & Plugins
            'neovim/nvim-lspconfig',
            dependencies = {
                -- Automatically install LSPs to stdpath for neovim
                { 'williamboman/mason.nvim', config = true },
                'williamboman/mason-lspconfig.nvim',
                'WhoIsSethDaniel/mason-tool-installer.nvim',

                {
                    'j-hui/fidget.nvim',
                    tag = 'legacy',
                    opts = {
                        align = {
                            bottom = false,
                        },
                        window = {
                            blend = 0,
                            -- border = "rounded",
                        },
                    },
                },

                {
                    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
                    -- used for completion, annotations and signatures of Neovim apis
                    'folke/lazydev.nvim',
                    ft = 'lua',
                    opts = {
                        library = {
                            -- Load luvit types when the `vim.uv` word is found
                            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
                        },
                    },
                },
            },
        },


        -- Useful plugin to show you pending keybinds.
        { 'folke/which-key.nvim',                    opts = {} },
        {
            -- Adds git related signs to the gutter, as well as utilities for managing changes
            'lewis6991/gitsigns.nvim',
            opts = {
                -- See `:help gitsigns.txt`
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                on_attach = function(bufnr)
                    vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
                    vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
                    vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' })
                end,
            },
        },


        {
            -- Add indentation guides even on blank lines
            'lukas-reineke/indent-blankline.nvim',
            -- Enable `lukas-reineke/indent-blankline.nvim`
            -- See `:help indent_blankline.txt`
            main = 'ibl',
            opts = {},
        },
        {
            "ray-x/lsp_signature.nvim",
            event = "VeryLazy",
            opts = {},
            config = function(_, opts) require'lsp_signature'.setup(opts) end
        },

        -- "gc" to comment visual regions/lines
        { 'numToStr/Comment.nvim',                   opts = {} },

        { "nvim-treesitter/nvim-treesitter-context", opts = {} },

        -- Fuzzy Finder (files, lsp, etc)
        { 'nvim-telescope/telescope.nvim',           branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },

        {
            -- Highlight, edit, and navigate code
            'nvim-treesitter/nvim-treesitter',
            dependencies = {
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            build = ':TSUpdate',
            config = function(_, opts)
                vim.filetype.add {
                    extension = { rasi = 'rasi' },
                    pattern = {
                        ['.*/waybar/config'] = 'jsonc',
                        ['.*/kitty/*.conf'] = 'bash',
                        ['.*/hypr/.*%.conf'] = 'hyprlang',
                    },
                }
            end
        },

        require 'kickstart.plugins.autoformat',
        require 'kickstart.plugins.debug',

        { import = 'custom.plugins' },
    }, {})

    -- Set highlight on search
    vim.o.hlsearch = false

    -- Make line numbers default
    vim.wo.number = true

    -- Enable mouse mode
    vim.o.mouse = 'a'

    vim.schedule(function()
        vim.opt.clipboard = 'unnamedplus'
    end)

    -- Enable break indent
    vim.o.breakindent = true

    -- Save undo history
    vim.o.undofile = true

    -- Case-insensitive searching UNLESS \C or capital in search
    vim.o.ignorecase = true
    vim.o.smartcase = true

    -- Keep signcolumn on by default
    vim.wo.signcolumn = 'yes'

    -- Decrease update time
    vim.o.updatetime = 250
    vim.o.timeoutlen = 300

    -- Set completeopt to have a better completion experience
    vim.o.completeopt = 'menuone,noselect'

    -- NOTE: You should make sure your terminal supports this
    vim.o.termguicolors = true

    -- Keymaps for better default experience
    vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

    -- Remap for dealing with word wrap
    vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

    -- [[ Highlight on yank ]]
    local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
    vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
            vim.highlight.on_yank()
        end,
        group = highlight_group,
        pattern = '*',
    })

    -- [[ Configure Telescope ]]
    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                },
            },
        },
        pickers = {
            find_files = {
                theme = "ivy",
            }
        },
        extensions = {
            -- file_browser = {
                --     initial_mode = "normal",
                --     theme = "ivy",
                --     hijack_netrw = true
                -- },
            },
        }

        -- Enable telescope fzf native, if installed
        pcall(require('telescope').load_extension, 'fzf')

        -- See `:help telescope.builtin`
        vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 0,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>rg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

        -- [[ Configure Treesitter ]]
        -- See `:help nvim-treesitter`
        require('nvim-treesitter.configs').setup {
            -- Add languages to be installed here that you want installed for treesitter
            ensure_installed = { 'c', 'go', 'lua', 'python', 'tsx', 'typescript', 'markdown', 'bash', 'html', 'css' },

            -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
            auto_install = true,

            highlight = { enable = true },
            -- indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<M-space>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    },
                },
            },
        }

        -- Diagnostic keymaps
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

        -- [[ Configure LSP ]]
        --  This function gets run when an LSP connects to a particular buffer.
        local on_attach = function(_, bufnr)
            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
                vim.lsp.buf.format()
            end, { desc = 'Format current buffer with LSP' })

            vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
            vim.lsp.handlers.hover, {
                border = "single"
            }
            )
            vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
            vim.lsp.handlers.signatureHelp, {
                border = "single"
            }
            )
            vim.diagnostic.config({ float = { border = "single" } })
        end
        local mason_registry = require('mason-registry')
        local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
        '/node_modules/@vue/language-server'
        local servers = {
            ocamllsp = {},

            ts_ls = {
                init_options = {
                    plugins = {
                        {
                            name = '@vue/typescript-plugin',
                            location = vue_language_server_path,
                            languages = { 'vue' },
                        },
                    },
                },
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
            },

            gopls = {
                gopls = {
                    usePlaceholders = true,
                    analyses = {
                        unusedparams = true,
                    }
                },
            },
            html = { provideFormatter = false, filetypes = {"html", "htmldjango", "php"} },
            cssls = {},
            pyright = {
                settings = {
                    pyright = {
                        disableOrganizeImports = false,
                    },
                    python = {
                        analysis = {
                            diagnosticMode = "workspace"
                        }
                    }
                }
            },

            jdtls = {
                java = {
                    configuration = {
                        runtimes = {
                            name = "JavaSE-17",
                            path = "/usr/lib/jvm/java-17-openjdk",
                            default = true,
                        }
                    }
                }
            },

            volar = {
                init_options = {
                    vue = {
                        hybridMode = true,
                    },
                },

                phpactor = {
                    -- init_options = {
                        --     language_server_phpstan.enabled = false,
                        --     language_server_psalm.enabled = false,
                        -- },
                    },

                    ts_ls = {
                        init_options = {
                            plugins = {
                                {
                                    name = '@vue/typescript-plugin',
                                    location = vue_language_server_path,
                                    languages = { 'vue', "typescript", "javascript" },
                                },
                            },
                        },
                        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                    },

                    lua_ls = {
                        Lua = {
                            workspace = { checkThirdParty = true },
                            telemetry = { enable = false },
                        },
                    },
                }}

                -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
                capabilities.textDocument.completion.completionItem.snippetSupport = true

                require('mason').setup()

                local ensure_installed = vim.tbl_keys(servers or {})
                vim.list_extend(ensure_installed, {
                    'stylua',
                    'black',
                    'prettierd',
                    'gofumpt',
                    'goimports-reviser',
                    'golines',
                    'golangci-lint',
                    'ruff',
                    'phpcbf',
                })
                require('mason-tool-installer').setup { ensure_installed = ensure_installed }


                require('mason-lspconfig').setup {
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}
                            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                            require('lspconfig')[server_name].setup(server)
                        end,
                    },
                }


                local manual_servers = {
                    texlab = {},

                    rust_analyzer = {
                        settings = {
                            ['rust_analyzer'] = {
                                cargo = {
                                    allFeatures = true,
                                }
                            }
                        }
                    }
                }

                for server_name, config in pairs(manual_servers) do
                    config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
                    require('lspconfig')[server_name].setup(config)
                end
                require("jabuxas.nvim")
else
    require "jabuxas.vscode_keymaps"
end
