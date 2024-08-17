return {
  "lewis6991/gitsigns.nvim",
  dependencies = {
    {
      "sindrets/diffview.nvim",
      config = true,
    },
  },
  init = function()
    local gitsigns = require('gitsigns')
    local map = vim.keymap.set
    map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Gitsigns stage hunk' })
    map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { desc = 'Gitsigns reset hunk' })
    map('n', '<leader>bl', function() gitsigns.blame_line{full=true} end, { desc = 'Gitsigns blame line' })
    map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>', { desc = 'Gitsigns toggle deleted' })
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal({']c', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end)

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal({'[c', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end)
  end,
  opts = {
    preview_config = {
      border = "rounded",
    },
  },
}
