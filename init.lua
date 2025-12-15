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

-- load plugin specs from lua/plugins/init.lua
local plugins = require("plugins")

require("lazy").setup(plugins, {
  checker = { enabled = true },
  change_detection = { notify = false },
})

-- actual configuration lives in lua/config and lua/plugins
require("config")

