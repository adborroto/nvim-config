# configuration

this neovim config is focused on a **vscode-like** experience for **node/typescript** and **python**:

- **package manager**: `lazy.nvim`
- **file explorer**: `nvim-tree`
- **fuzzy search**: `telescope` (+ `fzf-native`)
- **tabs**: `bufferline.nvim` (vscode-like tab bar)
- **terminal**: `toggleterm.nvim` (integrated terminal)
- **git**: `gitsigns.nvim` + `diffview.nvim` (visual git diff)
- **lsp + completion**: `mason` + `nvim-lspconfig` + `nvim-cmp`
- **formatting**: `conform.nvim`

## install

### prerequisites

- **neovim**: 0.9+ (0.10+ recommended)
- **git**: required for plugin installation
- **make**: required for `telescope-fzf-native`
- **node**: for `typescript-language-server`, `eslint`, and formatting tools like `prettier`
- **python**: for python tooling (recommended: `pyright` via mason)

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

alternative: install all at once via command:

```
:MasonInstall ts_ls eslint pyright ruff prettier prettierd black ruff_format
```

## key shortcuts (vscode-like)

leader is **space**.

- **file explorer**
  - **`ctrl+b`**: toggle explorer (open/close)
  - **`space e`**: focus explorer
  - **`space ec`**: close explorer and focus code
  - **`ctrl+l`**: move focus to code window (when explorer is open)
  - **click code window**: switch focus (mouse)
- **terminal**
  - **`ctrl+\`**: toggle terminal (vscode-like)
  - **`space tt`**: toggle terminal
  - **`Esc`**: exit terminal mode (when in terminal)
  - terminal opens at bottom, horizontal split
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
- **git**
  - **`space gd`**: open visual diff (side-by-side)
  - **`space gdc`**: close visual diff
  - **`space gh`**: file history
  - **`space hs`**: stage hunk (visual mode: stage selection)
  - **`space hr`**: reset hunk
  - **`space hp`**: preview hunk
  - **`space hb`**: blame line
  - **`]c`**: next git hunk
  - **`[c`**: previous git hunk
  - **`space hd`**: diff this file
  - git signs show in gutter: `+` (added), `~` (changed), `_` (deleted)
- **save**
  - **`ctrl+s`**: save (your terminal must pass this through)

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

### reload config after changes

```
:source ~/.config/nvim/init.lua
```

or restart neovim

## links

- `https://www.trackawesomelist.com/rockerBOO/awesome-neovim/readme/#project`
