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
    -- go.nvim
    use({
        "ray-x/go.nvim",
        config = function()
            require("go").setup()
        end,
        })
    use 'ray-x/guihua.lua' -- recommanded if need floating window support
    -- github copilot
    use({
        "github/copilot.vim",
         package_root = os.getenv("HOME") .. '/.config/nvim/pack/github/start/copilot.vim'
            -- install the plugin in specific folder

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

    -- surround support
    use({
        "kylechui/nvim-surround",
        tag = "*",
        config = function()
            require("nvim-surround").setup({})
        end
    })

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
    -- lsp support
    use({
        "neovim/nvim-lspconfig",
        config = function()
            require("init-lspconf")
        end,
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
    -- treesitter config
    use({
        "nvim-treesitter/nvim-treesitter",
        config = function()
            require("init-treesitter")
        end,
    })
    -- better lisp editing
    use("eraserhd/parinfer-rust")
    -- auto pairs
    use("windwp/nvim-autopairs")
    -- auto tags
    use("windwp/nvim-ts-autotag")
    -- rainbow
    use("p00f/nvim-ts-rainbow")
    -- comment
    use({
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup({
                hook = function()
                    require("ts_context_commentstring.internal").update_commentstring()
                end,
            })
        end,
        requires = { { "JoosepAlviste/nvim-ts-context-commentstring" } }
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
    use("stephpy/vim-yaml")

    use({
        "akinsho/flutter-tools.nvim",
        config = function()
            require("flutter-tools").setup()
        end,
        requires = 'nvim-lua/plenary.nvim'
    })

end)
