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
          { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
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
    'stevearc/dressing.nvim',

    -- Notifications
    {
        'rcarriga/nvim-notify',
        config = function()
            vim.notify = require('notify')
            vim.notify.setup({ background_colour = "#282c34" })
        end,
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

    -- Treesitter configurations and abstraction layer
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('init-treesitter')
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
            'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-context',
            'nvim-treesitter/playground',
            'JoosepAlviste/nvim-ts-context-commentstring',
            'p00f/nvim-ts-rainbow',
            'RRethy/nvim-treesitter-textsubjects',
            'windwp/nvim-ts-autotag',
        },
        -- Lazy loading strategy: Load on FileType event to enhance syntax highlighting
        event = 'BufRead',
    },



     -- Debugging support
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

    -- DAP (Debug Adapter Protocol) UI Enhancements
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            require('init-dap')
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
        config = function()
            require('bufferline').setup {}
        end,
        event = 'BufWinEnter', -- Load when a buffer window is entered
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

    -- Additional plugins can be configured similarly...

    -- Lazy.nvim allows specifying plugins to be loaded on certain triggers, which
    -- can significantly improve startup time. Review the documentation for
    -- advanced lazy loading strategies.
{ "ellisonleao/gruvbox.nvim",
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
    require("init-tree")
  end,
},

  {
    "liuchengxu/vista.vim",
    cmd = "Vista",
  },

})
