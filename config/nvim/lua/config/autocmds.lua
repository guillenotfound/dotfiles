vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = ".env*",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})
