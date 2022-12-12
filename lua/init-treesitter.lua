require("nvim-treesitter.configs").setup({
    compilers = { "gcc", "go", "c", "rust"},
    ensure_installed = {
        "bash",        "javascript",
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
    highlight = { enable = true }
})

vim.o.foldmethod = "expr"
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
