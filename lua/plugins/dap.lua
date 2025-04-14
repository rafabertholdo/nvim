return {
	{
		"rcarriga/nvim-dap-ui",
		event = "VeryLazy",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
		},
	},
	{
		"mfussenegger/nvim-dap",
	},
	{
		"daic0r/dap-helper.nvim",
		dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap" },
		config = function()
			require("dap-helper").setup()
		end,
	},
	-- {
	-- 	"Weissle/persistent-breakpoints.nvim",
	-- 	config = function()
	-- 		require("persistent-breakpoints").setup({
	-- 			always_reload = true,
	-- 			load_breakpoints_event = { "BufReadPost" },
	-- 		})
	-- 	end,
	-- },
}
