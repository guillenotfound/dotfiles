local M = {}

M.treesitter = {
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "go",
    "groovy",
    "html",
    "javascript",
    "lua",
    "markdown",
    "markdown_inline",
    "regex",
    "tsx",
    -- "typescript",
    "vim",
    "vimdoc",
    "vue",
  },
  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
}

M.mason = {
  ensure_installed = {
    "bash-language-server",
    "css-lsp",
    "docker-compose-language-service",
    "dockerfile-language-server",
    "eslint_d",
    "gopls@v0.11.0",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    "prettierd",
    "stylua",
    "tailwindcss-language-server",
    "vtsls",
    "vue-language-server",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },

  view = {
    side = "right",
    width = 35,
  },
}

M.telescope = {
  extensions_list = { "themes", "terms", "fzf", "frecency" },
  extensions = {
    frecency = {
      auto_validate = false,
      db_safe_mode = false,
      ignore_patterns = { "*.git/*", "*/tmp/*", "term://*", "*/node_modules/*", "fugitive://*" },
      show_filter_column = false,
    },
  },
  -- defaults = {
  --   mappings = {
  --     i = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
  --     n = { ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble },
  --   }
  -- }
}

return M
