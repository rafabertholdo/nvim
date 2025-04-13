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
		"L3MON4D3/LuaSnip",
		conifg = function(opts)
			require("luasnip").setup(opts)
			require("luasnip.loaders.from_snipmate").load({ paths = "./snippets" })
		end,
	},
	"nvzone/volt",
	"nvzone/menu",
	{ "nvzone/minty", cmd = { "Huefy", "Shades" } },
}
