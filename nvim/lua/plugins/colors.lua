function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            require('rose-pine').setup({
                ColorMyPencils("rose-pine"),
                disable_background = true,
                styles = {
                    italic = false,
                },
            })
        end
    },
    {
        'marko-cerovac/material.nvim',
        'Mofiqul/vscode.nvim',
        'ellisonleao/gruvbox.nvim',
        'catppuccin/nvim',
        'navarasu/onedark.nvim',
        'shaunsingh/nord.nvim',
    }
}
