local dap = require("dap")

local function android_attach_config()
	return {
		type = "java",
		request = "attach",
		name = "Android Debug (Attach)",
		hostName = "127.0.0.1",
		port = function()
			return tonumber(vim.g.android_debug_port or 8700)
		end,
	}
end

local function ensure_config(configurations, name)
	for _, config in ipairs(configurations) do
		if config.name == name then
			return
		end
	end

	table.insert(configurations, android_attach_config())
end

local function cleanup_android_debug()
	local port = tonumber(vim.g.android_debug_port or 8700)
	vim.system({ "adb", "forward", "--remove", "tcp:" .. port }, { text = true }, function() end)
	vim.system({ "adb", "shell", "am", "clear-debug-app" }, { text = true }, function() end)
end

-- DAP adapter for xcodebuild.nvim
-- For Xcode 16+, xcodebuild.nvim automatically configures lldb-dap
-- No manual adapter configuration needed - the plugin handles it via integrations.dap.setup()
-- Swift configurations are also managed by xcodebuild.nvim dynamically

dap.configurations.java = dap.configurations.java or {}
ensure_config(dap.configurations.java, "Android Debug (Attach)")

dap.configurations.kotlin = dap.configurations.kotlin or {}
ensure_config(dap.configurations.kotlin, "Android Debug (Attach)")

dap.listeners.before.event_terminated["android_debug_cleanup"] = cleanup_android_debug
dap.listeners.before.event_exited["android_debug_cleanup"] = cleanup_android_debug

-- Old manual Swift Package Manager configuration (commented out)
-- Uncomment this if you need to debug Swift Package Manager projects:
-- dap.configurations.swift = {
-- 	{
-- 		name = "Launch file",
-- 		type = "debugserver",
-- 		request = "launch",
-- 		program = function()
-- 			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/.build/debug/", "file")
-- 		end,
-- 		cwd = "${workspaceFolder}",
-- 		stopOnEntry = false,
-- 	},
-- }
-- dap.adapters.debugserver = {
-- 	type = "server",
-- 	port = "13000",
-- 	executable = {
-- 		command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
-- 		args = {
-- 			"--port",
-- 			"13000",
-- 			"--liblldb",
-- 			"/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB",
-- 		},
-- 	},
-- }
