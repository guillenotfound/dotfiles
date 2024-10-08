return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = "VeryLazy",
  config = function()
    dofile(vim.g.base46_cache .. "todo")
    require("todo-comments").setup {
      highlight = { multiline = true },
    }
  end,
  -- stylua: ignore
  keys = {
    { "]t",         function() require("todo-comments").jump_next() end,              desc = "Todo Next Comment" },
    { "[t",         function() require("todo-comments").jump_prev() end,              desc = "Todo Previous Comment" },
    { "<leader>xt", "<cmd>Trouble todo toggle<cr>",                                   desc = "Trouble Todo" },
    { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Trouble Todo/Fix/Fixme" },
    { "<leader>st", "<cmd>TodoTelescope<cr>",                                         desc = "Todo" },
    { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",                 desc = "Todo Telescope" },
  },
}
