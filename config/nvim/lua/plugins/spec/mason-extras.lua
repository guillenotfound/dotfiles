local setup = function(_, opts)
  local capabilities = require("nvchad.configs.lspconfig").capabilities
  local on_attach = require("nvchad.configs.lspconfig").on_attach
  local on_init = require("nvchad.configs.lspconfig").on_init

  local lspconfig = require "lspconfig"
  local util = require "lspconfig/util"

  -- List of servers to install
  local servers = {
    "bashls",
    "cssls",
    "docker_compose_language_service",
    "dockerls",
    "helm_ls",
    -- "eslint",
    "gopls",
    "html",
    "jsonls",
    -- "lua_ls",
    "tailwindcss",
    "volar",
    "vtsls",
  }

  -- Borrowed from: https://github.com/mgastonportillo/nvchad-config/blob/e1fead31ad460391f8d251fcda71580f293b8dbd/lua/gale/custom.lua#L4
  local custom_on_attach = function(client, bufnr)
    on_attach(client, bufnr)

    local border = "rounded"
    -- vim.lsp.buf.hover()
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
    -- vim.lsp.buf.signature_help()
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

    local map = vim.keymap.set
    map("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "LSP Go to type definition" })
  end

  require("mason").setup(opts)

  require("mason-lspconfig").setup {
    ensure_installed = servers,
  }

  -- This will setup lsp for servers you listed above
  -- And servers you install through mason UI
  -- So defining servers in the list above is optional
  require("mason-lspconfig").setup_handlers {
    -- Default setup for all servers, unless a custom one is defined below
    function(server_name)
      lspconfig[server_name].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
      }
    end,
    -- custom setup for a server goes after the function above
    -- Example, override rust_analyzer
    -- ["rust_analyzer"] = function ()
    --   require("rust-tools").setup {}
    -- end,

    -- Example: disable auto configuring an LSP
    -- Here, we disable lua_ls so we can use NvChad's default config
    ["lua_ls"] = function()
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        on_init = on_init,

        settings = {
          Lua = {
            diagnostics = {
              globals = { "hs", "vim" },
            },
            workspace = {
              library = {
                vim.fn.expand "$VIMRUNTIME/lua",
                vim.fn.expand "$VIMRUNTIME/lua/vim/lsp",
                ['/Applications/Hammerspoon.app/Contents/Resources/extensions/hs/'] = true,
                vim.fn.stdpath "data" .. "/lazy/ui/nvchad_types",
                vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
              },
              maxPreload = 100000,
              preloadFileSize = 10000,
            },
          },
        },
      }
    end,

    -- ["eslint"] = function()
    --   lspconfig.eslint.setup {
    --     on_attach = function(client, bufnr)
    --       vim.api.nvim_create_autocmd("BufWritePre", {
    --         buffer = bufnr,
    --         command = "EslintFixAll",
    --       })
    --     end,
    --     capabilities = capabilities,
    --   }
    -- end,

    ["gopls"] = function()
      lspconfig.gopls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        on_init = on_init,

        cmd = { "gopls" },
        cmd_env = {
          GOFLAGS = "-tags=test,e2e_test,integration_test,acceptance_test",
        },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      }
    end,

    ["jsonls"] = function()
      lspconfig.jsonls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        on_init = on_init,

        settings = {
          json = {
            validate = { enable = true },
            schemas = {
              {
                fileMatch = { "package.json" },
                url = "https://json.schemastore.org/package.json",
              },
              {
                description = "TypeScript compiler configuration file",
                fileMatch = { "tsconfig.json", "tsconfig.*.json" },
                url = "http://json.schemastore.org/tsconfig",
              },
              {
                description = "Lerna config",
                fileMatch = { "lerna.json" },
                url = "http://json.schemastore.org/lerna",
              },
              {
                description = "Babel configuration",
                fileMatch = { ".babelrc.json", ".babelrc", "babel.config.json" },
                url = "http://json.schemastore.org/lerna",
              },
              {
                description = "ESLint config",
                fileMatch = { ".eslintrc.json", ".eslintrc" },
                url = "http://json.schemastore.org/eslintrc",
              },
              {
                description = "Prettier config",
                fileMatch = { ".prettierrc", ".prettierrc.json", "prettier.config.json" },
                url = "http://json.schemastore.org/prettierrc",
              },
              {
                description = "Stylelint config",
                fileMatch = { ".stylelintrc", ".stylelintrc.json", "stylelint.config.json" },
                url = "http://json.schemastore.org/stylelintrc",
              },
            },
          },
        },
      }
    end,

    ["tailwindcss"] = function()
      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        on_init = on_init,

        filetypes = { "vue" },
      }
    end,

    ["vtsls"] = function()
      lspconfig.vtsls.setup {
        on_attach = custom_on_attach,
        capabilities = capabilities,
        on_init = on_init,

        -- explicitly add default filetypes, so that we can extend
        -- them in related extras
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = {
          complete_function_calls = true,
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = "always" },
            suggest = {
              completeFunctionCalls = true,
            },
            inlayHints = {
              enumMemberValues = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              parameterNames = { enabled = "literals" },
              parameterTypes = { enabled = true },
              propertyDeclarationTypes = { enabled = true },
              variableTypes = { enabled = false },
            },
          },
        },
      }
    end,
  }
end

local spec = {
  "neovim/nvim-lspconfig",
  -- BufRead is to make sure if you do nvim some_file then this is still going to be loaded
  event = { "VeryLazy", "BufRead" },
  config = function() end, -- Override to make sure load order is correct
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = {
        ensure_installed = {
          "bash-language-server",
          "css-lsp",
          "docker-compose-language-service",
          "dockerfile-language-server",
          -- "eslint_d",
          "gopls@v0.11.0",
          "html-lsp",
          "json-lsp",
          "lua-language-server",
          "prettierd",
          "prettier",
          "stylua",
          "tailwindcss-language-server",
          "vtsls",
          "vue-language-server",
        },
      },
      config = function(plugin, opts)
        require("nvchad.configs.lspconfig").defaults()

        setup(plugin, opts)
      end,
    },
    "williamboman/mason-lspconfig",
    {
      "folke/neodev.nvim",
      config = true,
    },
  },
}

return spec
