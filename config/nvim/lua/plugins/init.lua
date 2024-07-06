return {
  { import = "plugins.spec.mason" },
  { import = "plugins.override.treesitter" },
  { import = "plugins.override.nvimtree" },
  { import = "plugins.override.conform" },
  { import = "plugins.override.nvim-lint" },
  { import = "plugins.override.telescope" },

  -- { import = "plugins.spec.dressing" },
  { import = "plugins.spec.better-scape" },
  { import = "plugins.spec.fugitive" },
  { import = "plugins.spec.gitsigns" },
  { import = "plugins.spec.harpoon" },
  { import = "plugins.spec.mason-extras" },
  { import = "plugins.spec.noice" },
  { import = "plugins.spec.todo-comments" },
  { import = "plugins.spec.trouble" },
  { import = "plugins.spec.vim-sleuth" },
  { import = "plugins.spec.vim-surround" },

  -- disabled plugins

  {
    "NvChad/nvterm",
    enabled = false,
  },
}
