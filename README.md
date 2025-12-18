# configuration

this neovim config is focused on a **onedark-themed**, **vscode-like** experience for **node/typescript** and **python**:

- **package manager**: `lazy.nvim`
- **file explorer**: `nvim-tree`
- **fuzzy search**: `telescope` (+ `fzf-native`)
- **tabs**: `bufferline.nvim` (vscode-like tab bar)
- **terminal**: `vim-floaterm` (floating terminals, python runner)
- **git**: `gitsigns.nvim` + `diffview.nvim` (visual git diff) + `lazygit.nvim` (terminal git ui)
- **lsp + completion**: `mason` + `nvim-lspconfig` + `nvim-cmp`
- **formatting**: `conform.nvim`
- **debugging**: `nvim-dap` + `nvim-dap-ui` + `nvim-dap-python` + `nvim-dap-virtual-text`

## install

### prerequisites

- **neovim**: 0.9+ (0.10+ recommended)
- **git**: required for plugin installation
- **make**: required for `telescope-fzf-native`
- **node**: for `typescript-language-server`, `eslint`, and formatting tools like `prettier`
- **python**: for python tooling (recommended: `pyright` via mason)
- **debugging (optional)**: `debugpy` for python debug adapter (for example `pip install debugpy` or `:MasonInstall debugpy`)
- **git ui (optional)**: `lazygit` binary available in your `PATH` (install via your package manager, for example `brew install lazygit` on macOS)

### first run

open neovim and let `lazy.nvim` install everything:

```bash
cd ~/.config/nvim
nvim
```

then install language servers and formatters (from inside neovim):

1. open mason ui:

   ```
   :Mason
   ```

2. install language servers (press `i` on each):

   - `ts_ls` (typescript/javascript)
   - `eslint`
   - `pyright`
   - `ruff`

3. install formatters (press `i` on each):

   - `prettier` (javascript/typescript/json/yaml/markdown)
   - `prettierd` (prettier daemon, faster)
   - `black` (python)
   - `ruff_format` (python, alternative to black)

4. verify installation:
   ```
   :Mason
   ```
   installed packages show a checkmark ✓

alternative: install everything via mason:

- **core tooling only**:

  ```
  :MasonInstall ts_ls eslint pyright ruff prettier prettierd black ruff_format
  ```

- **core tooling + python debugging**:

  ```
  :MasonInstall ts_ls eslint pyright ruff prettier prettierd black ruff_format debugpy
  ```

## key shortcuts (vscode-like)

leader is **space**.

- **file explorer**
  - **`space ee`**: toggle explorer (open/close)
  - **`space ef`**: focus explorer
  - **`space ec`**: focus code while keeping explorer open
  - **click code window**: switch focus (mouse)
  - **inside explorer (nvim-tree default)**
    - **`a`**: create file or directory
    - **`r`**: rename
    - **`d`**: delete
    - **`c` / `x` / `p`**: copy / cut / paste
    - **`<cr>`**: open file in current window
    - **`v` / `s`**: open file in vertical / horizontal split
    - **`y` / `Y` / `gy`**: copy name / relative path / absolute path
- **window navigation**
  - **`ctrl+h`**: move to left window
  - **`ctrl+j`**: move to window below
  - **`ctrl+k`**: move to window above
  - **`ctrl+l`**: move to right window
- **terminal (vim-floaterm)**
  - **`space ts`**: new floating terminal
  - **`space tp`**: previous floating terminal
  - **`space tn`**: next floating terminal
  - **`space tt`**: toggle last floating terminal
  - **python files**:
    - **`F5`** (normal/insert): save and run current file with `python3` in floaterm
    - **`space tr`**: save and run current file with `python3` in floaterm
- **tabs/buffers**
  - **`ctrl+tab`**: next tab
  - **`ctrl+shift+tab`**: previous tab
  - **`shift+h`**: previous tab
  - **`shift+l`**: next tab
  - **`space bc`**: close current tab
  - **`space bd`**: close current tab
  - **`space bo`**: close all other tabs
  - **click tab**: switch to tab (mouse)
- **fuzzy search**
  - **`ctrl+p`**: find files
  - **`space ff`**: find files
  - **`space fg`**: live grep
  - **`space fb`**: buffers
  - **`space fr`**: recent files
- **lsp**
  - **`F12`**: go to definition (vscode-like)
  - **`shift+F12`**: go to references
  - **`gd`**: go to definition
  - **`gr`**: references
  - **`K`**: hover
  - **`space rn`**: rename
  - **`space ca`**: code action
  - **`[d` / `]d`**: prev/next diagnostic
- **formatting**
  - **`space f`**: format file/selection
- **commenting**
  - **`space kc`**: comment/uncomment current line or selection
  - **`gcc`**: comment/uncomment current line
  - **`gc`** (visual mode): comment/uncomment selected lines
  - **`gbc`**: comment/uncomment current line (block comment style)
- **git**
  - **`space gd`**: open visual diff (side-by-side)
  - **`space gdc`**: close visual diff
  - **`space gh`**: file history
  - **`space gg`**: open lazygit (terminal git ui)
  - **`space hs`**: stage hunk (visual mode: stage selection)
  - **`space hr`**: reset hunk
  - **`space hp`**: preview hunk
  - **`space hb`**: blame line
  - **`]c`**: next git hunk
  - **`[c`**: previous git hunk
  - **`space hd`**: diff this file
  - git signs show in gutter: `+` (added), `~` (changed), `_` (deleted)
- **save**
  - **`space s`**: save file
- **debugging (dap)**
  - **`space db`**: toggle breakpoint
  - **`space dc`**: start/continue debugging
  - **`space do`**: step over
  - **`space di`**: step into
  - **`space dO`**: step out
  - **`space dq`**: terminate debugging session
  - **`space du`**: toggle dap ui panel

## troubleshooting

### check plugin health

```
:checkhealth
```

### check specific plugins

```
:checkhealth mason
:checkhealth lspconfig
:checkhealth conform
:checkhealth which-key
```

### verify formatters are installed

```
:Mason
```

look for checkmarks ✓ next to `prettier`, `prettierd`, `black`, `ruff_format`

### if formatting fails

1. ensure formatters are installed via `:Mason`
2. check conform health: `:checkhealth conform`
3. verify file type: `:set ft?` (should show file type like `javascript`, `python`, etc.)
4. try manual format: `:lua require('conform').format()`

### debugging quickstart

for python:

1. open a `*.py` file.
2. set a breakpoint with `space db` on the line you want to stop.
3. start debugging with `space dc` (continue).
4. use `space do` / `space di` / `space dO` to step, and `space dq` to stop.
5. toggle the dap ui panel with `space du`.

### reload config after changes

```
:source ~/.config/nvim/init.lua
```

or restart neovim

## config layout

- **`init.lua`**: entry point, sets leader, configures `lazy.nvim`, and declares plugins.
- **`lua/config/`**:
  - **`options.lua`**: core editor options.
  - **`colors.lua`**: colorscheme and related settings.
  - **`keymaps.lua`**: keymaps and which-key groups.
- **`lua/plugins/`**: one file per plugin (for example `nvim-tree.lua`, `telescope.lua`, `lualine.lua`, `bufferline.lua`, `gitsigns.lua`, `diffview.lua`, `treesitter.lua`, `comment.lua`, `autopairs.lua`, `cmp.lua`, `lsp.lua`, `conform.lua`, `trouble.lua`, `floaterm.lua`, `dap.lua`).

## links

- `https://www.trackawesomelist.com/rockerBOO/awesome-neovim/readme/#project`
