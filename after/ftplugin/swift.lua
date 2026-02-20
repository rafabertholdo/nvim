-- Swift-specific keybindings and settings

local function swift_build()
	local ret = os.execute("swift build > /dev/null 2>&1")
	if ret ~= 0 then
		vim.notify("Build failed", vim.log.levels.ERROR)
		return false
	end
	vim.notify("Build succeeded", vim.log.levels.INFO)
	return true
end

-- Build project
vim.keymap.set("n", "<C-b>", swift_build, { buffer = true, desc = "Swift: Build project" })

-- Build and debug
vim.keymap.set("n", "<F5>", function()
	if swift_build() then
		require("dap").continue()
	end
end, { buffer = true, desc = "Swift: Build and debug" })
