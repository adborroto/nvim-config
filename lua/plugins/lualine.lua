-- lualine statusline

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local lualine = prequire('lualine')
if not lualine then
  return
end

lualine.setup({
  options = {
    theme = 'onedark',
    globalstatus = true,
    section_separators = '',
    component_separators = '',
  },
})
