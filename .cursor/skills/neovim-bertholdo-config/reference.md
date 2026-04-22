# Bertholdo Config – Reference

## Keymap summary

| Scope | Key | Action |
|-------|-----|--------|
| **iOS** | `<leader>iI` | Xcodebuild picker |
| | `<leader>ir` | Build & run |
| | `<leader>ib` | Build |
| | `<leader>id` | Build & debug |
| | `<leader>iS` | Select scheme |
| | `<leader>is` | Select device |
| | `<leader>it` | Run tests |
| | `<leader>iL` | Toggle logs |
| **Fugitive** | `<leader>gs` | Git status |
| | In status: `s` stage, `u` unstage, `cc` commit, `=` diff |
| | `<leader>p` / `<leader>P` | Push / pull --rebase (in fugitive buffer) |
| | `gu` / `gh` | Merge: get ours / theirs |
| **Debug (DAP + lldb-dap for iOS)** | `<F9>` / `<leader>db` | Toggle breakpoint |
| | `<F5>` | Continue |
| | `<F6>`–`<F8>` | Step over/into/out |
| | `<F10>` | Terminate |
| | `<leader>dr` | Toggle DAP UI |
| | `<leader>de` | Eval expression |
| **Telescope** | `<leader>ff` | Find files |
| | `<leader>fw` | Live grep |
| | `<leader>fb` | Buffers |
| **LSP (0.11+ defaults)** | `K`, `grn`, `gra`, `grr`, `gri`, `grt`, `gO` | hover / rename / code action / references / implementation / type def / doc symbols |
| | `gd`, `<leader>v*` | Custom LSP aliases |
| **Other** | `<leader>f` | Format (conform) |
| | `<leader>x` | Close buffer |

## Important paths

- Config root: `~/.config/nvim/` (or repo root when in repo).
- Plugin install list: `lua/bertholdo/pack.lua` (single `vim.pack.add` call).
- Plugin setup modules: `lua/bertholdo/configs/<name>.lua` (colors, telescope, lsp, cmp, treesitter, conform, lualine, bufferline, nvim-tree, fugitive, trouble, which-key, zenmode, fidget, lazydev, mason, dap, dap-ui, xcode, typr).
- Core: `lua/bertholdo/{options,mappings,init}.lua`.

## Plugin management

- Update all: `:lua vim.pack.update()` — shows confirmation buffer; `:w` to confirm, `:q` to cancel.
- Install location: `~/.local/share/nvim/site/pack/core/opt/`.
- Lockfile: `~/.config/nvim/nvim-pack-lock.json` (under VCS for reproducibility).
- Remove a plugin: delete from `pack.lua`, restart, then `:lua vim.pack.del({ "<name>" })`.

## LSP server commands (Mason)

- lua_ls: `lua-language-server`
- bashls: `bash-language-server start`
- marksman: `marksman server`
- sourcekit: Xcode toolchain path (set in `configs/lsp.lua`).
- kotlin_lsp: Mason `kotlin-lsp --stdio`.

## Deprecated APIs — do not reintroduce

| Don’t use | Use |
|-----------|-----|
| `vim.highlight.on_yank` | `vim.hl.on_yank` |
| `vim.diagnostic.goto_next/prev` | `vim.diagnostic.jump({ count = ±1, float = true })` |
| `vim.fn.termopen(cmd, opts)` | `vim.fn.jobstart(cmd, { term = true, ... })` |
| `require("lspconfig").util.root_pattern` | `vim.fs.root` |
| `vim.loop` | `vim.uv` |
| `require("nvim-treesitter.configs").setup` | `require("nvim-treesitter").install(...)` + `vim.treesitter.start` |
| `lazy.nvim` / `require("lazy")` | `vim.pack.add` |
