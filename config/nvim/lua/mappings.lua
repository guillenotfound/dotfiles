require "nvchad.mappings"

local map = vim.keymap.set

-- General
map("i", "<C-d>", "<Del>")
map("i", "<esc>", "<Nop>")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "x", '"_x')

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<leader>|", "<C-w>v")
map("n", "<leader>-", "<C-w>s")

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

map("n", "<up>", "")
map("n", "<down>", "")
map("n", "<left>", "")
map("n", "<right>", "")

map("v", ">", ">gv", { desc = "indent" })

map("v", "x", '"_x')

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("v", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m .-2<CR>==")

map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")


--
-- Nvimtree
map("n", "<leader>b", "<cmd> NvimTreeToggle <CR>", { desc = "Toggle nvimtree" })


--
-- Telescope
map("n", "<leader>ff", "<cmd> Telescope frecency workspace=CWD<CR>", { desc = "[F]ind [F]iles" })
map("n", "<leader>fww", function()
  local word = vim.fn.expand "<cword>"
  require("telescope.builtin").grep_string { search = word }
end, { desc = "Grep word under cursor" })
map("n", "<leader>fW", function()
  local word = vim.fn.expand "<cWORD>"
  require("telescope.builtin").grep_string { search = word }
end, { desc = "Grep WORD under cursor" })
-- map("n", "<leader>fo", "<cmd> Telescope oldfiles cwd=CWD<CR>", { desc = "Find oldfiles" })
map("n", "<leader>sd", "<cmd> Telescope diagnostics <CR>", { desc = "[S]earch [D]iagnostics" })
map("n", "<leader>ds", "<cmd> Telescope lsp_document_symbols <CR>", { desc = "[D]ocument [S]ymbols" })


--
-- Disable mappings
local nomap = vim.keymap.del
nomap("n", "<C-n>")
nomap("n", "<C-c>")
nomap("n", "<leader>h")
nomap("n", "<leader>v")
nomap({ "n", "t" }, "<A-v>")
nomap({ "n", "t" }, "<A-h>")
nomap({ "n", "t" }, "<A-i>")
nomap("n", "<tab>")
nomap("n", "<S-tab>")
