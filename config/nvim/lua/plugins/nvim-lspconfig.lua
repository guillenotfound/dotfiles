local use_tsgo = false

local eslint = {
  flags = {
    allow_incremental_sync = false,
    debounce_text_changes = 1000,
    exit_timeout = 1500,
  },
}

local vtsls = {
  settings = {
    typescript = {
      preferences = {
        autoImportFileExcludePatterns = { ".git", "node:test" },
        preferTypeOnlyAutoImports = true,
        includeCompletionsForModuleExports = false,
      },
    },
  },
}

-- https://github.com/LazyVim/LazyVim/discussions/4430
-- https://github.com/schardev/dotfiles/blob/78070f6755aea624eac134b5f3bbd704ed63b5ff/config/nvim/lua/plugins/lsp/servers/tsserver.lua#L16C7-L24C9
-- https://github.com/yioneko/vtsls/issues/167
-- https://github.com/craftzdog/dotfiles-public/blob/0182bb1e6d4babee79a398c119f0dead83f34350/.config/nvim/lua/plugins/lsp.lua#L28
return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    -- Register tsgo as a custom server since it's not in lspconfig by default
    local lspconfig = require("lspconfig")
    local configs = require("lspconfig.configs")

    if not configs.tsgo then
      configs.tsgo = {
        default_config = {
          cmd = { "tsgo", "--lsp", "--stdio" }, -- Update this path!
          filetypes = {
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "javascript",
            "javascriptreact",
            "javascript.jsx",
          },
          root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
          settings = {},
          -- single_file_support = false,
        },
      }
    end

    -- Add tsgo to the servers list
    opts.servers = opts.servers or {}
    opts.servers.tsgo = {
      enabled = use_tsgo,
      mason = false, -- Since tsgo is not available through Mason
      capabilities = {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = false,
          },
        },
      },
    }

    opts.servers.eslint = vim.tbl_deep_extend("force", opts.servers.eslint, eslint)
    opts.servers.vtsls = vim.tbl_deep_extend("force", opts.servers.vtsls, vtsls)

    -- IF `tsgo` is enabled, limit `vtsls` to `vue` only.
    if use_tsgo then
      opts.servers.vtsls.filetypes = { "vue" }
    end

    opts.inlay_hints = { enabled = false }

    return opts
  end,
}
