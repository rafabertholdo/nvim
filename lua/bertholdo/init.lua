require("bertholdo.mappings")
require("bertholdo.options")
require("bertholdo.pack")

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local BertholdoGroup = augroup("bertholdo", {})
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

vim.filetype.add({
	extension = {
		templ = "templ",
	},
	pattern = {
		[".*/.*%.gradle%.kts"] = "kotlin",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		(vim.hl or vim.highlight).on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd("LspAttach", {
	group = BertholdoGroup,
	callback = function(e)
		local opts = { buffer = e.buf }

		-- Neovim 0.11+ provides these defaults already:
		--   K           -> vim.lsp.buf.hover()
		--   grn         -> vim.lsp.buf.rename()
		--   gra         -> vim.lsp.buf.code_action()
		--   grr         -> vim.lsp.buf.references()
		--   gri         -> vim.lsp.buf.implementation()
		--   grt         -> vim.lsp.buf.type_definition()
		--   gO          -> vim.lsp.buf.document_symbol()
		--   <C-s> (ins) -> vim.lsp.buf.signature_help()
		-- Custom aliases below keep the <leader>v* prefix and `gd`.

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "LSP go to definition" }))
		vim.keymap.set(
			"n",
			"<leader>gd",
			vim.lsp.buf.definition,
			vim.tbl_extend("force", opts, { desc = "LSP go to definition" })
		)
		vim.keymap.set(
			"n",
			"<leader>vws",
			vim.lsp.buf.workspace_symbol,
			vim.tbl_extend("force", opts, { desc = "LSP workspace symbol" })
		)
		vim.keymap.set(
			"n",
			"<leader>vd",
			vim.diagnostic.open_float,
			vim.tbl_extend("force", opts, { desc = "Diagnostic float" })
		)
		vim.keymap.set(
			"n",
			"<leader>vca",
			vim.lsp.buf.code_action,
			vim.tbl_extend("force", opts, { desc = "LSP code action" })
		)
		vim.keymap.set(
			"n",
			"<leader>vrr",
			vim.lsp.buf.references,
			vim.tbl_extend("force", opts, { desc = "LSP references" })
		)
		vim.keymap.set(
			"n",
			"<leader>vrn",
			vim.lsp.buf.rename,
			vim.tbl_extend("force", opts, { desc = "LSP rename" })
		)
		vim.keymap.set(
			"i",
			"<C-h>",
			vim.lsp.buf.signature_help,
			vim.tbl_extend("force", opts, { desc = "LSP signature help" })
		)

		-- NB: user prefers inverted semantics (`[d` = next, `]d` = prev).
		-- Overrides Neovim 0.11 defaults which are the opposite direction.
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
