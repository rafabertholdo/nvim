# Agent instructions – Bertholdo Neovim config

When editing this repo or answering questions about this Neovim setup, follow these guidelines.

## Project layout

- **Entry:** `init.lua` → `require("bertholdo")` → `lua/bertholdo/init.lua`
- **Core:** `lua/bertholdo/options.lua`, `mappings.lua`, `pack.lua`
- **Plugins:** `lua/bertholdo/pack.lua` — single `vim.pack.add({...})` list (Neovim 0.12+ built-in package manager; no lazy.nvim).
- **Plugin setup:** `lua/bertholdo/configs/*.lua` — one file per plugin; side-effectful `require("x").setup(...)` + keymaps.
- **Ftplugin:** `after/ftplugin/{swift,java,kotlin}.lua`.

## Plugin management (`vim.pack`)

- Neovim 0.12+ built-in package manager. Plugins land under `stdpath("data")/site/pack/core/opt/`.
- Add new plugins: extend the list in `lua/bertholdo/pack.lua` and either create a matching `lua/bertholdo/configs/<name>.lua` setup module (and add its name to the `modules` list in `pack.lua`), or configure inline.
- Update plugins: `:lua vim.pack.update()` — confirmation buffer opens; `:w` to confirm, `:q` to cancel.
- Remove plugins: delete the spec from `pack.lua`, restart, then `:lua vim.pack.del({ "<name>" })`.
- `vim.pack` has **no** lazy-loading (no `event`/`ft`/`cmd`/`keys`). All plugins eager-load; keep the list tight.
- Post-install hooks live in a `PackChanged` autocmd at the top of `pack.lua` (e.g. `telescope-fzf-native.nvim` `make`, `nvim-treesitter` parser update).

## LSP (Neovim 0.11+)

- Use **`vim.lsp.config`** and **`vim.lsp.enable()`** only. Do **not** use `require("lspconfig")` or mason-lspconfig.
- Servers: lua_ls, bashls, marksman, sourcekit (Swift), kotlin_lsp, zls. Configure in `lua/bertholdo/configs/lsp.lua`.
- Completion setup (nvim-cmp) is in `lua/bertholdo/configs/cmp.lua`; LSP pulls capabilities from `cmp_nvim_lsp` there.
- Neovim 0.11+ ships default LSP keymaps (`K`, `grn`, `gra`, `grr`, `gri`, `grt`, `gO`, insert `<C-s>`); custom `<leader>v*` aliases live in the `LspAttach` autocmd in `lua/bertholdo/init.lua`.

## Treesitter (nvim-treesitter `main` branch, Nvim 0.12+)

- This is the post-rewrite branch. **No** `require("nvim-treesitter.configs").setup()`.
- Parsers are installed via `require("nvim-treesitter").install({...})` in `lua/bertholdo/configs/treesitter.lua`.
- Highlighting is enabled by a single `FileType` autocmd that calls `vim.treesitter.start(buf)`.

## iOS / Xcode

- **xcodebuild.nvim** for build, run, debug, and tests. Keymaps under **`<leader>i`**.
- **DAP enabled** with `lldb-dap` (from Xcode) for iOS debugging in Neovim.
- **Setup:** `lua/bertholdo/plugins/xcode.lua` configures xcodebuild.nvim with DAP integration.
- **DAP config:** `lua/bertholdo/configs/dap.lua` sets up lldb-dap adapter for Swift debugging.

### Key iOS Keymaps

**Configuration & Build:**
- `<leader>iI` – Xcodebuild Picker (select scheme/device)
- `<leader>ib` – Build project
- `<leader>iB` – Clean build
- `<leader>ir` – Build & Run (no debugging)
- `<leader>ix` – Cancel build/run

**Debugging:**
- `<leader>id` – Build & Debug (stops at breakpoints)
- `<leader>iD` – Debug without build
- `<leader>ia` – Attach debugger
- `<leader>iX` – Detach debugger
- `<leader>Bb` – Toggle breakpoint
- `<F5>` – Continue, `<F6>` – Step over, `<F7>` – Step into, `<F8>` – Step out
- `<F9>` – Terminate debug session
- `<leader>Bp` – Open REPL (for LLDB `po` commands)
- `<leader>Br` – Toggle DAP UI

**Testing:**
- `<leader>it` – Run all tests
- `<leader>iT` – Run test target
- `<leader>ic` – Run test class
- `<leader>if` – Rerun failed tests
- `<leader>il` – Repeat last test

**Device/Scheme:**
- `<leader>iS` – Select scheme
- `<leader>is` – Select device
- `<leader>in` – Next device

## Conventions

- Leader: **space**. Prefer **`<leader>Xy`** when **`<leader>x`** is taken (e.g. `<leader>x` = close buffer).
- Prefer editing existing Lua over adding new files unless the feature is clearly separate.
- No format-on-save; Conform on demand (e.g. `<leader>f`).
- Keymaps: use **`vim.keymap.set`** with **`desc`**. Debug under **`<leader>B`**, iOS under **`<leader>i`**.
- Use modern APIs only: `vim.hl.on_yank` (not `vim.highlight.on_yank`), `vim.diagnostic.jump({count=...})` (not `goto_next/prev`), `vim.fn.jobstart(cmd, { term = true })` (not `termopen`), `vim.fs.root` (not `lspconfig.util.root_pattern`), `vim.uv` (not `vim.loop`).

## Reference in repo

- **FUGITIVE_GUIDE.md**, **FUGITIVE_CHEATSHEET.md** – Git (Fugitive)
- **.cursor/skills/neovim-bertholdo-config/** – Detailed skill and reference
