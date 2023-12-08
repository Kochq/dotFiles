require("kochq.bigKeymaps")

vim.g.mapleader = " "

-- Quit
vim.keymap.set("n", "<leader>q", ":q<CR>")

-- Files
vim.keymap.set("n", "<leader>n", ":Ex<CR>")

-- Move lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Previous buffer, i cannot do C-^
vim.keymap.set("n", "<C-p>", "<C-^>")

-- Center things
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without overwriting clipboard
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Q
vim.keymap.set("n", "Q", "<nop>")

-- Format
vim.keymap.set("n", "<leader>fo", vim.lsp.buf.format)

-- semi colon
vim.keymap.set("n", "<leader>;", "A;<Esc>")

-- Replace word
vim.keymap.set("n", "<leader>c", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Set executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Lluvia
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- Copilot remap
vim.keymap.set('i', '<C-e>', 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })

