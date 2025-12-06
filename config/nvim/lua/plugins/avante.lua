return {
  "yetone/avante.nvim",
  enabled = false,
  build = "make BUILD_FROM_SOURCE=true",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    input = {
      provider = "snacks",
    },
    -- https://github.com/yetone/avante.nvim/wiki/Custom-providers
    provider = "zllama",
    providers = {
      ["zllama"] = {
        __inherited_from = "openai",
        api_key_name = "ZGAP_API_KEY",
        endpoint = os.getenv("ZGAP_ENDPOINT"),
        model = "claude-4-sonnet",
        prompt = "You are an expert software developer. You give helpful and concise responses.",
        timeout = 30000,
        extra_request_body = {
          temperature = 0,
          max_tokens = 4096,
        },
      },
    },
    selector = {
      provider = "fzf_lua",
    },
    web_search_engine = {
      provider = "tavily",
      proxy = nil,
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "folke/snacks.nvim",
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
