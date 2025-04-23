return {
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "night" },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        position = "right",
      },
    },
  },

  -- https://github.com/LazyVim/LazyVim/discussions/4430
  -- https://github.com/schardev/dotfiles/blob/78070f6755aea624eac134b5f3bbd704ed63b5ff/config/nvim/lua/plugins/lsp/servers/tsserver.lua#L16C7-L24C9
  -- https://github.com/yioneko/vtsls/issues/167
  -- https://github.com/craftzdog/dotfiles-public/blob/0182bb1e6d4babee79a398c119f0dead83f34350/.config/nvim/lua/plugins/lsp.lua#L28
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        -- https://www.reddit.com/r/neovim/comments/1hpyul2/ts_development_in_neovim_again/
        -- https://github.com/d7omdev/nvim/blob/b038a73e0bb2ebe879b4ef7868c11394ec10d053/lua/plugins/lspconfig.lua#L111C3-L111C115
        -- https://www.reddit.com/r/neovim/comments/1guifug/lsp_extreme_lag/
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

  {
    "echasnovski/mini.pairs",
    opts = {
      modes = { insert = true, command = false, terminal = false },
    },
  },

  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
    end,
  },

  {
    "saghen/blink.cmp",
    enabled = function()
      return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    opts = {
      sources = {
        -- Disable some sources in comments and strings.
        default = function()
          local sources = { "lsp", "buffer" }
          local ok, node = pcall(vim.treesitter.get_node)

          if ok and node then
            if not vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
              table.insert(sources, "path")
            end
            if node:type() ~= "string" then
              table.insert(sources, "snippets")
            end
          end

          return sources
        end,
        providers = {
          snippets = {
            min_keyword_length = 4, -- don't show when triggered manually, useful for JSON keys
            score_offset = -10,
          },
          buffer = {
            max_items = 4,
            min_keyword_length = 4,
            score_offset = -3,
          },
        },
      },
      -- signature = { enabled = true },
    },
  },

  -- https://www.reddit.com/r/neovim/comments/1hhiidm/a_few_nice_fzflua_configurations_now_that_lazyvim/
  {
    "ibhagwan/fzf-lua",
    opts = {
      fzf_opts = { ["--cycle"] = true },
      oldfiles = {
        include_current_session = true,
      },
      previewers = {
        builtin = {
          -- Limit size for Treesitter in preview
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
    },
  },

  {
    "folke/flash.nvim",
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
      { "ss", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      {
        "sindrets/diffview.nvim",
        config = true,
      },
    },
    opts = {
      preview_config = {
        border = "rounded",
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
}
