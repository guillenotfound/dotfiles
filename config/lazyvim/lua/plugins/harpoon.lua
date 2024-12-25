return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
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
          ui_width_ratio = 0.40,
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
      "<A-q>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon Go to 1st buffer",
    },
    {
      "<A-w>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon Go to 2st buffer",
    },
    {
      "<A-e>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon Go to 3st buffer",
    },
    {
      "<A-r>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon Go to 4st buffer",
    },
    {
      "<A-t>",
      function()
        require("harpoon"):list():select(5)
      end,
      desc = "Harpoon Go to 5st buffer",
    },
    {
      "<A-y>",
      function()
        require("harpoon"):list():select(6)
      end,
      desc = "Harpoon Go to 6st buffer",
    },
  },
}
