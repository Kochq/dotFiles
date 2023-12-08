vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use) -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- fzf
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- theme
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
    config = function()
      vim.cmd('colorscheme rose-pine')
    end
  })

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

  -- lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- harpoon | <leader>ha
  use("theprimeagen/harpoon")
  -- history of changes | <F5>
  use("mbbill/undotree")
  -- git integration | <leader>gS
  use("tpope/vim-fugitive")
  use("lewis6991/gitsigns.nvim")
  -- highlighting
  use("nvim-treesitter/nvim-treesitter");
  use("nvim-treesitter/playground")
  -- top function context
  use("nvim-treesitter/nvim-treesitter-context")
  -- lluvia | <leader>mr
  use("eandrju/cellular-automaton.nvim")
  -- copilot | <C-e>
  use("github/copilot.vim")
  -- Autocompletion () ""
  use("jiangmiao/auto-pairs")
  -- Comment toggler | <leader>gc
  use("terrortylor/nvim-comment")
  -- Transparent for gitsigns
  use("xiyaowong/nvim-transparent")

end)
