require "nvchad.options"
require "configs.dap"
-- add yours here!

require("nvim-tree").setup {}

local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & identation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true
