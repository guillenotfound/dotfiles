return {
  "tpope/vim-fugitive",
  event = "VeryLazy",
  dependencies = {
    "tpope/vim-rhubarb",
    {
      "tommcdo/vim-fubitive",
      config = function()
        vim.g.fubitive_domain_pattern = os.getenv("BITBUCKET_ENDPOINT")
      end,
    },
  },
}
