return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  opts = {
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
      "typescript",
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
    highlight = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>is",
        node_incremental = "<Tab>",
        scope_incremental = "<S-s>",
        node_decremental = "<S-Tab>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = { query = "@function.outer", desc = "Select around function" },
          ["if"] = { query = "@function.inner", desc = "Select inner part of function" },
          ["ac"] = { query = "@class.outer", desc = "Select around class" },
          ["ic"] = { query = "@class.inner", desc = "Select inner part of class" },
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
        selection_modes = {
          ["@parameter.outer"] = "v",
          ["@function.outer"] = "V",
          ["@class.outer"] = "<c-v>",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>wn"] = "@parameter.inner",
        },
        swap_previous = {
          ["<leader>wp"] = "@parameter.inner",
        },
      },
    },
  },
}
