return {
  "stevearc/conform.nvim",
  event = "BufWritePre",
  init = function()
    vim.keymap.set("n", "<leader>fm", function()
      require("conform").format { lsp_fallback = true }
    end, { desc = "Format files" })
  end,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },

      css = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },

      html = { { "prettierd", "prettier" } },

      javascript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      vue = { { "prettierd", "prettier" } },

      sh = { "shfmt" },
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
    --[[ formatters = {
      prettier = {
        args = { "--single-quote", "true", "$FILENAME" },
      },
    }, ]]
  },
}
