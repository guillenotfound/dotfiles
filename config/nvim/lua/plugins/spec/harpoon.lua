return {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require "harpoon"
    local map = vim.keymap.set

    harpoon:setup()

    -- stylua: ignore
    map("n", "<leader>a", function() harpoon:list():append() end)
    -- stylua: ignore
    map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    -- stylua: ignore
    -- map("n", "<C-h>", function() harpoon:list():select(1) end)
    -- stylua: ignore
    -- map("n", "<C-t>", function() harpoon:list():select(2) end)
    -- stylua: ignore
    -- map("n", "<C-n>", function() harpoon:list():select(3) end)
    -- stylua: ignore
    -- map("n", "<C-s>", function() harpoon:list():select(4) end)
  end,
}
