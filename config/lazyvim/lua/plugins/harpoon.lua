return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  keys = {
    {
      "<A-a>",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon File",
    },
    {
      "<A-m>",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list(), {
          title = "Harpoon btw",
          title_pos = "center",
          border = "rounded",
        })
      end,
      desc = "Harpoon Quick Menu",
    },
    {
      "<A-,>",
      function()
        require("harpoon"):list():prev()
      end,
      desc = "Harpoon Go to prev buffer",
    },
    {
      "<A-.>",
      function()
        require("harpoon"):list():next()
      end,
      desc = "Harpoon Go to next buffer",
    },
    {
      "<A-u>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon Go to 1st buffer",
    },
    {
      "<A-i>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon Go to 2st buffer",
    },
    {
      "<A-o>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon Go to 3st buffer",
    },
    {
      "<A-p>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon Go to 4st buffer",
    },
  },
}
