local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
	layouts = {
		{
			elements = {
				{ id = "stacks", size = 0.10 },
				{ id = "breakpoints", size = 0.10 },
				{ id = "watches", size = 0.10 },
				{ id = "scopes", size = 0.70 },
			},
			position = "left",
			size = 40,
		},
		{
			elements = {
				{ id = "console", size = 0.3 },
				{ id = "repl", size = 0.7 },
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

require("mason-nvim-dap").setup({ handlers = {} })
require("dap-helper").setup()
