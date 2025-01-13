return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
        require("refactoring").setup({
            prompt_func_return_type = {
                go = true,
                java = true,

                cpp = true,
                c = true,
                h = true,
                hpp = true,
                cxx = true,
            },
            prompt_func_param_type = {
                go = true,
                java = true,

                cpp = true,
                c = true,
                h = true,
                hpp = true,
                cxx = true,
            },
            printf_statements = {},
            print_var_statements = {},
            show_success_message = true, -- shows a message with information about the refactor on success
            -- i.e. [Refactor] Inlined 3 variable occurrences

        })

        -- load refactoring Telescope extension
        require("telescope").load_extension("refactoring")

        vim.keymap.set(
            { "n", "x" },
            "<leader>rfr",
            function() require('telescope').extensions.refactoring.refactors() end
        )

        vim.keymap.set("x", "<leader>rff", ":Refactor extract ")
        vim.keymap.set("x", "<leader>rfe", ":Refactor extract_to_file ")

        vim.keymap.set("x", "<leader>rfv", ":Refactor extract_var ")

        vim.keymap.set("n", "<leader>rfb", ":Refactor extract_block")
        vim.keymap.set("n", "<leader>rfbf", ":Refactor extract_block_to_file")
    end,
}
