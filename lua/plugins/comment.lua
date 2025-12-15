-- comment.nvim configuration

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local comment = prequire('Comment')
if not comment then
  return
end

comment.setup({
  mappings = {
    basic = true,
    extra = true,
  },
})

-- custom keymaps for commenting
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- comment/uncomment current line
map('n', '<leader>kc', function()
  local api = require('Comment.api')
  api.toggle.linewise.current()
end, opts)

-- comment/uncomment selected lines (visual mode)
map('v', '<leader>kc', function()
  local api = require('Comment.api')
  api.toggle.linewise(vim.fn.visualmode())
end, opts)
