-- vim-floaterm configuration

local ok = pcall(vim.fn['floaterm#version'])
if not ok then
  return
end

-- global keymaps for managing floaterm
vim.g.floaterm_keymap_new    = '<leader>ts'
vim.g.floaterm_keymap_prev   = '<leader>tp'
vim.g.floaterm_keymap_next   = '<leader>tn'
vim.g.floaterm_keymap_toggle = '<leader>tt'

-- python-specific run bindings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.api.nvim_set_keymap('n', '<F5>', ':w<CR>:FloatermNew --autoclose=0 python3 %<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('i', '<F5>', '<ESC>:w<CR>:FloatermNew --autoclose=0 python3 %<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>tr', ':w<CR>:FloatermNew --autoclose=0 python3 %<CR>', { noremap = true, silent = true })
  end,
})
