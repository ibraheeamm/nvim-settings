local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()
return require("packer").startup(function(use)
    -- package manager
    use("wbthomason/packer.nvim")
    -- lsp support
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("init-lspconf")
        end,
    })
    use("lukas-reineke/lsp-format.nvim")
    -- go.nvim
    use({ 
	    "fatih/vim-go", 
	    run = 'GoUpdateBinaries'
    })
    -- github copilot
    use({
        "github/copilot.vim",
         package_root = os.getenv("HOME") .. '/.config/nvim/pack/github/start/copilot.vim'
            -- install the plugin in specific folder

        })
       
    use ({ 
	    "windwp/nvim-autopairs", 
	    config = function() require("nvim-autopairs").setup {} end
	    })
    -- lua functions
    use("nvim-lua/plenary.nvim")
    -- neovim ui components
    use("MunifTanjim/nui.nvim")
    use("stevearc/dressing.nvim")
    -- icons for other plugins
    use({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup({ default = true })
        end,
    })
    -- termial integration
    use({
        "akinsho/nvim-toggleterm.lua",
        tag = "*",
        config = function()
            require("init-term")
        end,
    })
    -- notification manager
    use({
        "rcarriga/nvim-notify",
        config = function()
            vim.notify = require("notify")
            -- hardcoded background color
            vim.notify.setup({ background_colour = "#282c34" })
        end
    })
    -- vim helm
    use('towolf/vim-helm')

    -- auto completion
    use({
        "hrsh7th/nvim-cmp",
        config = function()
            require("init-cmp")
        end,
        requires = {
            { "hrsh7th/cmp-path" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-nvim-lsp" },
            -- snippet support
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" }
        },
    })

    -- null-ls for missing ls functionalities
    -- disable null-ls tempoaraly
    -- use({
    --     "jose-elias-alvarez/null-ls.nvim",
    --     config = function()
    --         require("init-null-ls")
    --     end,
    -- })
    -- java lsp
    use({
        "mfussenegger/nvim-jdtls",
        ft = { "java" },
        config = function()
            require("init-jdtls")
        end,
    })
    -- symbol outline by lsp
    use({ "simrat39/symbols-outline.nvim",
        config = function()
            require("symbols-outline").setup({})
        end, })
    -- dap support
    use({
        "rcarriga/nvim-dap-ui",
        config = function()
            require("init-dap")
        end,
        requires = { { "mfussenegger/nvim-dap" }, { "theHamsta/nvim-dap-virtual-text" } },
    })

    use({
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("init-indent")
        end,
    })

    -- color scheme
    use({
        "shaunsingh/nord.nvim",
        config = function()
            require("init-theme")
        end,
    })
    -- solarized color scheme
    use({
        "shaunsingh/solarized.nvim",
        config = function ()
            require("init-theme")
        end,

    })

    -- status line
    use({
        "windwp/windline.nvim",
        config = function()
            require("init-windline")
        end,
    })
    -- clickable buffer line
    use({
        "akinsho/nvim-bufferline.lua",
        config = function()
            require("bufferline").setup()
        end,
    })
    -- git integration
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("init-gitsigns")
        end,
    })
    -- which-key
    use({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end,
    })

    use({"nvim-treesitter/nvim-treesitter" , run = 'TSUpdate'})
    -- file explorer
    use({
        "kyazdani42/nvim-tree.lua",
        config = function()
            require("init-tree")
        end,
        requires = { { "kyazdani42/nvim-web-devicons" } }
    })
    -- fuzzy finder
    use({
        "nvim-telescope/telescope.nvim",
        config = function()
            require("init-telescope")
        end,
    })
    -- media file preview extension for telescope
    use("nvim-telescope/telescope-media-files.nvim")

    -- vim yaml
   use ({
  "cuducos/yaml.nvim",
  ft = {"yaml"}, -- optional
  requires = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim" -- optional
  },
})

    use({
        "akinsho/flutter-tools.nvim",
        config = function()
            require("flutter-tools").setup()
        end,
        requires = 'nvim-lua/plenary.nvim'
    })

    -- vim-cue
    use("jjo/vim-cue")

end)
