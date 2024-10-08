return {
  "nvim-tree/nvim-tree.lua",
  opts = {
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
  },
}
