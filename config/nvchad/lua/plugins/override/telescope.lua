local actions = require "telescope.actions"


return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-frecency.nvim",
  },
  opts = function()
    local conf = require "nvchad.configs.telescope"

    local open_with_trouble = function(...)
      return require("trouble.sources.telescope").open(...)
    end

    conf.defaults.mappings = {
      n = {
        ["q"] = require("telescope.actions").close,
        ["<C-t>"] = open_with_trouble
      },
      i = {
        ["<C-t>"] = open_with_trouble,
        ["<C-Down>"] = actions.cycle_history_next,
        ["<C-Up>"] = actions.cycle_history_prev,
      },
    }

    conf.extensions_list = { "themes", "terms", "fzf", "frecency" }

    conf.extensions = {
      frecency = {
        auto_validate = false,
        db_safe_mode = false,
        ignore_patterns = { "*.git/*", "*/tmp/*", "term://*", "*/node_modules/*", "fugitive://*" },
        show_filter_column = false,
      },
    }

    return conf
  end,
}
