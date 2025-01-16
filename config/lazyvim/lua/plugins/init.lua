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
      -- preferences = {
      --   -- Include the `type` keyword in auto-imports whenever possible.
      --   -- Requires using TypeScript 5.3+ in the workspace.
      --   preferTypeOnlyAutoImports = true,
      -- },
      servers = {
        vtsls = {
          root_dir = function()
            local lazyvimRoot = require("lazyvim.util.root")
            return lazyvimRoot.git()
          end,
          settings = {
            typescript = {
              preferences = {
                preferTypeOnlyAutoImports = true,
                autoImportFileExcludePatterns = {
                  "node:test",
                },
              },
              tsserver = {
                maxTsServerMemory = 8192,
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
    version = "v0.*",
    enabled = function()
      return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
        and vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
    end,
    opts = {
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          snippets = {
            min_keyword_length = 3, -- don't show when triggered manually, useful for JSON keys
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
