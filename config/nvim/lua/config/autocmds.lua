-- Disable diagnostics for `.env` files
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = ".env*",
  callback = function()
    vim.diagnostic.enable(false)
  end,
})

-- Prevent `helm_ls` to change cwd.
vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost" }, {
  pattern = { ".helm", "Chart.yaml", "values.yaml" },
  callback = function()
    local root = require("lazyvim.util").root.get()
    if root and vim.fn.getcwd() ~= root then
      vim.cmd("cd " .. root)
    end
  end,
})
