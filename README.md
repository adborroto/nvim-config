# configuration

this neovim config is focused on a **onedark-themed**, **vscode-like** experience for **node/typescript**, **python**, and **kotlin**:

- **package manager**: `lazy.nvim`
- **file explorer**: `nvim-tree`
- **fuzzy search**: `telescope` (+ `fzf-native` + `telescope-repo.nvim` + `telescope-project.nvim`)
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
- **fd**: required for `telescope-repo.nvim` (find repositories on filesystem)
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

plugins will be automatically installed on first launch. to manually install or update plugins:

```
:Lazy sync
```

then install language servers and formatters (from inside neovim):

1. open mason ui:

   ```
   :Mason
   ```

2. install language servers (press `i` on each):

   - `typescript-language-server` (typescript/javascript)
   - `eslint-lsp` (js/ts linting)
   - `pyright` (python)
   - `ruff` (python linting)
   - `kotlin-language-server` (kotlin)

3. install formatters (press `i` on each):

   - `prettier` (javascript/typescript/json/yaml/markdown)
   - `prettierd` (prettier daemon, faster)
   - `black` (python)
   - note: `ruff` also provides formatting (configured via conform.nvim)

4. verify installation:
   ```
   :Mason
   ```
   installed packages show a checkmark ✓

alternative: install everything via mason:

- **core tooling only**:

  ```
  :MasonInstall typescript-language-server eslint-lsp pyright ruff kotlin-language-server prettier prettierd black
  ```

- **core tooling + python debugging**:

  ```
  :MasonInstall typescript-language-server eslint-lsp pyright ruff kotlin-language-server prettier prettierd black debugpy
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
  - **`space bn`**: next buffer
  - **`space bp`**: previous buffer
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
  - **`space fR`**: find repositories (jump into git repos in your filesystem)
  - **`space fp`**: find projects (switch between saved projects)
- **project management (telescope-project.nvim)**
  - **`space fp`**: open project picker (switch between saved projects)
  - **in project picker**:
    - **`<CR>`** or **`f`**: open project files (telescope find_files)
    - **`c`**: create/add current directory as project
    - **`d`**: delete selected project
    - **`r`**: rename selected project
    - **`s`**: search inside project files
    - **`b`**: browse project files
    - **`w`**: change to project directory without opening files
    - **`R`**: find recently opened files in project
- **completion (nvim-cmp)**
  - **`ctrl+space`**: trigger completion
  - **`tab`**: select next item / expand snippet
  - **`shift+tab`**: select previous item / jump snippet backward
  - **`enter`**: confirm selection
  - completion sources: lsp, snippets, buffer, path
  - **cmdline completion**:
    - type `/` for search: buffer completion
    - type `:` for commands: path + command completion
- **lsp** (works for any language with an attached LSP: TypeScript, Python, Kotlin, etc.)
  - **`gd`**: go to definition
  - **`gD`**: go to declaration
  - **`gI`**: go to implementation
  - **`gr`**: find references (where symbol is used)
  - **`K`**: hover documentation
  - **`space rn`**: rename symbol
  - **`space ca`**: code action
  - **`[d`** / **`]d`**: previous / next diagnostic
  - **`space q`**: open diagnostics list (location list)
  - **`F12`**: go to definition (vscode-like)
  - **`shift+F12`**: find references (vscode-like)
- **jump list** (navigate back/forward after `gd`, opening files, etc.)
  - **`ctrl+o`**: jump backward (older location)
  - **`ctrl+i`**: jump forward (newer location; same as **`tab`** in normal mode)
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

### Ruby LSP (ruby_lsp) quit with exit code 1

This usually means Ruby LSP failed to start because **`bundle install` failed** in your Ruby project. The LSP log (`~/.local/state/nvim/lsp.log`) often shows:

- **`Gem::Ext::BuildError`** – a gem with native extensions (e.g. **nio4r**, **pg**) failed to compile.
- **`Bundler::GemNotFound`** – some gems from the Gemfile are not installed (often as a result of the build error above).
- **`Ruby LSP> Running bundle install failed`** – Ruby LSP tried to install the bundle and gave up.

**Fix it in the project (outside Neovim):**

1. Open a terminal and go to the Ruby project root (where the Gemfile is).
2. Ensure build tools are installed (macOS: `xcode-select --install` if needed).
3. If **nio4r** failed: remove a broken install and reinstall:
   ```bash
   gem uninstall nio4r
   # if the gem dir is left in a bad state:
   # rm -rf ~/.rbenv/versions/3.2.1/lib/ruby/gems/3.2.0/gems/nio4r-2.5.8
   ```
4. Run **`bundle install`** and fix any errors (missing system libs, wrong Ruby version, etc.).
5. Restart Neovim and open a file in that project again.

Once `bundle install` succeeds in the project, Ruby LSP should start without exiting with code 1.

### reload config after changes

```
:source ~/.config/nvim/init.lua
```

or restart neovim

### project management

**telescope-project.nvim** helps you manage and switch between projects:

- **manual project addition**: 
  - open the project picker with `<space>fp`
  - press `c` to add the current directory as a project
  - if you're in a git repository, it will use the git root automatically
- **switch projects**: use `<space>fp` to see all your projects and quickly switch between them
- **default behavior**: pressing `<CR>` on a project opens telescope find_files in that project
- **project actions** (in project picker):
  - **`<CR>`** or **`f`**: open project files (telescope find_files)
  - **`c`**: create/add current directory as project
  - **`d`**: delete selected project
  - **`r`**: rename selected project
  - **`s`**: search inside project files
  - **`b`**: browse project files
  - **`w`**: change to project directory without opening files
  - **`R`**: find recently opened files in project

## config layout

- **`init.lua`**: entry point, sets leader, configures `lazy.nvim`, and declares plugins.
- **`lua/config/`**:
  - **`options.lua`**: core editor options.
  - **`colors.lua`**: colorscheme and related settings.
  - **`keymaps.lua`**: keymaps and which-key groups.
- **`lua/plugins/`**: one file per plugin (for example `nvim-tree.lua`, `telescope.lua`, `lualine.lua`, `bufferline.lua`, `gitsigns.lua`, `diffview.lua`, `treesitter.lua`, `comment.lua`, `autopairs.lua`, `cmp.lua`, `lsp.lua`, `conform.lua`, `trouble.lua`, `floaterm.lua`, `dap.lua`).

## links

- `https://www.trackawesomelist.com/rockerBOO/awesome-neovim/readme/#project`
