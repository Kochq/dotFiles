-- This is your opts table
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fs', builtin.find_files, {})
vim.keymap.set('n', '<leader>gs', builtin.git_files, {})
vim.keymap.set('n', '<leader>bf', builtin.buffers, {})
vim.keymap.set('n', '<leader>ws', builtin.live_grep, {})
vim.keymap.set('n', '<leader>+', builtin.spell_suggest, {})
vim.keymap.set('n', '<leader>}', builtin.colorscheme, {})

vim.keymap.set('n', '<leader>pws', function ()
    local word = vim.fn.expand("<cword>")
    builtin.grep_string({ search = word })
end)
vim.keymap.set('n', '<leader>pWs', function ()
    local word = vim.fn.expand("<cWORD>")
    builtin.grep_string({ search = word })
end)
