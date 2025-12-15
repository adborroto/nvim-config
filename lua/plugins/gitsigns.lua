-- gitsigns (git signs in gutter)

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local gitsigns = prequire('gitsigns')
if not gitsigns then
  return
end

gitsigns.setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local map = vim.keymap.set
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = "next hunk" })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true, desc = "prev hunk" })

    -- actions
    map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { desc = "stage hunk" })
    map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { desc = "reset hunk" })
    map('n', '<leader>hS', gs.stage_buffer, { desc = "stage buffer" })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "undo stage hunk" })
    map('n', '<leader>hR', gs.reset_buffer, { desc = "reset buffer" })
    map('n', '<leader>hp', gs.preview_hunk, { desc = "preview hunk" })
    map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { desc = "blame line" })
    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "toggle blame" })
    map('n', '<leader>hd', gs.diffthis, { desc = "diff this" })
    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "diff this ~" })
    map('n', '<leader>td', gs.toggle_deleted, { desc = "toggle deleted" })
  end,
})
