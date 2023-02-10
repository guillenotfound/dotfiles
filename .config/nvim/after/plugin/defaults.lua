local opt = vim.opt

-- line numbers
opt.relativenumber = true
opt.number = true

-- indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- clipboard
opt.clipboard = 'unnamedplus'

vim.keymap.set('i', '<C-d>', '<Del>')

local au_ft = vim.api.nvim_create_augroup("ft", { clear = true })
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"}, {
	pattern = {"Jenkinsfile"},
	command = 'set filetype=groovy',
	group = au_ft
})
