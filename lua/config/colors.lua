-- colors and colorscheme

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local onedark = prequire('onedark')
if onedark then
  onedark.setup({
    style = 'darker',
  })
  onedark.load()
else
  -- fallback if theme is missing
  vim.cmd.colorscheme('default')
end
