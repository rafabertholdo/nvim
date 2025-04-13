return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		opts = require("configs.conform"),
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},
	{ "VonHeikemen/lsp-zero.nvim" },
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		config = function()
			require("configs.mason")
		end,
	},

	-- { "wojciech-kulik/xcodebuild.nvim" },
}
