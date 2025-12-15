-- nvim-autopairs configuration

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local npairs = prequire('nvim-autopairs')
if not npairs then
  return
end

npairs.setup({})
