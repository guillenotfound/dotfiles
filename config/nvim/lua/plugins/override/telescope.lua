local actions = require "telescope.actions"

local open_with_trouble = function(...)
  return require("trouble.sources.telescope").open(...)
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-frecency.nvim",
  },
  opts = {
    extensions_list = { "themes", "terms", "fzf", "frecency" },
    extensions = {
      frecency = {
        auto_validate = false,
        db_safe_mode = false,
        ignore_patterns = { "*.git/*", "*/tmp/*", "term://*", "*/node_modules/*", "fugitive://*" },
        show_filter_column = false,
      },
    },
    defaults = {
      mappings = {
        i = {
          ["<C-t>"] = open_with_trouble,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
        },
        n = { ["<C-t>"] = open_with_trouble },
      },
    },
  },
}
