-- Disabling the whole plugin for now.
--
-- Disable [c and ]c since they conflict with fugitive jump to next confict.
-- https://github.com/LazyVim/LazyVim/blob/a507822c0f67df661d1411f9274a65ca9cc832f5/lua/lazyvim/plugins/treesitter.lua#L149-L152
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  enabled = false,
  opts = function(_, opts)
    opts.move = opts.move or {}
    opts.move.keys = {
      goto_next_start = { ["]f"] = "@function.outer", ["]a"] = "@parameter.inner" },
      goto_next_end = { ["]F"] = "@function.outer", ["]A"] = "@parameter.inner" },
      goto_previous_start = { ["[f"] = "@function.outer", ["[a"] = "@parameter.inner" },
      goto_previous_end = { ["[F"] = "@function.outer", ["[A"] = "@parameter.inner" },
    }
    return opts
  end,
}
