vim.g.mapleader = " "
vim.g.relevarDir = "/home/koch/Workspace/Relevar/app"

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

-- Dont know
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace word
vim.keymap.set("n", "<leader>c", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Set executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Lluvia
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

-- Run current file
local fileExt = vim.fn.expand("%:e")
if fileExt == "php" then
  vim.keymap.set("n", "<leader>r", ":ter php %<CR>")
elseif fileExt == "cpp" then
  vim.keymap.set("n", "<leader>r", ":ter g++ %<CR>:ter ./a.out<CR>")
elseif fileExt == "py" then
  vim.keymap.set("n", "<leader>r", ":ter python3 %<CR>")
elseif fileExt == "js" then
  vim.keymap.set("n", "<leader>r", ":ter node %<CR>")
end

-- so
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Define a Lua function for key bindings
function SetKeyBindings()
    local current_file = vim.fn.expand('%:t')
    local current_path = vim.fn.expand('%:p:h')

    if string.find(current_path, vim.g.relevarDir .. '/', 1, true) then
        local relative_path = string.gsub(current_path, vim.g.relevarDir .. '/', '')
        vim.api.nvim_set_keymap('n', '<leader>s', [[:w<CR>:execute "Nwrite ftp://relevar@201.234.19.19/]] .. vim.fn.fnameescape(relative_path) .. '/' .. vim.fn.fnameescape(current_file) .. [[\n"<CR>]], { noremap = true, silent = true })
    elseif string.find(current_path, vim.g.relevarDir) then
        vim.api.nvim_set_keymap('n', '<leader>s', [[:w<CR>:execute "Nwrite ftp://relevar@201.234.19.19/]] .. vim.fn.fnameescape(current_file) .. [[\n"<CR>]], { noremap = true, silent = true })
    else
        vim.api.nvim_set_keymap('n', '<leader>s', [[:w<CR>]], { noremap = true, silent = true })
    end
end

-- Set up an autocmd in Lua
vim.api.nvim_exec([[
augroup DirectoryKeyBindings
    autocmd!
    autocmd BufEnter * lua SetKeyBindings()
augroup END
]], false)

