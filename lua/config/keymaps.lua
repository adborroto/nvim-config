-- keymaps and which-key groups

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- basics
map('n', '<Esc>', '<cmd>nohlsearch<cr>', opts)
map({ 'n', 'v' }, '<leader>y', '"+y', opts)
map('n', '<leader>Y', '"+Y', opts)
map({ 'n', 'v' }, '<leader>d', '"_d', opts)

-- save (terminal must pass ctrl+s)
map({ 'n', 'i', 'v' }, '<C-s>', '<Esc><cmd>w<cr>', opts)

-- window navigation (vscode-ish)
map('n', '<C-h>', '<C-w>h', opts)
map('n', '<C-j>', '<C-w>j', opts)
map('n', '<C-k>', '<C-w>k', opts)
map('n', '<C-l>', '<C-w>l', opts)

-- buffers/tabs
map('n', '<S-h>', '<cmd>bprevious<cr>', opts)
map('n', '<S-l>', '<cmd>bnext<cr>', opts)
map('n', '<leader>bd', '<cmd>bdelete<cr>', opts)
-- tab navigation (vscode-like: ctrl+tab, ctrl+shift+tab)
map('n', '<C-Tab>', '<cmd>bnext<cr>', opts)
map('n', '<C-S-Tab>', '<cmd>bprevious<cr>', opts)
-- close tab
map('n', '<leader>bc', '<cmd>bdelete<cr>', opts)
-- close all other tabs
map('n', '<leader>bo', '<cmd>%bd|e#|bd#<cr>', opts)

-- explorer (vscode: ctrl+b)
map('n', '<C-b>', '<cmd>NvimTreeToggle<cr>', opts)
map('n', '<leader>e', '<cmd>NvimTreeFocus<cr>', opts)
-- close explorer and focus code
map('n', '<leader>ec', '<cmd>NvimTreeClose<cr><C-w>l', opts)

-- terminal
map('t', '<Esc>', '<C-\\><C-n>', opts) -- exit terminal mode with Esc

-- telescope (vscode: ctrl+p)
map('n', '<C-p>', function()
  local builtin = prequire('telescope.builtin')
  if builtin then
    builtin.find_files({ hidden = true })
  end
end, opts)
map('n', '<leader>ff', function()
  local builtin = prequire('telescope.builtin')
  if builtin then
    builtin.find_files({ hidden = true })
  end
end, opts)
map('n', '<leader>fg', function()
  local builtin = prequire('telescope.builtin')
  if builtin then
    builtin.live_grep()
  end
end, opts)
map('n', '<leader>fb', function()
  local builtin = prequire('telescope.builtin')
  if builtin then
    builtin.buffers()
  end
end, opts)
map('n', '<leader>fh', function()
  local builtin = prequire('telescope.builtin')
  if builtin then
    builtin.help_tags()
  end
end, opts)
map('n', '<leader>fr', function()
  local builtin = prequire('telescope.builtin')
  if builtin then
    builtin.oldfiles()
  end
end, opts)

-- trouble diagnostics list
map('n', '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)

-- git diff (visual diff)
map('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', opts)
map('n', '<leader>gdc', '<cmd>DiffviewClose<cr>', opts)
map('n', '<leader>gh', '<cmd>DiffviewFileHistory<cr>', opts)
map('n', '<leader>gg', function()
  if vim.fn.executable('lazygit') == 1 then
    vim.cmd('LazyGit')
  else
    vim.notify('lazygit not found in PATH', vim.log.levels.WARN)
  end
end, opts)

-- formatting
map({ 'n', 'v' }, '<leader>f', function()
  local conform = prequire('conform')
  if conform then
    conform.format({ lsp_fallback = true, async = true, timeout_ms = 2000 })
  else
    vim.lsp.buf.format({ async = true })
  end
end, opts)

-- go to definition (vscode F12)
map('n', '<F12>', function()
  if vim.lsp.buf.definition then
    vim.lsp.buf.definition()
  end
end, opts)
-- go to references (vscode shift+F12)
map('n', '<S-F12>', function()
  if vim.lsp.buf.references then
    vim.lsp.buf.references()
  end
end, opts)

-- which-key (leader hints like vscode command palette discoverability)
local wk = prequire('which-key')
if wk then
  wk.setup({})
  -- which-key v3 uses `add()` with `group`
  if type(wk.add) == "function" then
    wk.add({
      { "<leader>x", group = "+diagnostics" },
      { "<leader>b", group = "+buffer" },
      { "<leader>g", group = "+git" },
      { "<leader>h", group = "+git hunk" },
    })
  else
    -- fallback for older which-key
    wk.register({
      ["<leader>x"] = { name = "+diagnostics" },
      ["<leader>b"] = { name = "+buffer" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>h"] = { name = "+git hunk" },
    })
  end
end
