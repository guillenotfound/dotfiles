return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },

      bash = { "shfmt" },
      sh = { "shfmt" },
      zsh = { "shfmt" },

      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },

      html = { "prettierd", "prettier", stop_after_first = true },

      javascript = { "oxfmt", "prettier", stop_after_first = true },
      javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
      typescript = { "oxfmt", "prettier", stop_after_first = true },
      typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
      vue = { "oxfmt", "prettier", stop_after_first = true },

      json = { "jq" }
    },
  },
}
