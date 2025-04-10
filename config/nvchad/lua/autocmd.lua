-- Inspired by: https://github.com/mgastonportillo/nvchad-config/blob/main/utils/autocmd.lua

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
autocmd('TextYankPost', {
  desc = "Highlight on yank",
  callback = function()
    vim.highlight.on_yank()
  end,
  group = augroup('YankHighlight', { clear = true }),
  pattern = '*',
})

autocmd("BufEnter", {
  desc = "Prevent auto comment new line",
  command = [[set formatoptions-=cro]],
})

-- prevent comment from being inserted when entering new line in existing comment
autocmd("BufEnter", {
  callback = function()
    -- allow <CR> to continue block comments only
    -- https://stackoverflow.com/questions/10726373/auto-comment-new-line-in-vim-only-for-block-comments
    vim.opt.comments:remove "://"
    vim.opt.comments:remove ":--"
    vim.opt.comments:remove ":#"
    vim.opt.comments:remove ":%"
  end,
})

autocmd("VimResized", {
  desc = "Auto resize panes when resizing nvim window",
  pattern = "*",
  command = "tabdo wincmd =",
})

autocmd("FileType", {
  desc = "Close NvimTree before quit nvim",
  pattern = { "NvimTree" },
  callback = function(args)
    autocmd("VimLeavePre", {
      callback = function()
        vim.api.nvim_buf_delete(args.buf, { force = true })
        return true
      end,
    })
  end,
})

autocmd("BufWritePre", {
  desc = "Remove all trailing whitespace on save",
  command = [[:%s/\s\+$//e]],
  group = augroup("TrimWhiteSpaceGrp", { clear = true }),
})

-- Windows to close with "q"
autocmd("FileType", {
  pattern = {
    "help",
    "startuptime",
    "qf",
    "lspinfo",
    "man",
    "checkhealth",
    "tsplayground",
    "HIERARCHY-TREE-GO",
    "dap-float",
    "spectre_panel",
    "null-ls-info",
    "empty",
    "neotest-output",
    "neotest-summary",
    "neotest-output-panel",
  },
  command = [[
            nnoremap <buffer><silent> q :close<CR>
            set nobuflisted
        ]],
})

autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Set groovy filetype for Jenkinsfile",
  pattern = { "Jenkinsfile" },
  command = "set filetype=groovy",
  group = augroup("ft", { clear = true })
})

autocmd({ "BufRead", "BufNewFile" }, {
  desc = "Set filetype for Docker Compose",
  pattern = { "docker-compose.yaml", "docker-compose*.yaml" },
  command = "set filetype=yaml.docker-compose",
  group = augroup("ft", { clear = true })
})

