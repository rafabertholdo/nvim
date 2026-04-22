-- LSP server configuration using Neovim 0.11+ vim.lsp.config / vim.lsp.enable.
-- Do NOT reintroduce require("lspconfig"); servers are configured directly.
--
-- Important: In 0.11+, `root_dir` is callback-style
--   `function(bufnr, on_dir) on_dir(root) end`
-- Returning a value is silently ignored and the server never attaches. Prefer
-- `root_markers` (a list of filenames) for simple cases.

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

local function mason_cmd(binary)
	local path = mason_bin .. "/" .. binary
	if vim.fn.executable(path) == 1 then
		return path
	end
	return binary
end

-- Capabilities: baseline protocol + cmp_nvim_lsp extras (if available).
local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp then
	capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
end

local function with_capabilities(config)
	return vim.tbl_deep_extend("force", { capabilities = capabilities }, config or {})
end

vim.lsp.config("zls", with_capabilities({
	root_markers = { "build.zig", "zls.json", ".git" },
	settings = {
		zls = {
			enable_inlay_hints = true,
			enable_snippets = true,
			warn_style = true,
		},
	},
}))

vim.lsp.config("lua_ls", with_capabilities({
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultConfig = {
					indent_style = "space",
					indent_size = "2",
				},
			},
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = { enable = false },
		},
	},
}))

vim.lsp.config("bashls", with_capabilities({
	cmd = { mason_cmd("bash-language-server"), "start" },
	root_markers = { ".git" },
}))

vim.lsp.config("marksman", with_capabilities({
	cmd = { mason_cmd("marksman"), "server" },
	root_markers = { ".marksman.toml", ".git" },
}))

vim.lsp.config("sourcekit", with_capabilities({
	cmd = {
		"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
	},
	filetypes = { "swift", "objc", "objcpp", "c", "cpp", "objective-c", "objective-cpp" },
	get_language_id = function(_, ftype)
		local t = { objc = "objective-c", objcpp = "objective-cpp" }
		return t[ftype] or ftype
	end,
	-- Custom resolution: prefer BSP (xcode-build-server) → Xcode project →
	-- SPM/compile_commands → git. Must use the callback form on 0.11+.
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		if fname == "" then
			return
		end

		local root = vim.fs.root(fname, { "buildServer.json", ".bsp" })
			or vim.fs.root(fname, function(name)
				return name:match("%.xcodeproj$") or name:match("%.xcworkspace$")
			end)
			or vim.fs.root(fname, { "compile_commands.json", "Package.swift" })
			or vim.fs.root(fname, { ".git" })

		if root then
			on_dir(root)
		end
	end,
}))

vim.lsp.config("kotlin_lsp", with_capabilities({
	cmd = { mason_cmd("kotlin-lsp"), "--stdio" },
	single_file_support = true,
	root_markers = {
		"settings.gradle.kts",
		"settings.gradle",
		"build.gradle.kts",
		"build.gradle",
		"gradle.properties",
		".git",
	},
}))

vim.lsp.enable({ "lua_ls", "bashls", "marksman", "sourcekit", "kotlin_lsp" })

vim.g.zig_fmt_parse_errors = 0
vim.g.zig_fmt_autosave = 0

vim.diagnostic.config({
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},
})
