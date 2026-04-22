-- nvim-treesitter "main" branch (Neovim 0.12+) – complete rewrite.
-- No more require("nvim-treesitter.configs").setup(); parsers are installed
-- explicitly and highlight/indent are started via FileType autocmds.

local parsers = {
	"bash",
	"java",
	"json",
	"kotlin",
	"lua",
	"luadoc",
	"printf",
	"swift",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
}

-- `install` is async; kick it off and forget.
require("nvim-treesitter").install(parsers)

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("BertholdoTreesitter", { clear = true }),
	callback = function(args)
		-- `vim.treesitter.start` picks up the parser that matches the buffer's
		-- filetype via `vim.treesitter.language.get_lang`. It no-ops when the
		-- parser is missing, so unsupported filetypes are safe.
		pcall(vim.treesitter.start, args.buf)
	end,
})
