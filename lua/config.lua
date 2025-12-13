-- central neovim configuration (loaded from init.lua via: require('config'))

-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250
vim.opt.signcolumn = "yes"
vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true

-- helper: safe require
local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then
    return m
  end
  return nil
end

-- theme (vscode-like)
do
  local vscode = prequire('vscode')
  if vscode then
    vscode.setup({
      transparent = false,
      italic_comments = true,
      disable_nvimtree_bg = true,
    })
    vim.cmd.colorscheme('vscode')
  end
end

-- keymaps
do
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- basics
  map('n', '<Esc>', '<cmd>nohlsearch<cr>', opts)
  map({ 'n', 'v' }, '<leader>y', '"+y', opts)
  map('n', '<leader>Y', '"+Y', opts)
  map({ 'n', 'v' }, '<leader>d', '"_d', opts)

  -- save (terminal must pass ctrl+s)
  map({ 'n', 'i', 'v' }, '<C-s>', '<Esc><cmd>w<cr>', opts)

  -- window navigation (vscode-ish)
  map('n', '<C-h>', '<C-w>h', opts)
  map('n', '<C-j>', '<C-w>j', opts)
  map('n', '<C-k>', '<C-w>k', opts)
  map('n', '<C-l>', '<C-w>l', opts)

  -- buffers/tabs
  map('n', '<S-h>', '<cmd>bprevious<cr>', opts)
  map('n', '<S-l>', '<cmd>bnext<cr>', opts)
  map('n', '<leader>bd', '<cmd>bdelete<cr>', opts)
  -- tab navigation (vscode-like: ctrl+tab, ctrl+shift+tab)
  map('n', '<C-Tab>', '<cmd>bnext<cr>', opts)
  map('n', '<C-S-Tab>', '<cmd>bprevious<cr>', opts)
  -- close tab
  map('n', '<leader>bc', '<cmd>bdelete<cr>', opts)
  -- close all other tabs
  map('n', '<leader>bo', '<cmd>%bd|e#|bd#<cr>', opts)

  -- explorer (vscode: ctrl+b)
  map('n', '<C-b>', '<cmd>NvimTreeToggle<cr>', opts)
  map('n', '<leader>e', '<cmd>NvimTreeFocus<cr>', opts)
  -- close explorer and focus code
  map('n', '<leader>ec', '<cmd>NvimTreeClose<cr><C-w>l', opts)

  -- terminal (vscode-like: ctrl+`)
  map('n', '<leader>tt', '<cmd>ToggleTerm<cr>', opts)
  map('t', '<Esc>', '<C-\\><C-n>', opts) -- exit terminal mode with Esc

  -- telescope (vscode: ctrl+p)
  map('n', '<C-p>', function()
    local builtin = prequire('telescope.builtin')
    if builtin then
      builtin.find_files({ hidden = true })
    end
  end, opts)
  map('n', '<leader>ff', function()
    local builtin = prequire('telescope.builtin')
    if builtin then
      builtin.find_files({ hidden = true })
    end
  end, opts)
  map('n', '<leader>fg', function()
    local builtin = prequire('telescope.builtin')
    if builtin then
      builtin.live_grep()
    end
  end, opts)
  map('n', '<leader>fb', function()
    local builtin = prequire('telescope.builtin')
    if builtin then
      builtin.buffers()
    end
  end, opts)
  map('n', '<leader>fh', function()
    local builtin = prequire('telescope.builtin')
    if builtin then
      builtin.help_tags()
    end
  end, opts)
  map('n', '<leader>fr', function()
    local builtin = prequire('telescope.builtin')
    if builtin then
      builtin.oldfiles()
    end
  end, opts)

  -- trouble diagnostics list
  map('n', '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>', opts)
  map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', opts)

  -- git diff (visual diff)
  map('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', opts)
  map('n', '<leader>gdc', '<cmd>DiffviewClose<cr>', opts)
  map('n', '<leader>gh', '<cmd>DiffviewFileHistory<cr>', opts)

  -- formatting
  map({ 'n', 'v' }, '<leader>f', function()
    local conform = prequire('conform')
    if conform then
      conform.format({ lsp_fallback = true, async = true, timeout_ms = 2000 })
    else
      vim.lsp.buf.format({ async = true })
    end
  end, opts)

  -- go to definition (vscode F12)
  map('n', '<F12>', function()
    if vim.lsp.buf.definition then
      vim.lsp.buf.definition()
    end
  end, opts)
  -- go to references (vscode shift+F12)
  map('n', '<S-F12>', function()
    if vim.lsp.buf.references then
      vim.lsp.buf.references()
    end
  end, opts)
end

-- which-key (leader hints like vscode command palette discoverability)
do
  local wk = prequire('which-key')
  if wk then
    wk.setup({})
    -- which-key v3 uses `add()` with `group`
    if type(wk.add) == "function" then
      wk.add({
        { "<leader>x", group = "+diagnostics" },
        { "<leader>b", group = "+buffer" },
        { "<leader>g", group = "+git" },
        { "<leader>h", group = "+git hunk" },
      })
    else
      -- fallback for older which-key
      wk.register({
        ["<leader>x"] = { name = "+diagnostics" },
        ["<leader>b"] = { name = "+buffer" },
        ["<leader>g"] = { name = "+git" },
        ["<leader>h"] = { name = "+git hunk" },
      })
    end
  end
end

-- nvim-tree explorer
do
  local nvimtree = prequire('nvim-tree')
  if nvimtree then
    nvimtree.setup({
      disable_netrw = true,
      hijack_netrw = true,
      view = { width = 34 },
      renderer = {
        highlight_git = true,
        icons = { show = { git = true, folder = true, file = true, folder_arrow = true } },
      },
      filters = { dotfiles = false },
      git = { enable = true, ignore = false },
    })
  end
end

-- telescope
do
  local telescope = prequire('telescope')
  if telescope then
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
  end
end

-- lualine
do
  local lualine = prequire('lualine')
  if lualine then
    lualine.setup({
      options = {
        theme = 'vscode',
        globalstatus = true,
        section_separators = '',
        component_separators = '',
      },
    })
  end
end

-- bufferline (tabs)
do
  local bufferline = prequire('bufferline')
  if bufferline then
    bufferline.setup({
      options = {
        mode = "buffers",
        separator_style = "thin",
        always_show_bufferline = true,
        show_buffer_close_icons = true,
        show_close_icon = true,
        color_icons = true,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "left",
            separator = true,
          },
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { 'close' },
        },
      },
    })
  end
end

-- gitsigns (git signs in gutter)
do
  local gitsigns = prequire('gitsigns')
  if gitsigns then
    gitsigns.setup({
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = vim.keymap.set
        local opts = { buffer = bufnr, noremap = true, silent = true }

        -- navigation
        map('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "next hunk" })

        map('n', '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = "prev hunk" })

        -- actions
        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk, { desc = "stage hunk" })
        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { desc = "reset hunk" })
        map('n', '<leader>hS', gs.stage_buffer, { desc = "stage buffer" })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "undo stage hunk" })
        map('n', '<leader>hR', gs.reset_buffer, { desc = "reset buffer" })
        map('n', '<leader>hp', gs.preview_hunk, { desc = "preview hunk" })
        map('n', '<leader>hb', function() gs.blame_line({ full = true }) end, { desc = "blame line" })
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "toggle blame" })
        map('n', '<leader>hd', gs.diffthis, { desc = "diff this" })
        map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "diff this ~" })
        map('n', '<leader>td', gs.toggle_deleted, { desc = "toggle deleted" })
      end,
    })
  end
end

-- diffview (visual git diff)
do
  local diffview = prequire('diffview')
  if diffview then
    diffview.setup({
      view = {
        merge_tool = {
          layout = "diff3_vertical",
        },
      },
    })
  end
end

-- treesitter
do
  local ts = prequire('nvim-treesitter.configs')
  if ts then
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
  end
end

-- comment
do
  local comment = prequire('Comment')
  if comment then
    comment.setup({})
  end
end

-- autopairs
do
  local npairs = prequire('nvim-autopairs')
  if npairs then
    npairs.setup({})
  end
end

-- completion
do
  local cmp = prequire('cmp')
  local luasnip = prequire('luasnip')
  if cmp and luasnip then
    local vscode_loader = prequire('luasnip.loaders.from_vscode')
    if vscode_loader then
      vscode_loader.lazy_load()
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      }),
    })
  end
end

-- lsp (node + python)
do
  local mason = prequire('mason')
  local mason_lspconfig = prequire('mason-lspconfig')
  local lspconfig = prequire('lspconfig')
  if mason and mason_lspconfig and lspconfig then
    mason.setup({})

    local ensure_installed = {
      'ts_ls',   -- typescript/javascript
      'eslint',  -- js/ts linting
      'pyright', -- python
      'ruff',    -- python linting
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
  end
end

-- formatting (conform)
do
  local conform = prequire('conform')
  if conform then
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
  end
end

-- diagnostics ui
do
  local trouble = prequire('trouble')
  if trouble then
    trouble.setup({})
  end
end

-- terminal (toggleterm)
do
  local toggleterm = prequire('toggleterm')
  if toggleterm then
    toggleterm.setup({
      size = 20,
      open_mapping = [[<c-\>]],
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },
    })
  end
end


