-- https://www.reddit.com/r/neovim/comments/1hhiidm/a_few_nice_fzflua_configurations_now_that_lazyvim/
return {
  "ibhagwan/fzf-lua",
  opts = {
    files = {
      fd_opts = "--color=never --hidden --type f --type l --exclude .git --exclude *.svg --exclude *.png",
    },
    fzf_opts = { ["--cycle"] = true },
    oldfiles = {
      include_current_session = true,
    },
    previewers = {
      builtin = {
        -- Limit size for Treesitter in preview
        syntax_limit_b = 1024 * 100, -- 100KB
      },
    },
  },
}
