---
name: neovim-bertholdo-config
description: Maintains and extends the bertholdo Neovim config. Use when editing ~/.config/nvim, adding plugins, changing LSP/iOS/Telescope/Fugitive behavior, or answering questions about this specific setup (structure, keymaps, vim.pack, vim.lsp.config, xcodebuild.nvim, treesitter main branch).
---

# Neovim Bertholdo Config

Target: **Neovim 0.12+**. Uses the built-in `vim.pack` package manager (no lazy.nvim).

## Config layout

- **Entry:** `init.lua` → `require("bertholdo")` → `lua/bertholdo/init.lua`
- **Core:** `bertholdo/options.lua`, `bertholdo/mappings.lua`, `bertholdo/pack.lua`
- **Plugin install:** `bertholdo/pack.lua` — single `vim.pack.add({...})` list + `PackChanged` build hooks.
- **Plugin setup:** `bertholdo/configs/*.lua` — one file per plugin; each does its own `require("x").setup(...)`, defines keymaps, etc. `pack.lua` sequentially requires them.
- **Ftplugin:** `after/ftplugin/{swift,java,kotlin}.lua`.

## Plugin management (`vim.pack`)

- Install location: `stdpath("data")/site/pack/core/opt/`.
- **No lazy-loading** in `vim.pack` (no `event`/`ft`/`cmd`/`keys`). All plugins eager-load.
- Update: `:lua vim.pack.update()` opens a confirmation buffer; `:w` confirms, `:q` cancels.
- Remove: delete spec from `pack.lua`, restart, then `:lua vim.pack.del({ "<name>" })`.
- Build hooks for `make`/`TSUpdate` live in a `PackChanged` autocmd at the top of `pack.lua`.
- Adding a plugin:
  1. Append the GitHub URL (or `{ src = "...", name = "..." }`) to the list in `pack.lua`.
  2. If it needs setup, create `bertholdo/configs/<name>.lua` and add `"<name>"` to the `modules` list in `pack.lua`.

## LSP (Neovim 0.11+)

- **No** `require("lspconfig")`; use **`vim.lsp.config`** and **`vim.lsp.enable()`**.
- **No** mason-lspconfig. Mason installs binaries; servers are configured in `bertholdo/configs/lsp.lua` via `vim.lsp.config.<server> = { ... }` and `vim.lsp.enable({...})`.
- Servers: **lua_ls**, **bashls**, **marksman**, **sourcekit** (Swift; cmd from Xcode toolchain), **kotlin_lsp**, **zls**.
- Capabilities come from **cmp_nvim_lsp.default_capabilities()** merged with the baseline protocol; pulled in `configs/lsp.lua`.
- nvim-cmp is configured separately in `bertholdo/configs/cmp.lua` with sources: `nvim_lsp`, `luasnip`, `lazydev`, `buffer`.
- Neovim 0.11+ default LSP keymaps are used where possible (`K`, `grn`, `gra`, `grr`, `gri`, `grt`, `gO`, insert `<C-s>`). Custom `<leader>v*` aliases and `gd` are set up in the `LspAttach` autocmd in `bertholdo/init.lua`.

## Treesitter (nvim-treesitter `main` branch)

- The main branch is a full rewrite for Neovim 0.12+. **No** `require("nvim-treesitter.configs").setup({})`.
- `bertholdo/configs/treesitter.lua` calls `require("nvim-treesitter").install({...})` and a single `FileType` autocmd runs `vim.treesitter.start(buf)`.
- Indent via the new API is opt-in per buffer if needed.

## iOS / Xcode

- **xcodebuild.nvim** for build/run/tests; keymaps under **`<leader>i`** (e.g. `I` = picker, `ir` = build & run, `ib` = build, `iS` = select device, `it` = tests, `il` = logs).
- **DAP is enabled** for iOS via `lldb-dap` (Xcode 16+ built-in). Adapter is explicitly overridden to `type = "executable"` in `configs/xcode.lua` to avoid ECONNREFUSED with the `server` type.
- Breakpoint keymaps under **`<leader>B`** and F5–F9.

## Git (Fugitive)

- **`<leader>gs`** = `:Git` (status). In status: **`s`** stage, **`u`** unstage, **`cc`** commit, **`=`** inline diff. **`<leader>p`** push, **`<leader>P`** pull --rebase (in fugitive buffer). Merge: **`gu`** = ours, **`gh`** = theirs.
- Full reference: repo file **FUGITIVE_GUIDE.md** (and FUGITIVE_CHEATSHEET.md).

## Telescope

- **live_grep** and **find_files** include hidden files: **`vimgrep_arguments`** and **find_files** use `--hidden` and **`--glob=!.git/`** in `bertholdo/configs/telescope.lua`.

## Conventions

- Leader is **space**. Prefer **`<leader>Xy`** over **`<leader>xy`** when `x` is already used (e.g. `<leader>x` = close buffer).
- Prefer editing existing Lua files over creating new ones unless the feature is clearly separate.
- No format-on-save; Conform is used on demand (e.g. `<leader>f`).
- Use modern APIs only: `vim.hl.on_yank` (not `vim.highlight.on_yank`), `vim.diagnostic.jump({count=...})` (not `goto_next/prev`), `vim.fn.jobstart(cmd, { term = true })` (not `termopen`), `vim.fs.root` (not `lspconfig.util.root_pattern`), `vim.uv` (not `vim.loop`).

## When editing this config

1. **Plugins:** Add/remove specs in `bertholdo/pack.lua`; create setup module under `bertholdo/configs/` and add its name to the `modules` list. Do NOT reintroduce lazy.nvim.
2. **LSP:** Change only `vim.lsp.config.*` and `vim.lsp.enable()` in `bertholdo/configs/lsp.lua`; do not reintroduce `require("lspconfig")` or mason-lspconfig.
3. **Treesitter:** Only the main-branch API. Don’t reintroduce `nvim-treesitter.configs`.
4. **iOS:** `xcodebuild.nvim` + `lldb-dap` DAP is the supported workflow; keep the `executable`-type adapter override.
5. **Keymaps:** Prefer **`vim.keymap.set`** with **`desc`**; keep debug keymaps under **`<leader>B`**, iOS under **`<leader>i`**, Fugitive as above.

## Reference docs in repo

- **AGENTS.md** – Agent-facing rules; mirrors this skill.
- **FUGITIVE_GUIDE.md** – Fugitive usage and workflows.
- **FUGITIVE_CHEATSHEET.md** – Short Fugitive reference.
