-- comment.nvim configuration

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local comment = prequire('Comment')
if not comment then
  return
end

comment.setup({})
