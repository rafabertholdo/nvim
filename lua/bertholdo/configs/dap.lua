local dap = require("dap")

-- Configure lldb-dap adapter for xcodebuild.nvim
dap.adapters["lldb-dap"] = {
	type = "server",
	port = 13000,
	executable = {
		command = "xcrun",
		args = {
			"lldb-dap",
			"--port",
			"13000",
		},
	},
}

-- Configure Swift configurations for xcodebuild.nvim
-- The actual configurations are managed by xcodebuild.nvim dynamically
dap.configurations.swift = {
	{
		name = "iOS App Debugger",
		type = "lldb-dap",
		request = "attach",
		program = function()
			-- This will be provided by xcodebuild.nvim
			return ""
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		waitFor = true,
	},
}

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
