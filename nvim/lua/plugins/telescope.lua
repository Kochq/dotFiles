return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown {
                        -- even more opts
                    }
                }
            }
        })

        require("telescope").load_extension("ui-select")


        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>fs', builtin.find_files, {})
        vim.keymap.set('n', '<leader>gs', builtin.git_files, {})
        vim.keymap.set('n', '<leader>bf', builtin.buffers, {})
        vim.keymap.set('n', '<leader>ws', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>+', builtin.spell_suggest, {})
        vim.keymap.set('n', '<leader>}', builtin.colorscheme, {})

        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
    end
}
