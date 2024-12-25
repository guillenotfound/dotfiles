local discipline = require("guille.discipline")
discipline.cowboy()

local map = vim.keymap.set

-- General
map("i", "<C-d>", "<Del>")
-- <C-w> deleted words backwards while in insert mode

-- Move multiline with centered position
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Seach with centered position
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- map(
--   "n",
--   "<leader>s",
--   [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
--   { desc = "Search & replace word under cursor" }
-- )

map("n", "<leader>fz", "<cmd>FzfLua grep_curbuf<cr>", { desc = "Buffer" })
map("n", "<leader>fw", LazyVim.pick("live_grep"), { desc = "Grep (Root Dir)" })
-- TODO: Add noice warning that instruct the new keymap

-- map("n", "<leader>gw", function()
--   local word = vim.fn.expand("<cword>")
--   require("telescope.builtin").grep_string({ search = word })
-- end, { desc = "Telescope [g]rep [w]ord under cursor" })
-- map("n", "<leader>gW", function()
--   local word = vim.fn.expand("<cWORD>")
--   require("telescope.builtin").grep_string({ search = word })
-- end, { desc = "Telescope [g]rep [W]ORD under cursor" })

-- Update default ones with the ones I'm used to
map({ "n", "v" }, "<leader>fm", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

local nomap = vim.keymap.del
nomap("n", "<leader>cf")

-- Disable terminal commands
nomap("n", "<leader>ft")
nomap("n", "<leader>fT")
nomap("n", "<c-/>")
nomap("t", "<c-/>")
