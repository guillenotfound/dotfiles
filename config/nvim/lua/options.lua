require "nvchad.options"

local o = vim.o
o.relativenumber = true
o.number = true

o.swapfile = false
o.termguicolors = true
o.autoindent = true

o.scrolloff = 8

-- Enabled code folding
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevelstart = 99
