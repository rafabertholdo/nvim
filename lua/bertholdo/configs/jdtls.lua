local M = {}

local mason_root = vim.fn.stdpath("data") .. "/mason"
local mason_bin = mason_root .. "/bin"
local mason_packages = mason_root .. "/packages"

local function mason_cmd(binary)
	local path = mason_bin .. "/" .. binary
	if vim.fn.executable(path) == 1 then
		return path
	end

	return binary
end

local function glob(pattern)
	return vim.split(vim.fn.glob(pattern, true), "\n", { trimempty = true })
end

local function project_root(bufnr)
	return vim.fs.root(bufnr or 0, {
		"settings.gradle.kts",
		"settings.gradle",
		"build.gradle.kts",
		"build.gradle",
		"gradlew",
		".git",
	})
end

local function workspace_dir(root_dir)
	local project_name = root_dir:gsub("[/\\:]", "_")
	return vim.fn.stdpath("cache") .. "/jdtls-workspaces/" .. project_name
end

local function debug_bundles()
	local bundles = glob(
		mason_packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
	)

	for _, path in ipairs(glob(mason_packages .. "/java-test/extension/server/*.jar")) do
		local name = vim.fn.fnamemodify(path, ":t")
		if name ~= "com.microsoft.java.test.runner-jar-with-dependencies.jar" and name ~= "jacocoagent.jar" then
			table.insert(bundles, path)
		end
	end

	return bundles
end

local function on_attach()
	local ok, jdtls = pcall(require, "jdtls")
	if not ok then
		return
	end

	jdtls.setup_dap({ hotcodereplace = "auto" })
	pcall(function()
		require("jdtls.setup").add_commands()
	end)
	pcall(function()
		require("jdtls.dap").setup_dap_main_class_configs()
	end)
end

function M.config(root_dir)
	return {
		cmd = {
			mason_cmd("jdtls"),
			"-data",
			workspace_dir(root_dir),
		},
		root_dir = root_dir,
		init_options = {
			bundles = debug_bundles(),
		},
		settings = {
			java = {},
		},
		on_attach = on_attach,
	}
end

function M.get_client(root_dir)
	for _, client in ipairs(vim.lsp.get_clients({ name = "jdtls" })) do
		if not root_dir or client.config.root_dir == root_dir then
			return client
		end
	end
end

function M.find_java_anchor(root_dir)
	for _, path in ipairs(vim.fn.globpath(root_dir, "**/*.java", false, true)) do
		if not path:match("/build/") and not path:match("/%.gradle/") then
			return path
		end
	end
end

function M.start_or_attach(bufnr)
	local root_dir = project_root(bufnr)
	if not root_dir then
		return nil, "Could not find a Gradle project root for JDTLS."
	end

	local ok, jdtls = pcall(require, "jdtls")
	if not ok then
		return nil, "nvim-jdtls is not available yet."
	end

	local client_id = jdtls.start_or_attach(M.config(root_dir), nil, { bufnr = bufnr })
	if not client_id then
		return nil, "Failed to start JDTLS."
	end

	return vim.lsp.get_client_by_id(client_id), root_dir
end

function M.ensure_for_root(root_dir)
	local client = M.get_client(root_dir)
	if client then
		return client
	end

	local anchor = M.find_java_anchor(root_dir)
	if not anchor then
		return nil, "No Java file found in this project to bootstrap Android debugging."
	end

	local bufnr = vim.fn.bufadd(anchor)
	vim.fn.bufload(bufnr)
	vim.bo[bufnr].filetype = "java"

	local ok, jdtls = pcall(require, "jdtls")
	if not ok then
		return nil, "nvim-jdtls is not available yet."
	end

	local client_id = jdtls.start_or_attach(M.config(root_dir), nil, { bufnr = bufnr })
	if not client_id then
		return nil, "Failed to start JDTLS for Android debugging."
	end

	return vim.lsp.get_client_by_id(client_id)
end

return M
