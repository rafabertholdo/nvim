return {
	{ "nvim-lua/plenary.nvim" }, -- lua functions that many plugins use
	{ "christoomey/vim-tmux-navigator" }, -- tmux & split window navigation
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		--	opts = {
		--			servers = {
		--				sourcekit = {
		--					cmd = "$HOME/.local/share/swiftly/bin/sourcekit-lsp",
		--				},
		--			},
		--		},
		dependencies = {
			{ "williamboman/mason.nvim", opts = {} },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-buffer",
		},
	},
	{ "hrsh7th/cmp-nvim-lsp", lazy = true },
	{ "hrsh7th/cmp-path", lazy = true },
	{ "hrsh7th/cmp-buffer", lazy = true },
	{
		"L3MON4D3/LuaSnip",
		conifg = function(opts)
			require("luasnip").setup(opts)
			require("luasnip.loaders.from_snipmate").load({ paths = "./snippets" })
		end,
	},
}
