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

    {
      "shumphrey/fugitive-gitlab.vim",
      enabled = function()
        if os.getenv("GITLAB_SSH") then
          return true
        else
          return false
        end
      end,
      config = function()
        vim.g.fugitive_gitlab_domains = { [os.getenv("GITLAB_SSH")] = os.getenv("GITLAB_PORTAL") }
        vim.g.gitlab_api_keys = { [os.getenv("GITLAB_PORTAL")] = os.getenv("GITLAB_PAT") }
      end,
    },
  },
}
