local opt = vim.opt

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.signcolumn = "yes"

opt.scrolloff = 8
opt.isfname:append("@-@")

opt.updatetime = 50

-- Auto-reload files when changed externally
opt.autoread = true

-- Setup autocommands to trigger checktime on various events
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    command = "if mode() !~ '\\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif",
})
