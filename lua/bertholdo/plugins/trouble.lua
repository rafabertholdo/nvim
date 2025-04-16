return {
	"folke/trouble.nvim",
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>qq",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics (Trouble)",
		},
		{
			"<leader>qX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>cs",
			"<cmd>Trouble symbols toggle focus=false<cr>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>cl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
			"<leader>qL",
			"<cmd>Trouble loclist toggle<cr>",
			desc = "Location List (Trouble)",
		},
		{
			"<leader>qQ",
			"<cmd>Trouble qflist toggle<cr>",
			desc = "Quickfix List (Trouble)",
		},
	},
}

-- return {
-- 	{
-- 		"folke/trouble.nvim",
-- 		config = function()
-- 			require("trouble").setup({
-- 				icons = false,
-- 			})
--
-- 			vim.keymap.set("n", "<leader>qq", function()
-- 				require("trouble").toggle()
-- 			end)
--
-- 			vim.keymap.set("n", "[q", function()
-- 				require("trouble").next({ skip_groups = true, jump = true })
-- 			end)
--
-- 			vim.keymap.set("n", "]q", function()
-- 				require("trouble").previous({ skip_groups = true, jump = true })
-- 			end)
-- 		end,
-- 	},
-- }
