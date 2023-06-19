require("nvim-treesitter.configs").setup({
    compilers = { "gcc", "go", "c", "rust"},
    ensure_installed = {
        "javascript",
        "bash",
        "json",
        "json5",
        "jsonc",
        "lua",
        "python",
        "dart",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "scss",
        "graphql",
        "toml",
        "regex",
    },

    auto_install = true,
    -- auto tag with nvim-ts-autotag
    highlight = { enable = true },
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
    -- autopairs with nvim-ts-autotag
    autopairs = { enable = true },
    autotag = { enable = true },
    rainbow = { enable = true },
    textobjects = {
        select = {
            enable = true,
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
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

})


vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
