-- diffview (visual git diff)

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local diffview = prequire('diffview')
if not diffview then
  return
end

diffview.setup({
  view = {
    merge_tool = {
      layout = "diff3_vertical",
    },
  },
})
