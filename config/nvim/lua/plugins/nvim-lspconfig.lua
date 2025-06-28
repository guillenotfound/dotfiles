-- https://github.com/LazyVim/LazyVim/discussions/4430
-- https://github.com/schardev/dotfiles/blob/78070f6755aea624eac134b5f3bbd704ed63b5ff/config/nvim/lua/plugins/lsp/servers/tsserver.lua#L16C7-L24C9
-- https://github.com/yioneko/vtsls/issues/167
-- https://github.com/craftzdog/dotfiles-public/blob/0182bb1e6d4babee79a398c119f0dead83f34350/.config/nvim/lua/plugins/lsp.lua#L28
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        -- https://github.com/d7omdev/nvim/blob/b038a73e0bb2ebe879b4ef7868c11394ec10d053/lua/plugins/lspconfig.lua#L111C3-L111C115
        -- https://www.reddit.com/r/neovim/comments/1guifug/lsp_extreme_lag/
        -- https://www.reddit.com/r/neovim/comments/1hpyul2/ts_development_in_neovim_again/
        eslint = {
          flags = {
            allow_incremental_sync = false,
            debounce_text_changes = 1000,
            exit_timeout = 1500,
          },
        },
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                autoImportFileExcludePatterns = { ".git", "node:test" },
                preferTypeOnlyAutoImports = true,
                includeCompletionsForModuleExports = false,
              },
            },
          },
        },
      },
    },
  },
}
