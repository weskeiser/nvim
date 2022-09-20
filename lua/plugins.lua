local fn = vim.fn

--hydra


-- Automatically install Packer
--[[
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.vim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/tbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer. Close and reopen Neovim.."
  vim.cmd [[packadd packer.nvim]]
--end

-- Autocommand that reloads Neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup wondow
packer.init {
  display  = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/popup.nvim"
  -- Useful lua functions used by many plugins
  use "nvim-lua/plenary.nvim"

  -- Neoscroll - Smooth scrolling
  use 'karb94/neoscroll.nvim'

  -- Nvim web devicons
  use 'kyazdani42/nvim-web-devicons'

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0'
  }

  use 'ThePrimeagen/harpoon'

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'
  }

  use 'nvim-treesitter/playground'

  use 'nvim-treesitter/nvim-treesitter-refactor'

  use { 'p00f/nvim-ts-rainbow' }

  -- Barbar Bufferlines
--  use 'romgrk/barbar.nvim'

  -- Indent blankline
  use 'lukas-reineke/indent-blankline.nvim'

  -- Material Theme
  use 'marko-cerovac/material.nvim'
  use 'Mofiqul/dracula.nvim'

  -- LSP config
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'onsails/lspkind-nvim'
  use 'nvim-lua/lsp_extensions.nvim'
  use 'glepnir/lspsaga.nvim'
  use 'simrat39/symbols-outline.nvim'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'neoclide/vim-jsx-improve'
  use 'leafgarland/typescript-vim'
  use 'mattn/emmet-vim'


  use 'mhartington/formatter.nvim'
  use 'fsouza/prettierd'

  -- Highlight unused objects
  ---- Possible replacement?: neodim
  use 'Kasama/nvim-custom-diagnostic-highlight'


  --use 'styled-components/vim-styled-components'


  -- Autopairs
  use {
    "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
  }

  use {
    'windwp/nvim-ts-autotag'
  }

  -- Eyeliner
  use 'jinh0/eyeliner.nvim'

  -- Quickfix helper
  use {'kevinhwang91/nvim-bqf', ft = 'qf'}

  -- Scrollbar
  use("petertriho/nvim-scrollbar")

  -- Vim-surround
  use 'tpope/vim-surround'

  -- Vim-textobj-user
  use 'kana/Vim-textobj-user'

  -- Vim-textobj-variable-segment
  use { "Julian/Vim-textobj-variable-segment", requires = {"kana/Vim-textobj-user"} }

  -- Vim-swap 
  use 'machakann/vim-swap'


  -- Nvim-tree
  use {
  'kyazdani42/nvim-tree.lua', tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- Java
  use 'mfussenegger/nvim-jdtls'
  use 'mfussenegger/nvim-dap'

  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }








if PACKER_BOOTSTRAP then
  require("packer").sync()
 end
 end)
