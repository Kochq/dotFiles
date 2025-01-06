vim.g.mapleader = " "

-- Quit
vim.keymap.set("n", "<leader>q", ":q<CR>")
-- Quit without saving
vim.keymap.set("n", "<leader>Q", ":q!<CR>")

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

-- Set column to 80
vim.keymap.set('n', "<leader>o", ':lua vim.opt.colorcolumn = "80"<CR>');

-- Set column to 80
vim.keymap.set('n', "<leader>O", ':lua vim.opt.colorcolumn = "0"<CR>');

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

-- Resize windows
vim.keymap.set("n", "<leader><s-l>", "<cmd>vertical resize +5<CR>");
vim.keymap.set("n", "<leader><s-h>", "<cmd>vertical resize -5<CR>");

-- Lazy git
vim.keymap.set("n", "<leader>gS", "<cmd>LazyGit<CR>");

-- Quickfix
vim.keymap.set("n", "<C-S-j>", "<cmd>cnext<CR>");
vim.keymap.set("n", "<C-S-k>", "<cmd>cprev<CR>");

-- TSContext
vim.keymap.set("n", "<leader>tsc", "<cmd>TSContextToggle<CR>")

-- Navigate to keymap file
vim.keymap.set("n", "<leader>km", "<cmd>e /home/koch/dotFiles/nvim/lua/kochq/keymaps.lua<CR>")

-- Undotree
vim.keymap.set("n", "<F5>", vim.cmd.UndotreeToggle)

-- Copilot remap
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.keymap.set('i', '<C-e>', 'copilot#Accept("<CR>")', {
  expr = true,
  replace_keycodes = false
})

require("kochq.bigKeymaps")
