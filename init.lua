-- neovim entrypoint (lua)

-- leader must be set before plugins/keymaps
vim.g.mapleader = " "

-- bootstrap lazy.nvim (plugin manager)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- basics
  "tpope/vim-surround",
  "terryma/vim-multiple-cursors",
  "lifepillar/pgsql.vim",
  "ap/vim-css-color",

  -- vscode-like ui
  "Mofiqul/vscode.nvim",
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
  "lewis6991/gitsigns.nvim",
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  "folke/which-key.nvim",
  "folke/trouble.nvim",

  -- explorer + fuzzy search
  "nvim-tree/nvim-tree.lua",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

  -- syntax + editing
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  "numToStr/Comment.nvim",
  "windwp/nvim-autopairs",

  -- lsp + completion (node + python)
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",

  -- formatting
  "stevearc/conform.nvim",

  -- terminal
  { "akinsho/toggleterm.nvim", version = "*", config = true },

  -- debugging (optional)
  -- removed by default (vimspector requires python3 provider and can be noisy on systems without it)
}, {
  checker = { enabled = true },
  change_detection = { notify = false },
})

-- actual configuration lives here
require("config")


