local nvim_lsp = require("lspconfig")
local util = require("lspconfig/util")

-- set log level
vim.lsp.set_log_level("debug")

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set("n", "<leader>wl", function()
        vim.inspect(vim.lsp.buf.list_workspace_folders())
    end, opts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>so", require("telescope.builtin").lsp_document_symbols, opts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()
nvim_lsp.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    on_init = function(client)
    local path = client.workspace_folders[1].name
    if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using
            -- (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT'
            -- add path for lua language server 

          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
            reset = true
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
              -- "${3rd}/luv/library"
              -- "${3rd}/busted/library",
            }
            -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
            -- library = vim.api.nvim_get_runtime_file("", true)
          },
          telemetry = {
            enable = true
          },
          format = {
            enable = true,
            defaultConfig = {
                indent_style = "tab",
                indent_size = "1",
             },
        },
        }
      })

      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
    return true
  end
})

nvim_lsp.html.setup({
    cmd = { "vscode-html-language-server", "--stdio" },
    filetypes = { "html", "htmldjango" },
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.cssls.setup({
    cmd = { "vscode-css-language-server", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.jsonls.setup({
    cmd = { "vscode-json-language-server", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.gopls.setup ({
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod", "gowork", "gotmpl"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
    on_attach = on_attach,
    capabilities = capabilities,
  })

nvim_lsp.yamlls.setup({
    cmd = { "yaml-language-server", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.bashls.setup({
    cmd = {"bash-language-server", "start"},
    on_attach = on_attach,
    capabilities = capabilities,

})

nvim_lsp.helm_ls.setup({
    cmd = {"helm_ls", "serve"},
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
    ['helm-ls'] = {
        logLevel = "info",
         valuesFiles = {
         mainValuesFile = "values.yaml",
         lintOverlayValuesFile = "values.lint.yaml",
         additionalValuesFilesGlobPattern = "values*.yaml"
    },
        yamlls = {
         enabled = true,
         diagnosticsLimit = 50,
         showDiagnosticsDirectly = false,
         --filetypes_exclude = {"helm"},
         path = "yaml-language-server",
         config = {
          schemas = {
            kubernetes = "templates/**",
          },
          completion = true,
          hover = true,
        -- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
      }
    }
  }
}
})

nvim_lsp.dockerls.setup({
    cmd = {"docker-langserver", "--stdio"},
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.v_analyzer.setup({
    cmd = {"v-analyzer", "--stdio"},
    on_attach = on_attach,
    capabilities = capabilities,
})
