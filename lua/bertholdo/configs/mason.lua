require("mason").setup({
	PATH = "prepend",
	ui = {
		icons = {
			package_pending = " ",
			package_installed = " ",
			package_uninstalled = " ",
		},
	},
	max_concurrent_installers = 10,
})

local registry = require("mason-registry")

local packages = {
	"lua-language-server",
	"bash-language-server",
	"marksman",
	"kotlin-lsp",
	"jdtls",
	"java-debug-adapter",
	"ktlint",
	"xmlformatter",
	"stylua",
	"prettier",
	"codelldb",
	"swiftlint",
}

for _, package_name in ipairs(packages) do
	local ok, pkg = pcall(registry.get_package, package_name)
	if ok and not pkg:is_installed() then
		pkg:install()
	end
end
