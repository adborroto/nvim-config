-- plugin specifications for lazy.nvim
-- this file is required from init.lua and returns the full plugin list

return {
  -- basics
  "tpope/vim-surround",
  "terryma/vim-multiple-cursors",
  "lifepillar/pgsql.vim",
  "ap/vim-css-color",

  -- ui
  "navarasu/onedark.nvim",
  "nvim-tree/nvim-web-devicons",
  "nvim-lualine/lualine.nvim",
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
  "lewis6991/gitsigns.nvim",
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  -- git ui
  {
    "kdheepak/lazygit.nvim",
    lazy = true,
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
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
  "github/copilot.vim",

  -- formatting
  "stevearc/conform.nvim",

  -- floating terminal for quick runs (python, etc.)
  "voldikss/vim-floaterm",

  -- debugging (dap)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
      "theHamsta/nvim-dap-virtual-text",
    },
  },
}

