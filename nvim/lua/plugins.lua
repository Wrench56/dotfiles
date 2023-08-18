vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

vim.api.nvim_set_hl(0, "LazyNormal", { ctermbg=0 })

require("lazy").setup({
  'shaunsingh/nord.nvim',
  'navarasu/onedark.nvim',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
    event = 'BufWinEnter'
  },
  {
    'akinsho/bufferline.nvim',
    version = "v3.*",
    dependencies = 'nvim-tree/nvim-web-devicons',
    event = 'BufWinEnter'
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    version = 'nightly' -- optional, updated every week. (see issue #1193)
  },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 
        'nvim-lua/plenary.nvim',
        'nvim-treesitter/nvim-treesitter'
    }
  },

  {
    'nvim-lualine/lualine.nvim',
    lazy = true,
    event = 'BufWinEnter'
  },
  'norcalli/nvim-colorizer.lua',
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter'
  },
  {
    'p00f/nvim-ts-rainbow',
    event = 'BufWinEnter'
  },
  'windwp/nvim-autopairs',
  'folke/which-key.nvim',
  'lukas-reineke/indent-blankline.nvim',
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'BufWinEnter'
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*'
  },
  'neovim/nvim-lspconfig',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-vsnip',
  {
    'hrsh7th/vim-vsnip',
    event = 'BufWinEnter'
  },
  'onsails/lspkind-nvim',
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufWinEnter'
  },
  'andweeb/presence.nvim',
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },
  {
    'samodostal/image.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'm00qek/baleia.nvim'
    }
  },
  'rest-nvim/rest.nvim',
  'NFrid/due.nvim',
  'jbyuki/nabla.nvim',
  {
    'richardbizik/nvim-toc',
    event = 'BufRead *.md',
    config = function()
        require('nvim-toc').setup({})
    end
  },
  {
    'sudormrfbin/cheatsheet.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim',
    }
  },
  'jbyuki/venn.nvim',
  {
    'saecki/crates.nvim',
    --event = 'BufRead Cargo.toml',
    tag = 'v0.3.0',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('crates').setup({
            popup = {
                autofocus = true,
                border = 'rounded'
            }
        })
    end
  }
},
{
  install = {
    colorscheme = {'onedark'}
  },
  ui = {
    border = 'rounded'
  }
})
