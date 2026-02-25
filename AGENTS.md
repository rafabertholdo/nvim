# Agent instructions – Bertholdo Neovim config

When editing this repo or answering questions about this Neovim setup, follow these guidelines.

## Project layout

- **Entry:** `init.lua` → `require("bertholdo")` → `lua/bertholdo/init.lua`
- **Core:** `lua/bertholdo/options.lua`, `mappings.lua`, `lazy.lua`
- **Plugins:** `lua/bertholdo/plugins/*.lua` (lazy.nvim specs)
- **Configs:** `lua/bertholdo/configs/*.lua` (telescope, conform, mason, etc.)
- **Ftplugin:** `after/ftplugin/swift.lua` (Swift-only keymaps)

## LSP (Neovim 0.11+)

- Use **`vim.lsp.config`** and **`vim.lsp.enable()`** only. Do **not** use `require("lspconfig")` or mason-lspconfig.
- Servers: lua_ls, bashls, marksman, sourcekit (Swift). Configure in `lua/bertholdo/plugins/lsp.lua`.

## iOS / Xcode

- **xcodebuild.nvim** for build, run, tests. Keymaps under **`<leader>i`** (e.g. `I`, `ir`, `ib`, `iS`, `it`, `il`).
- **No DAP for iOS** – user debugs in Xcode. Do not re-enable `xcodebuild_dap` or codelldb for iOS.

## Conventions

- Leader: **space**. Prefer **`<leader>Xy`** when **`<leader>x`** is taken (e.g. `<leader>x` = close buffer).
- Prefer editing existing Lua over adding new files unless the feature is clearly separate.
- No format-on-save; Conform on demand (e.g. `<leader>f`).
- Keymaps: use **`vim.keymap.set`** with **`desc`**. Debug under **`<leader>B`**, iOS under **`<leader>i`**.

## Reference in repo

- **FUGITIVE_GUIDE.md**, **FUGITIVE_CHEATSHEET.md** – Git (Fugitive)
- **IOS_DEBUGGING_GUIDE.md** – iOS build/run/test (no DAP)
- **.cursor/skills/neovim-bertholdo-config/** – Detailed skill and reference
