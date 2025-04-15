require("mason").setup({
	PATH = "skip",

	ui = {
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
	},

	max_concurrent_installers = 10,
	ensure_installed = {
        "stylua",
        "prettier",
		"codelldb",
		"swiftlint",
	},
})

--require("mason-lspconfig").setup({
--	ensure_installed = {},
--})
