require("bertholdo.mappings")
require("bertholdo.options")
require("bertholdo.lazy")

local augroup = vim.api.nvim_create_augroup
local BertholdoGroup = augroup("bertholdo", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

local function open_nvim_tree()
	-- open the tree
	require("nvim-tree.api").tree.open()
end

-- autocmd({ "VimEnter" }, { callback = open_nvim_tree })

-- autocmd("FileType", {
-- 	pattern = "swift",
-- 	callback = function()
-- 		vim.api.nvim_buf_set_keymap(0, "n", "<C-b>", function()
-- 			local ret = os.execute("swift build > /dev/null 2>&1")
-- 			if ret ~= 0 then
-- 				vim.notify("Build failed", vim.log.levels.ERROR)
-- 				return
-- 			end
-- 			vim.notify("Build succeded", vim.log.levels.INFO)
-- 		end)
--
-- 		vim.api.nvim_buf_set_keymap(0, "n", "<F5>", function()
-- 			local ret = os.execute("swift build > /dev/null 2>&1")
-- 			if ret ~= 0 then
-- 				vim.notify("Build failed", vim.log.levels.ERROR)
-- 				return
-- 			end
-- 			vim.notify("Build succeded", vim.log.levels.INFO)
-- 			local dap = require("dap")
-- 			dap.continue()
-- 		end)
-- 	end,
-- })

vim.filetype.add({
	extension = {
		templ = "templ",
	},
})

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = BertholdoGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

-- autocmd("BufEnter", {
-- 	group = BertholdoGroup,
-- 	callback = function()
-- 		if vim.bo.filetype == "zig" then
-- 			vim.cmd.colorscheme("tokyonight-night")
-- 		else
-- 			vim.cmd.colorscheme("rose-pine-moon")
-- 		end
-- 	end,
-- })

autocmd("LspAttach", {
	group = BertholdoGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		vim.keymap.set("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		vim.keymap.set("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		vim.keymap.set("n", "<leader>vca", function()
			vim.lsp.buf.code_action()
		end, opts)
		vim.keymap.set("n", "<leader>vrr", function()
			vim.lsp.buf.references()
		end, opts)
		vim.keymap.set("n", "<leader>vrn", function()
			vim.lsp.buf.rename()
		end, opts)
		vim.keymap.set("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		vim.keymap.set("n", "[d", function()
			vim.diagnostic.goto_next()
		end, opts)
		vim.keymap.set("n", "]d", function()
			vim.diagnostic.goto_prev()
		end, opts)
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.lsp.enable("sourcekit")
vim.lsp.enable("marksman")
