return {
  "saghen/blink.cmp",
  enabled = function()
    return not vim.tbl_contains({ "lua", "markdown" }, vim.bo.filetype)
      and vim.bo.buftype ~= "prompt"
      and vim.b.completion ~= false
  end,
  opts = {
    sources = {
      -- Disable some sources in comments and strings.
      default = function()
        local sources = { "lsp", "buffer" }
        local ok, node = pcall(vim.treesitter.get_node)

        if ok and node then
          if not vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
            table.insert(sources, "path")
          end
          if node:type() ~= "string" then
            table.insert(sources, "snippets")
          end
        end

        return sources
      end,
      providers = {
        snippets = {
          min_keyword_length = 4, -- don't show when triggered manually, useful for JSON keys
          score_offset = -10,
        },
        buffer = {
          max_items = 4,
          min_keyword_length = 4,
          score_offset = -3,
        },
      },
    },
    -- signature = { enabled = true },
  },
}
