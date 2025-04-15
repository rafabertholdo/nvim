# Nvim do Bertholdo

## Introduction

A starting point for Swift developers to Neovim

**NOT** a Neovim distribution, but instead a starting point for your configuration.

## Installation

### Install Neovim

You can build from source: [Neovim Build from source](https://github.com/neovim/neovim/blob/master/BUILD.md)

['stable'](https://github.com/neovim/neovim/releases/tag/stable) and latest

['nightly'](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.
If you are experiencing issues, please make sure you have the latest versions.

### Install External Dependencies

External Requirements:

- Basic utils: `git`, `make`, `unzip`, C Compiler (`gcc`)
- [ripgrep](https://github.com/BurntSushi/ripgrep#installation)
- Clipboard tool (xclip/xsel/win32yank or other depending on the platform)
- A [Nerd Font](https://www.nerdfonts.com/): optional, provides various icons
  - if you have it set `vim.g.have_nerd_font` in `init.lua` to true
- Emoji fonts (Ubuntu only, and only if you want emoji!) `sudo apt install fonts-noto-color-emoji`
- Language Setup:
  - If you want to write Typescript, you need `npm`
  - If you want to write Golang, you will need `go`
  - etc.

### Neovim config path

Neovim's configurations are located under the following paths, depending on your OS:

| OS                   | PATH                                      |
| :------------------- | :---------------------------------------- |
| Linux, MacOS         | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)        | `%localappdata%\nvim\`                    |
| Windows (powershell) | `$env:LOCALAPPDATA\nvim\`                 |

#### Clone bertholdo.nvim

> [!NOTE]
> If following the recommended step above (i.e., forking the repo), replace
> `nvim-lua` with `<your_github_username>` in the commands below

##### Linux and Mac

```sh
git clone https://github.com/rafabertholdo/nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

##### Windows

If you're using `cmd.exe`:

```
git clone https://github.com/rafabertholdo/nvim.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```
git clone https://github.com/rafabertholdo/nvim.git "${env:LOCALAPPDATA}\nvim"
```

### Post Installation

Start Neovim

```sh
nvim
```

That's it! Lazy will install all the plugins you have. Use `:Lazy` to view
he current plugin status. Hit `q` to close the window.

#### Mason install

[Mason](https://github.com/williamboman/mason.nvim) is a package manager for lsp and formatters.
After opening nvim for the first time type ":" to enter command mode and type:

```sh
MasonInstall codelldb
MasonInstall prettier
MasonInstall stylua
```

## Uninstall

### Linux / MacOS (unix)

````sh
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim
```
````
