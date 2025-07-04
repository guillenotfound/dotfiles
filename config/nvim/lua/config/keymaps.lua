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

-- Update default ones with the ones I'm used to
map("n", "<leader>fw", LazyVim.pick("live_grep"), { desc = "Grep (Root Dir)" })

map({ "n", "v" }, "<leader>fm", function()
  LazyVim.format({ force = true })
end, { desc = "Format" })

-- Keymaps for plugins (LazyVim provides `<leader>gB` for browse and `<leader>gY` for yank)
map("n", "<leader>go", ":GBrowse<CR>", { desc = "Git browse current file in browser" })
map("v", "<leader>go", ":GBrowse!<CR>", { desc = "Git browse current file and selected line in browser" })

-- Remove some keymaps
local nomap = vim.keymap.del
nomap("n", "<leader>cf")

-- Disable terminal commands
nomap("n", "<leader>ft")
nomap("n", "<leader>fT")
nomap("n", "<c-/>")
nomap("t", "<c-/>")
