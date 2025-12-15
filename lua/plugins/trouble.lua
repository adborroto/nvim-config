-- diagnostics ui via trouble.nvim

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local trouble = prequire('trouble')
if not trouble then
  return
end

trouble.setup({})
