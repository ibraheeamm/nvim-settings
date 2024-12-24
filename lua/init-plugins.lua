local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazy = require('lazy')

lazy.setup({

    {
        'towolf/vim-helm',

    },

    -- lsp support
    {
        "neovim/nvim-lspconfig",
        dependencies = {
          { "folke/neoconf.nvim", cmd = "Neoconf", opts = {}, dependencies = { "nvim-lspconfig" } },
          { "folke/neodev.nvim", opts = {} },
          "williamboman/mason-lspconfig.nvim",
      },
        config = function()
            require("init-lspconf")
        end,
        event = { "BufReadPre", "BufNewFile", "BufEnter" },
    },

    -- lsp formatter
    'lukas-reineke/lsp-format.nvim',

    -- Go development
    {
        'fatih/vim-go',
        build = 'GoUpdateBinaries',
        config = function()
            require('init-go')
        end,
    },

    -- GitHub Copilot
    {
        'github/copilot.vim',
        config = function()
            require("init-copilot")
        end,
    },

    -- Autopairs
    {
        'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup({})
        end,
    },

    -- Lua functions library
    'nvim-lua/plenary.nvim',

    -- UI components for Neovim
    'MunifTanjim/nui.nvim',
    {
        'stevearc/dressing.nvim',
        opts = {
                input = { border = 'rounded' },
                select = { backend = { 'telescope', 'fzf', 'builtin' } },
        },
    },

    -- Notifications
    {
        'rcarriga/nvim-notify',
        opts = {
            stages = 'fade_in_slide_out',
            timeout = 2000,
            render = 'minimal',
        },
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('init-telescope')
        end,
    },

    -- Media file preview extension for telescope
    {
        'nvim-telescope/telescope-media-files.nvim',
        -- Lazy loading strategy: Load after telescope is loaded
    },


    -- Tree setter dependencies
    {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
            require('ts_context_commentstring').setup({
                enable_autocmd = false,
            })
        end,

    },

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup({
                pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
            })
        end,
        event = { "BufReadPost", "BufNewFile" }, -- Lazy-load when needed

    },

    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup({
              opts = {
                -- Defaults
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false -- Auto close on trailing </
              },
              -- Also override individual filetype configs, these take priority.
              -- Empty by default, useful if one of the "opts" global settings
              -- doesn't work well in a specific filetype
              per_filetype = {
                ["html"] = {
                  enable_close = false
                }
              },
            })
        end,
    },

    -- Treesitter configurations and abstraction layer
    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-context',
            'p00f/nvim-ts-rainbow',
            'RRethy/nvim-treesitter-textsubjects',
        },
        build = ':TSUpdate',
        config = function()
            require('init-treesitter')
        end,
        -- Lazy loading strategy: Load on FileType event to enhance syntax highlighting
        event = 'BufReadPost',
    },



     -- Debugging support
    {
        'nvim-neotest/nvim-nio',
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            require('init-dap')
        end,
        -- Lazy loading strategy: Load on command or specific filetype
        cmd = {'DapContinue', 'DapBreakpoint'},
    },

    -- Color schemes
    {
        'shaunsingh/nord.nvim',
        config = function()
            require('init-theme')
        end,
    },
      -- Symbol outline
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require('symbols-outline').setup({})
        end,
    },

    -- Indentation guides for Neovim
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            require('init-indent')
        end,
    },

    {
        'windwp/windline.nvim',
        config = function()
            require('init-windline')
        end,
    },
    {
        'akinsho/nvim-bufferline.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons'
        },
        config = function()
            require('bufferline').setup({
                options = {
                  numbers = "none", -- Options: "none", "ordinal", "buffer_id", "both", or a function
                  diagnostics = "nvim_lsp", -- Options: false, "nvim_lsp", "coc"
                  separator_style = "slant", -- Options: "slant", "thick", "thin", or a table with custom separators
                  offsets = {
                    {
                    filetype = "NvimTree",
                    text = "File Explorer",
                    text_align = "center", -- Options: "left", "center", "right"
                    },
                },
                    -- Additional options can be configured here
                },
            })
        end,
    },

    -- Git Integration
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('init-gitsigns')
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        config = function()
            require("init-cmp")
        end,
        dependencies = {
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-nvim-lsp" },
            -- snippet support
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" }
        }
    },

    {
        "nvimtools/none-ls.nvim",
        config = function()
            require("init-null-ls")
        end,
    },

    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("init-gruvbox")
        end,
    },

    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons",
                config = function()
                    require("init-icons")
                end,
            },
        },
        config = function()
            require("init-nvim-tree")
        end,
    },

    {
      "hedyhli/outline.nvim",
      config = function()
        -- Example mapping to toggle outline
        vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

        require("outline").setup {
          -- Your setup opts here (leave empty to use defaults)
        }
      end,
    },

    {
        "preservim/vim-markdown",
        ft = { "markdown" },
        config = function()
            require("init-markdown")
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
        config = function()
            require("init-markdown-preview")
        end,

    },
})
