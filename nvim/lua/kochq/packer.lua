vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use) -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/plenary.nvim'

    -- fzf
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- Themes
    use('marko-cerovac/material.nvim')
    use('Mofiqul/vscode.nvim')
    use('rose-pine/neovim')
    use('ellisonleao/gruvbox.nvim')
    use('catppuccin/nvim')
    use('navarasu/onedark.nvim')
    use('shaunsingh/nord.nvim')

    -- lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Telescope theme
    use('nvim-telescope/telescope-ui-select.nvim')

    -- lenguage server
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }

    -- git integration | <leader>gS
    use({
        'kdheepak/lazygit.nvim',
        -- optional for floating window border decoration
        requires = {
            'nvim-lua/plenary.nvim',
        },
    })

    -- harpoon | <leader>ha
    use {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- history of changes | <F5>
    use('mbbill/undotree')
    -- git column integration
    use('lewis6991/gitsigns.nvim')
    -- highlighting
    use('nvim-treesitter/nvim-treesitter');
    use('nvim-treesitter/playground')
    -- top function context
    use('nvim-treesitter/nvim-treesitter-context')
    -- lluvia | <leader>mr
    use('eandrju/cellular-automaton.nvim')
    -- -- copilot | <C-e>
    -- use('github/copilot.vim')
    -- Comment toggler | <leader>gc
    use('terrortylor/nvim-comment')
    -- Transparent for gitsigns
    use('xiyaowong/nvim-transparent')
    -- Nice icons
    use('nvim-tree/nvim-web-devicons')
    -- Privacy
    use('laytan/cloak.nvim')
    -- Autopair
    use('windwp/nvim-autopairs')
    -- java -> introduccion a objetos
    use 'mfussenegger/nvim-jdtls'
end)
