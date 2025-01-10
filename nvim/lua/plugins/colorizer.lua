return {
    "norcalli/nvim-colorizer.lua",
    config = function()
        require("colorizer").setup({"*"})

        vim.keymap.set("n", "<leader>#","<cmd>ColorizerToggle<cr>")
    end,
}
