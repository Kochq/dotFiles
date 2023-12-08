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
else
  vim.keymap.set("n", "<leader>r", function()
    print('No runner for this file')
  end)
end


-- Define a Lua function for key bindings
vim.g.relevarDir = "/home/koch/Workspace/Relevar/app"
function SetKeyBindings()
  local current_file = vim.fn.expand('%:t')
  local current_path = vim.fn.expand('%:p:h')

  if string.find(current_path, vim.g.relevarDir .. '/', 1, true) then
    local relative_path = string.gsub(current_path, vim.g.relevarDir .. '/', '')
    vim.api.nvim_set_keymap('n', '<leader>s',
    [[:w<CR>:execute "Nwrite ftp://relevar@201.234.19.19/]] ..
    vim.fn.fnameescape(relative_path) .. '/' .. vim.fn.fnameescape(current_file) .. [[\n"<CR>]],
    { noremap = true, silent = true })
  elseif string.find(current_path, vim.g.relevarDir) then
    vim.api.nvim_set_keymap('n', '<leader>s',
    [[:w<CR>:execute "Nwrite ftp://relevar@201.234.19.19/]] .. vim.fn.fnameescape(current_file) .. [[\n"<CR>]],
    { noremap = true, silent = true })
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
