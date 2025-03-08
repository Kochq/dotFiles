return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    vim.keymap.set('n', '<leader>#', '<cmd>ColorizerToggle<cr>')
  end,
}
