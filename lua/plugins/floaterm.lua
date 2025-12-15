-- vim-floaterm configuration
-- we define explicit keymaps instead of relying on
-- vim-floaterm's global keymap variables, so this
-- works regardless of load order.

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- global keymaps for managing floaterm
map('n', '<leader>ts', '<cmd>FloatermNew<cr>', opts)
map('n', '<leader>tp', '<cmd>FloatermPrev<cr>', opts)
map('n', '<leader>tn', '<cmd>FloatermNext<cr>', opts)
map('n', '<leader>tt', '<cmd>FloatermToggle<cr>', opts)

-- python-specific run bindings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.api.nvim_set_keymap('n', '<F5>', ':w<CR>:FloatermNew --autoclose=0 python3 %<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('i', '<F5>', '<ESC>:w<CR>:FloatermNew --autoclose=0 python3 %<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>tr', ':w<CR>:FloatermNew --autoclose=0 python3 %<CR>', { noremap = true, silent = true })
  end,
})
