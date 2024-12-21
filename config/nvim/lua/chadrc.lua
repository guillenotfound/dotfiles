-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua
---@type ChadrcConfig
local M = {}

M.ui = {
  telescope = { style = "bordered" },

  tabufline = {
    enabled = false,
    order = { "buffers", "tabs" },
  },
}

M.base46 = {
  transparency = true,
  theme = "onedark",
  lsp_semantic_tokens = false,

  hl_override = {
    Comment = { italic = true },
    NvimTreeRootFolder = { link = "TelescopeBorder" },
  },

  hl_add = {
    NvimTreeOpenedFolderName = { fg = "green", bold = true },
  },

  integrations = {
    "lsp",
    "todo",
    "mason",
    "notify",
    "nvimtree",
    "statusline",
    "trouble",
  },
}

return M
