require("nvchad.options")
require("configs.dap")
-- add yours here!

require("nvim-tree").setup({})

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & identation
opt.tabstop = 4
opt.shiftwidth = 4
vim.opt.shiftwidth = 4
opt.expandtab = true
--opt.autoindent = true
vim.opt.smartindent = true

opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
