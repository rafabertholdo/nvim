require("xcodebuild").setup({
	integrations = {
		xcode_build_server = {
			enabled = true,
		},
	},
})

-- Setup DAP integration AFTER xcodebuild setup so lldb-dap adapter and debug
-- commands are registered (true = load breakpoints).
require("xcodebuild.integrations.dap").setup(true)

-- WORKAROUND: Override lldb-dap adapter to use 'executable' type instead of
-- 'server'. The default 'server' type causes ECONNREFUSED errors with
-- lldb-dap (Xcode 16+).
local dap = require("dap")
dap.adapters["lldb-dap"] = {
	type = "executable",
	command = "xcrun",
	args = { "lldb-dap" },
}

local map = vim.keymap.set

-- Xcodebuild keymaps under <leader>i
map("n", "<leader>iI", "<cmd>XcodebuildPicker<cr>", { desc = "Show Xcodebuild Picker" })
map("n", "<leader>ir", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run" })
map("n", "<leader>id", "<cmd>XcodebuildBuildDebug<cr>", { desc = "Build & Debug" })
map("n", "<leader>iD", "<cmd>XcodebuildDebug<cr>", { desc = "Debug without Build" })
map("n", "<leader>ia", "<cmd>XcodebuildAttachDebugger<cr>", { desc = "Attach Debugger" })
map("n", "<leader>iX", "<cmd>XcodebuildDetachDebugger<cr>", { desc = "Detach Debugger" })
map("n", "<leader>ib", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
map("n", "<leader>iB", "<cmd>XcodebuildCleanBuild<cr>", { desc = "Clean Build" })
map("n", "<leader>iR", "<cmd>XcodebuildRun<cr>", { desc = "Run Project" })
map("n", "<leader>ix", "<cmd>XcodebuildCancel<cr>", { desc = "Cancel Build" })

-- Device & scheme selection
map("n", "<leader>iS", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select Scheme" })
map("n", "<leader>is", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
map("n", "<leader>in", "<cmd>XcodebuildNextDevice<cr>", { desc = "Next Device" })

-- Testing
map("n", "<leader>it", "<cmd>XcodebuildTest<cr>", { desc = "Run All Tests" })
map("n", "<leader>iT", "<cmd>XcodebuildTestTarget<cr>", { desc = "Run Test Target" })
map("n", "<leader>ic", "<cmd>XcodebuildTestClass<cr>", { desc = "Run Test Class" })
map("n", "<leader>if", "<cmd>XcodebuildTestFailing<cr>", { desc = "Rerun Failed Tests" })
map("n", "<leader>il", "<cmd>XcodebuildTestRepeat<cr>", { desc = "Repeat Last Test" })

-- Logs and actions
map("n", "<leader>iL", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Logs" })
map("n", "<leader>iC", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
