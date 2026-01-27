-- lsp (node + python + kotlin) via mason and lspconfig

local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

local mason = prequire('mason')
local mason_lspconfig = prequire('mason-lspconfig')
local lspconfig = prequire('lspconfig')
if not (mason and mason_lspconfig and lspconfig) then
  return
end

mason.setup({})

local ensure_installed = {
  'ts_ls',   -- typescript/javascript (lspconfig server name)
  'eslint',  -- js/ts linting (lspconfig server name)
  'pyright', -- python
  'ruff',    -- python linting
  'kotlin_language_server', -- kotlin (lspconfig server name)
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_lsp = prequire('cmp_nvim_lsp')
if cmp_lsp then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

local function on_attach(_, bufnr)
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }
  map('n', 'gd', vim.lsp.buf.definition, opts)
  map('n', 'gD', vim.lsp.buf.declaration, opts)
  map('n', 'gI', vim.lsp.buf.implementation, opts)
  map('n', 'gr', vim.lsp.buf.references, opts)
  map('n', 'K', vim.lsp.buf.hover, opts)
  map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  map('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  map('n', '[d', vim.diagnostic.goto_prev, opts)
  map('n', ']d', vim.diagnostic.goto_next, opts)
  map('n', '<leader>q', vim.diagnostic.setloclist, opts)
end

local function setup_server(server_name, extra_opts)
  local base = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  local opts = base
  if extra_opts then
    opts = vim.tbl_deep_extend("force", base, extra_opts)
  end
  lspconfig[server_name].setup(opts)
end

local handlers = {
  function(server_name)
    setup_server(server_name, nil)
  end,
  ["eslint"] = function()
    setup_server("eslint", {
      settings = { format = { enable = true } },
    })
  end,
  ["ruff"] = function()
    setup_server("ruff", {
      init_options = {
        settings = {
          args = {},
        },
      },
    })
  end,
}

if type(mason_lspconfig.setup_handlers) == "function" then
  mason_lspconfig.setup({
    ensure_installed = ensure_installed,
  })
  mason_lspconfig.setup_handlers(handlers)
else
  -- newer mason-lspconfig versions configure handlers via setup()
  mason_lspconfig.setup({
    ensure_installed = ensure_installed,
    handlers = handlers,
  })
end
