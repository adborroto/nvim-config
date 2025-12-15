-- treesitter configuration

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local ts = prequire('nvim-treesitter.configs')
if not ts then
  return
end

ts.setup({
  ensure_installed = {
    "lua",
    "vim",
    "vimdoc",
    "bash",
    "json",
    "yaml",
    "toml",
    "markdown",
    "python",
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",
    "sql",
  },
  highlight = { enable = true },
  indent = { enable = true },
})
