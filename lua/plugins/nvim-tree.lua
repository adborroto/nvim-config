-- nvim-tree explorer

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local nvimtree = prequire('nvim-tree')
if not nvimtree then
  return
end

nvimtree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  view = { width = 34 },
  renderer = {
    highlight_git = true,
    icons = { show = { git = true, folder = true, file = true, folder_arrow = true } },
  },
  filters = { dotfiles = false },
  git = { enable = true, ignore = false },
})
