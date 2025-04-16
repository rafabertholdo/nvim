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
			dapui.setup({
				layouts = {
					{
						elements = {
							{
								id = "stacks",
								size = 0.10,
							},
							{
								id = "breakpoints",
								size = 0.10,
							},
							{
								id = "watches",
								size = 0.10,
							},
							{
								id = "scopes",
								size = 0.70,
							},
						},
						position = "left",
						size = 40,
					},
					{
						elements = {
							{
								id = "console",
								size = 0.3,
							},
							{
								id = "repl",
								size = 0.7,
							},
						},
						position = "bottom",
						size = 10,
					},
				},
			})

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
		config = function()
			require("bertholdo.configs.dap")
		end,
	},
	{
		"daic0r/dap-helper.nvim",
		dependencies = { "rcarriga/nvim-dap-ui", "mfussenegger/nvim-dap" },
		config = function()
			require("dap-helper").setup()
		end,
	},
}
