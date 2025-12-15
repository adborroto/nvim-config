-- telescope configuration

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local telescope = prequire('telescope')
if not telescope then
  return
end

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
      },
    },
  },
})

pcall(telescope.load_extension, 'fzf')
