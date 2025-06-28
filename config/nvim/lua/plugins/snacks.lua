return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      hidden = true,
      sources = {
        explorer = {
          layout = {
            layout = {
              position = "right",
            },
          },
        },
        files = {
          hidden = true,
        },
      },
    },
  },
}
