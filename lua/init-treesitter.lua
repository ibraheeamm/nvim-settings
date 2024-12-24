

-- create array of treesitter parsers to install
local parsers = { "lua", "python", "javascript", "typescript", "go", "jsonc", "yaml", "dockerfile", "helm", "jsonc","jq", "json", "json5", "markdown" }

require("nvim-treesitter.configs").setup({
    ensure_installed = parsers,
    sync_install = false,
    auto_install = true,
    ignore_install = {},
    highlight = {
        enable = true,
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
            local disabled_langs = { "json", "markdown" }
            return vim.tbl_contains(disabled_langs, lang)
        end,
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = { enable = true },
    modules = {
        textobjects = {
                select = {
                    enable = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
            },
    },
    parser_install_dir = nil,
})

-- Folding optimization
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local max_filesize = 100 * 1024 -- 100 KB
        local stats = vim.loop.fs_stat(vim.api.nvim_buf_get_name(0))
        if stats and stats.size > max_filesize then
            vim.wo.foldmethod = "manual"
        else
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end
    end,
})
-- require("nvim-treesitter.configs").setup({
--
--     ensure_installed = {
--         "javascript",
--         "bash",
--         "json",
--         "json5",
--         "jsonc",
--         "lua",
--         "python",
--         "typescript",
--         "tsx",
--         "yaml",
--         "toml",
--         "regex",
--         "dockerfile",
--         "go",
--         "markdown",
--     },
--     sync_install = false,
--     ignore_install = {},
--
--     auto_install = true,
--     highlight = { 
--         enable = true,
--         disable = function(_, buf)
--             local max_filesize = 1000 * 1024 -- 1 MB
--             local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
--             if ok and stats and stats.size > max_filesize then
--                 return true
--             end
--         end,
--     },
--     incremental_selection = {
--         enable = true,
--         keymaps = {
--             init_selection = "gnn",
--             node_incremental = "grn",
--             scope_incremental = "grc",
--             node_decremental = "grm",
--         },
--     },
--     indent = { enable = true },
--     -- autopairs with nvim-ts-autotag
--     autopairs = { enable = true },
--     --autotag = { enable = false },
--     rainbow = { enable = false },
--     textobjects = {
--         select = {
--             enable = true,
--             keymaps = {
--                 -- You can use the capture groups defined in textobjects.scm
--                 ["af"] = "@function.outer",
--                 ["if"] = "@function.inner",
--                 ["ac"] = "@class.outer",
--                 ["ic"] = "@class.inner",
--             },
--         },
--         move = {
--             enable = true,
--             set_jumps = true, -- whether to set jumps in the jumplist
--             goto_next_start = {
--                 ["]m"] = "@function.outer",
--                 ["]]"] = "@class.outer",
--             },
--             goto_next_end = {
--                 ["]M"] = "@function.outer",
--                 ["]["] = "@class.outer",
--             },
--             goto_previous_start = {
--                 ["[m"] = "@function.outer",
--                 ["[["] = "@class.outer",
--             },
--             goto_previous_end = {
--                 ["[M"] = "@function.outer",
--                 ["[]"] = "@class.outer",
--             },
--         },
--     },
-- })
--
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
