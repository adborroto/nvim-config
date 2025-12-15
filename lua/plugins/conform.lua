-- formatting with conform.nvim

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local conform = prequire('conform')
if not conform then
  return
end

conform.setup({
  formatters_by_ft = {
    javascript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    yaml = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },
    python = { "ruff_format", "black" },
  },
  format_on_save = function()
    return { lsp_fallback = true, timeout_ms = 1500 }
  end,
})
