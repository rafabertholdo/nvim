-- Swift-specific keybindings and settings

-- Note: For iOS/Xcode projects, use xcodebuild.nvim keymaps under <leader>i
-- This build function is for Swift Package Manager projects only
local function swift_build()
	local ret = os.execute("swift build > /dev/null 2>&1")
	if ret ~= 0 then
		vim.notify("Build failed", vim.log.levels.ERROR)
		return false
	end
	vim.notify("Build succeeded", vim.log.levels.INFO)
	return true
end

-- Build project (Swift Package Manager only)
vim.keymap.set("n", "<C-b>", swift_build, { buffer = true, desc = "Swift: Build project (SPM)" })

-- For iOS debugging with xcodebuild.nvim:
-- 1. Use <leader>iI to configure project (select scheme/device)
-- 2. Use F5 to start debugging (or <leader>ir to build & run)
-- The executable path is automatically detected from DerivedData
