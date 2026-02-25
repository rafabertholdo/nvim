return {
	"wojciech-kulik/xcodebuild.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"MunifTanjim/nui.nvim",
		"mfussenegger/nvim-dap", -- Required for debug commands
	},
	config = function()
		require("xcodebuild").setup({
			integrations = {
				xcode_build_server = {
					enabled = true, -- enable xcode-build-server integration
				},
				-- Use lldb-dap (default, provided by Xcode)
				-- To use codelldb instead, set codelldb.enabled = true below
				lldb = {
					port = 13000, -- port used by lldb-dap
				},
				codelldb = {
					enabled = false, -- we're using lldb-dap instead
				},
			},
		})

		-- Setup DAP integration to register debug commands
		require("xcodebuild.integrations.dap").setup()

		-- Xcodebuild keymaps under <leader>i
		vim.keymap.set("n", "<leader>iI", "<cmd>XcodebuildPicker<cr>", { desc = "Show Xcodebuild Picker" })
		vim.keymap.set("n", "<leader>ir", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run" })
		vim.keymap.set("n", "<leader>id", "<cmd>XcodebuildBuildDebug<cr>", { desc = "Build & Debug" })
		vim.keymap.set("n", "<leader>iD", "<cmd>XcodebuildDebug<cr>", { desc = "Debug without Build" })
		vim.keymap.set("n", "<leader>ia", "<cmd>XcodebuildAttachDebugger<cr>", { desc = "Attach Debugger" })
		vim.keymap.set("n", "<leader>iX", "<cmd>XcodebuildDetachDebugger<cr>", { desc = "Detach Debugger" })
		vim.keymap.set("n", "<leader>ib", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
		vim.keymap.set("n", "<leader>iB", "<cmd>XcodebuildCleanBuild<cr>", { desc = "Clean Build" })
		vim.keymap.set("n", "<leader>iR", "<cmd>XcodebuildRun<cr>", { desc = "Run Project" })
		vim.keymap.set("n", "<leader>ix", "<cmd>XcodebuildCancel<cr>", { desc = "Cancel Build" })

		-- Device & scheme selection
		vim.keymap.set("n", "<leader>iS", "<cmd>XcodebuildSelectScheme<cr>", { desc = "Select Scheme" })
		vim.keymap.set("n", "<leader>is", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
		vim.keymap.set("n", "<leader>in", "<cmd>XcodebuildNextDevice<cr>", { desc = "Next Device" })

		-- Testing
		vim.keymap.set("n", "<leader>it", "<cmd>XcodebuildTest<cr>", { desc = "Run All Tests" })
		vim.keymap.set("n", "<leader>iT", "<cmd>XcodebuildTestTarget<cr>", { desc = "Run Test Target" })
		vim.keymap.set("n", "<leader>ic", "<cmd>XcodebuildTestClass<cr>", { desc = "Run Test Class" })
		vim.keymap.set("n", "<leader>in", "<cmd>XcodebuildTestNearest<cr>", { desc = "Run Nearest Test" })
		vim.keymap.set("n", "<leader>if", "<cmd>XcodebuildTestFailing<cr>", { desc = "Rerun Failed Tests" })
		vim.keymap.set("n", "<leader>il", "<cmd>XcodebuildTestRepeat<cr>", { desc = "Repeat Last Test" })

		-- Logs and actions
		vim.keymap.set("n", "<leader>iL", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Logs" })
		vim.keymap.set("n", "<leader>iC", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
	end,
}
